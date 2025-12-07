#!/bin/bash
#configure.sh

docker compose up -d --build

docker exec -it ansible_controller ansible all --list-hosts

docker exec -it ansible_controller bash -c 'echo " Please Enter root password to copy authorized public key to managed hosts"'

docker exec -it ansible_controller ansible all -u student -k -m authorized_key -a "user=student key='{{ lookup('file', '/home/student/.ssh/ed25519.pub') }}'"

# Update known_hosts for each host
docker exec -it ansible_controller bash -c 'for host in svr01 svr02 svr03;  do ssh-keyscan -H $host >> ~/.ssh/known_hosts; done'

docker exec -it ansible_controller ansible all -m ping

docker compose down



## echo " Please Enter root password to create user at managed hosts"
## ansible all -m user -a "name=matthews state=present" -u root -k
## echo " Please Enter root password to copy authorized public key to managed hosts"
## ansible all -m authorized_key -a "user=matthews key='{{ lookup('file', '/home/matthews/.ssh/id_rsa.pub') }}'" -u root -k
## echo " Please Enter root password to create sudoer file at managed hosts"
## ansible all -m copy -a "content='matthews ALL=(ALL) NOPASSWD: ALL' dest=/etc/sudoers.d/matthews" -u root -k



