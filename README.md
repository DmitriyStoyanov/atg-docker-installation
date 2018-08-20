Test of ATG installation in Docker using Ansible
=========

## Summary

This repository contains files for testing purposes of atg installation in docker using ansible playbooks

## Sample of usage:

```
# create bridge network for all containers
docker network create docker-network

# build local images
./docker-build.sh

# start of clean containers with only ssh server
docker run -d -h jboss --name jboss --net=docker-network local/ssh_docker
docker run -d -h atg --name atg --net=docker-network local/ssh_docker

# start container with ansible for testing purposes
docker run -it -h ansible --name ansible --net=docker-network local/ansible_docker

# Work in bash inside container
ansible --version
# ansible 2.6.2

# start ssh server
service sshd start

# check connection to ansible container
ansible ansible -m ping
# check connection to containers in atg group
ansible atg -m ping

# Install java/jboss/atg
ansible-playbook atg.yml
```