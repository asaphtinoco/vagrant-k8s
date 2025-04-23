# 🐳 vagrant-k8s
A lightweight Vagrant setup for spinning up a virtual machine with Kubernetes pre-installed. Ideal for local development, testing, or learning Kubernetes in an isolated environment.This project simplifies the process of provisioning a VM that runs Kubernetes using Vagrant and VirtualBox, making it easy to get started without needing a cloud provider or complex setup.

## How to use

1. Save the script to a file, for example: `install_vagrant.sh`

2. Make the script executable:

```bash
chmod +x install_vagrant.sh
```

3. Run the script:

```bash
./install_vagrant.sh
```

## 🔧 Testing Bootstrap Scripts with This Setup

This Vagrant configuration provisions two Ubuntu 22.04 virtual machines using VirtualBox:

- **node1**: The main control node where Kubernetes and Rancher are installed.
- **node2**: A secondary node for simulating a multi-node setup.

Both nodes are provisioned with a shared script (`provision_common.sh`) for installing dependencies or applying common configuration.  
Additionally, `node1` runs an extra provisioning script (`provision_rancher.sh`) to install Rancher and expose ports 80 and 443 to your local machine (via ports 8080 and 8443).

## 👨‍💻 How to Test Your Bootstrap Code

You can easily test your own bootstrap scripts or infrastructure provisioning logic:

**Clone this repo:**

```bash
git clone https://github.com/asaphtinoco/vagrant-k8s.git
cd vagrant-k8s
```


## Modify the provision_common.sh or provision_rancher.sh scripts with your custom bootstrap logic
(e.g., installing additional tools, setting up networking, etc.).

```bash
vagrant up
```

## Access your nodes:
```bash
vagrant ssh node1
vagrant ssh node2
```

## Rancher UI (if included) is available at:
```bash
https://localhost:8443
```


## Destroy the environment when done:
```bash
vagrant destroy -f
```