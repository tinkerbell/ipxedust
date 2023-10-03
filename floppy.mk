.DELETE_ON_ERROR: binary/ipxe-efi.img
binary/ipxe-efi.img: binary/ipxe.efi ## build ipxe-efi.img
	qemu-img create -f raw $@ 1440K
	sgdisk --clear --set-alignment=34 --new 1:34:-0 --typecode=1:EF00 --change-name=1:"IPXE" $@
	mkfs.vfat -F 12 -n "IPXE" --offset 34 $@ 1400
	mmd -i $@@@17K ::/EFI
	mmd -i $@@@17K ::/EFI/BOOT
	mcopy -i $@@@17K $< ::/EFI/BOOT/BOOTX64.efi
