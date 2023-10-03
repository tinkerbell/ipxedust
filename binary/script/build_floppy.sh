#!/usr/bin/env bash

set -eux


function dockerize() {
            docker run -it --rm -v "${PWD}":/code -w /code nixos/nix "$@"
}

function hasType() {
    if [ -z "$(type type)" ]; then
        echo "type command not found"
        return 1
    fi
}

function hasDocker() {
    if [ -z "$(type docker)" ]; then
        echo "docker command not found"
        return 1
    fi
}

function hasNixShell() {
    if [ -z "$(type nix-shell)" ]; then
        echo "nix-shell command not found"
        return 1
    fi
}

function hasUname() {
    if [ -z "$(type uname)" ]; then
        echo "uname command not found"
        return 1
    fi
}

# build_floppy will build the boot floppy image
function main() {
    local run_in_docker="$1"
    local nix_shell="$2"

    # check for prerequisites
    hasType
    hasNixShell
    hasUname
    local OS_TEST
    OS_TEST=$(uname | tr '[:upper:]' '[:lower:]')
    if [[ "${OS_TEST}" != *"linux"* ]]; then
        hasDocker
    fi

    if [ "${run_in_docker}" = true ]; then
            echo "running in docker"
            dockerize "$0" false "$2" "$3"
    else
        echo "running locally"
        nix-shell "${nix_shell}" --run "make -f floppy.mk $3"
    fi
}

main "$@"
