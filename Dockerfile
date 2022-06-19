FROM golang:1.17.5 as builder

WORKDIR /code
COPY go.mod go.sum /code/
RUN go mod download

COPY . /code
RUN CGO_ENABLED=0 make build

FROM scratch

COPY --from=builder /code/bin/ipxedust-linux /ipxedust
EXPOSE 69/udp
EXPOSE 8080/tcp
ENV IPXE_TFTP_SINGLE_PORT=TRUE

ENTRYPOINT ["/ipxedust"]
