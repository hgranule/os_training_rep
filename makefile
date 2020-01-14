# Mac OS school 21 configure

NASM		= nasm

QKVM		= qemu-system-x86_64
QKVM_FLG	= -drive format=raw,file=$(IMAGE)

QIMG		= qemu-img
QIMG_SZ		= 10G
QIMG_FL		= -fraw
IMAGE		= /goinfre/disk.img

PATCH_P		= image_patch
PATCHER		= $(PATCH_P)/patcher.exe

BOOT_SOURCE	= boot_main.s
BOOT_BINARY	= boot.bin

all: $(PATCHER) $(IMAGE) $(BOOT_BINARY) patch launch

$(PATCHER):
	make -C $(PATCH_P)

$(IMAGE):
	$(QIMG) create $(QIMG_FL) $@ $(QIMG_SZ)

$(BOOT_BINARY): $(BOOT_SOURCE)
	$(NASM) -fbin $< -o $@

patch: $(BOOT_BINARY)
	$(PATCHER) $< $(IMAGE)

launch:
	$(QKVM) $(QKVM_FLG)