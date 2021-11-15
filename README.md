# pi-k3s-cluster

## Objectives

- rename fresh installed Pi nodes 
- reduce SD card wear out on the Pi nodes (relying on [ecdye/zram-config](https://github.com/ecdye/zram-config)) 
- deploy a simple k3s cluster on five Raspberry Pi nodes (relying on [k3s-io/k3s-ansible](https://github.com/k3s-io/k3s-ansible))
- using a simple playbook


## Prerequisites

- local DNS already provisioned with cluster nodes' MAC addresses, IP and hostnames (in my case `pinode[0-4]`)
- Fresh Raspberry Pi OS Lite on the SD cards, SSH enabled, your SSH public key already deployed on these  (Hint: use the [Raspberry Pi Imager](https://www.raspberrypi.com/software/), [Ctrl]+[Shift]+[X] to use advanced options, enable ssh and to set your public key(s) in `authorized_keys` for 'pi' user)
- a recent [Ansible](https://docs.ansible.com/ansible/latest/index.html), [Kubectl](https://kubernetes.io/fr/docs/tasks/tools/install-kubectl/) and GNU Make installed on your computer

## Howto

```bash
# Fast information
make

# Edit inventory 
# [...]

# Run the playbook
make deploy
```