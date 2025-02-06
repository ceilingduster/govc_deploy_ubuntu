OVA_URL=https://cloud-images.ubuntu.com/releases/24.04/release/ubuntu-24.04-server-cloudimg-amd64.ova
OVA_FILE=ubuntu-24.04-server-cloudimg-amd64.ova
VM_NAME=Ubuntu2404Template

include config.mk

HDD_SIZE = 60G

.PHONY: all download upload configure poweron status

all: download upload configure poweron status

download:
	@if [ ! -f "$(OVA_FILE)" ]; then \
		echo "Downloading OVA file..."; \
		wget "$(OVA_URL)"; \
	else \
		echo "OVA file already exists, skipping download."; \
	fi

upload: download
	@echo "Uploading OVA to vCenter..."
	govc import.ova -options=ubuntu.json "$(OVA_FILE)"

config: configure
configure:
	@echo "Configuring VM..."
	govc vm.change -vm $(VM_NAME) -c 4 -m 16384 -e="disk.enableUUID=1"
	govc vm.disk.change -vm $(VM_NAME) -disk.label "Hard disk 1" -size $(HDD_SIZE)

poweron:
	@echo "Powering on VM..."
	govc vm.power -on=true $(VM_NAME)

status:
	@echo "Checking VM status..."
	govc vm.info $(VM_NAME)
	@echo "You may need to wait and rerun make status several times before IP address shows up."

delete:
	@echo "Deleting VM $(VM_NAME)..."
	govc vm.destroy $(VM_NAME)

destroy: delete
