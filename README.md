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
docker run -d -h atg --name atg --net=docker-network local/ssh_docker

# start container with ansible for testing purposes
docker run -it -h ansible --name ansible --net=docker-network local/ansible_docker

# Then you can start
# work inside of container with bash

# Check ansible version
ansible --version
# ansible 2.6.2

# start ssh server
service sshd start

# check connection to ansible container
ansible ansible -m ping
# check connection to containers in atg group
ansible atg -m ping
# check connection to containers in jboss group
ansible jboss -m ping


# Install java/jboss/atg
ansible-playbook atg.yml

#logout
logout

# start container with oracle db
docker run -d --name oracle --name oracle --net=docker-network wnameless/oracle-xe-11g

# Copy ojdbc6.jar from oracle to atg container
docker cp oracle:/u01/app/oracle/product/11.2.0/xe/jdbc/lib/ojdbc6.jar ./
docker cp ojdbc6.jar atg:/opt/

# Copy script for creating users
docker cp create_db_users.sql oracle:/tmp/

# Create needed users on DB
docker exec -it oracle /bin/bash
su - oracle
sqlplus / as sydba
@/tmp/create_db_users.sql
logout
logout
logout

# Now you can create needed servers via CIM
docker cp batch-groovy.cim atg:/tmp/
docker exec -it atg /bin/bash
chown -R atg:atg /opt/jboss
su - atg
cd /opt/atg/ATG11.2/home/bin/
./cim.sh -batch /tmp/batch-groovy.cim
logout
logout

# start containers of atg environment
docker run -d -h store01 --name store01 --net=docker-network local/ssh_docker
docker run -d -h store02 --name store02 --net=docker-network local/ssh_docker
docker run -d -h bcc --name bcc --net=docker-network local/ssh_docker
docker run -d -h lock1 --name lock1 --net=docker-network local/ssh_docker
docker run -d -h lock2 --name lock2 --net=docker-network local/ssh_docker
docker run -d -h aux --name aux --net=docker-network local/ssh_docker
docker run -d -h endeca --name endeca --net=docker-network local/ssh_docker
docker run -d -h endeca-mdex1 --name endeca-mdex1 --net=docker-network local/ssh_docker
docker run -d -h endeca-mdex2 --name endeca-mdex2 --net=docker-network local/ssh_docker

```