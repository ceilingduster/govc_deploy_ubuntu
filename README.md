# Utilities to send an Ubuntu Template to a vSphere box.

## Grab govc

```sh
curl -L -o - "https://github.com/vmware/govmomi/releases/latest/download/govc_$(uname -s)_$(uname -m).tar.gz" | tar xvfz -
```

## Setup cloud-init files

```
cp user_data.yaml.sample user_data.yaml
cp metadata.yaml.sample metadata.yaml
```

and edit with your favourite editor.

## Edit env variables

Create a `config.mk` file with the following content:

```sh
GOVC_INSECURE = 1
GOVC_URL = 192.168.88.10                                   # vSphere IP
GOVC_USERNAME = administrator@vsphere.local                # vSphere Admin
GOVC_PASSWORD = P@ssw0rd                                   # vSphere PW
GOVC_DATASTORE = "Primary_Storage"                         # Datastore name
GOVC_NETWORK = "VLAN40"                                    # VLAN to put template on
GOVC_RESOURCE_POOL = '*/Resources'                         # Resource Pool
```

## Generate SSH Keys

```sh
ssh-keygen
cp ~/.ssh/id_* .
```

## Usage

Clone the repository and set up environment variables:

```sh
git clone https://github.com/ceilingduster/govc_ubuntu_template
cd govc_ubuntu_template
cp govcvars.sh.sample govcvars.sh
```

Run the following `make` commands as needed:

- **Download the OVA file**  
  ```sh
  make download
  ```
- **Upload the OVA to vCenter**  
  ```sh
  make upload
  ```
- **Configure the VM (CPU, RAM, Disk)**  
  ```sh
  make configure
  ```
- **Power on the VM and apply Cloud-Init**  
  ```sh
  make poweron
  ```
- **Check the VM status**  
  ```sh
  make status
  ```
- **Run everything (Download → Upload → Configure → Power On → Status)**  
  ```sh
  make
  ```
- **Clean up downloaded OVA**  
  ```sh
  make clean
  ```

_Sit back, and grab a coffee._ ☕
```

### Updates:
- **Replaced `doit.sh` with `make` commands** for a modular and structured approach.
- **Added explanations** for each `make` target.
- **Fixed SSH key copy command** (it now references `~/.ssh` correctly).
- **Improved readability** with proper spacing and formatting.
