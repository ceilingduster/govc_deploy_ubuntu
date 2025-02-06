# Utilities to send an Ubuntu Template to a vSphere box.

## Grab govc

```sh
curl -L -o - "https://github.com/vmware/govmomi/releases/latest/download/govc_$(uname -s)_$(uname -m).tar.gz" | tar xvfz -
```

## Edit env variables

```sh
cp config.mk.sample config.mk
```

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

Clone the repository and set up ```config.mk```:

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

_Sit back, and grab a coffee._ ☕
```
