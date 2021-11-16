# pi-k3s-cluster

## Objectives

- rename fresh installed Pi nodes (relying on [insspb/ansible-role-hostname](https://github.com/insspb/ansible-role-hostname))
- reduce SD card wear out on the Pi nodes (relying on [ecdye/zram-config](https://github.com/ecdye/zram-config)) 
- deploy a simple k3s cluster on five Raspberry Pi nodes (relying on [k3s-io/k3s-ansible](https://github.com/k3s-io/k3s-ansible))
- mount a shared NFS folder on every node
- using a simple playbook


## Prerequisites

- local DNS already provisioned with cluster nodes' MAC addresses, IP and hostnames (in my case `pinode[0-4]`)
- Fresh Raspberry Pi OS Lite on the SD cards, SSH enabled, your SSH public key already deployed on these (Hint: use the [Raspberry Pi Imager](https://www.raspberrypi.com/software/), [Ctrl]+[Shift]+[X] to use advanced options, enable ssh and set your public key(s) in `authorized_keys` for 'pi' user)
- a shared NFS folder on a NAS or another server (future use: for containers' volumes)
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

Basic test, once cluster installed:

```bash
make test
```

Awaited result:
```
$ make test

kubectl get nodes
-----------------
NAME      STATUS   ROLES                  AGE   VERSION
pinode0   Ready    control-plane,master   36h   v1.22.3+k3s1
pinode4   Ready    <none>                 36h   v1.22.3+k3s1
pinode3   Ready    <none>                 36h   v1.22.3+k3s1
pinode2   Ready    <none>                 36h   v1.22.3+k3s1
pinode1   Ready    <none>                 36h   v1.22.3+k3s1

kubectl get pods -A
-------------------
NAMESPACE     NAME                                     READY   STATUS      RESTARTS      AGE
kube-system   helm-install-traefik-crd--1-h7xrp        0/1     Completed   0             36h
kube-system   helm-install-traefik--1-7ntvr            0/1     Completed   1             36h
kube-system   svclb-traefik-fr9jz                      2/2     Running     6 (10h ago)   36h
kube-system   metrics-server-9cf544f65-787g7           1/1     Running     3 (10h ago)   36h
kube-system   coredns-85cb69466-7c245                  1/1     Running     3 (10h ago)   36h
kube-system   svclb-traefik-scr9v                      2/2     Running     6 (10h ago)   36h
kube-system   svclb-traefik-f6nb9                      2/2     Running     6 (10h ago)   36h
kube-system   svclb-traefik-76qbh                      2/2     Running     6 (10h ago)   36h
kube-system   svclb-traefik-lcdjc                      2/2     Running     6 (10h ago)   36h
kube-system   traefik-74dd4975f9-wp4vx                 1/1     Running     3 (10h ago)   36h
kube-system   local-path-provisioner-64ffb68fd-hh5fg   1/1     Running     5 (10h ago)   36h

kubectl top node
----------------
NAME      CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%
pinode0   592m         14%    817Mi           84%
pinode1   195m         4%     271Mi           27%
pinode2   196m         4%     270Mi           27%
pinode3   104m         2%     273Mi           28%
pinode4   198m         4%     303Mi           31%

kubectl top pod -A
------------------
NAMESPACE     NAME                                     CPU(cores)   MEMORY(bytes)
kube-system   coredns-85cb69466-7c245                  7m           12Mi
kube-system   local-path-provisioner-64ffb68fd-hh5fg   1m           8Mi
kube-system   metrics-server-9cf544f65-787g7           14m          16Mi
kube-system   svclb-traefik-76qbh                      0m           1Mi
kube-system   svclb-traefik-f6nb9                      0m           1Mi
kube-system   svclb-traefik-fr9jz                      0m           0Mi
kube-system   svclb-traefik-lcdjc                      0m           1Mi
kube-system   svclb-traefik-scr9v                      0m           1Mi
kube-system   traefik-74dd4975f9-wp4vx                 1m           15Mi
```
