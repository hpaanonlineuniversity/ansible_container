#!/bin/bash
#configure.sh

##  ssh-keygen -t ed25519 -C 'devops' -f ~/Desktop/ansible_container/.ssh/ed25519
## notes student account is built in admin account at managed hosts

docker compose up -d --build

docker exec -it ansible_controller ansible all --list-hosts

docker exec -it ansible_controller bash -c 'echo " Please Enter password to create devop user at managed hosts"'

docker exec -it ansible_controller ansible all -u student -k -m user -a "name=devops state=present"

docker exec -it ansible_controller bash -c 'echo " Please Enter password to copy authorized public key to managed hosts"'

docker exec -it ansible_controller ansible all -u student -k -m authorized_key -a "user=devops key='{{ lookup('file', '/home/devops/.ssh/ed25519.pub') }}'"

docker exec -it ansible_controller bash -c 'echo " Please Enter password to create sudoer file at managed hosts"'

docker exec -it ansible_controller ansible all -u student -k -m copy -a "content='devops ALL=(ALL) NOPASSWD: ALL' dest=/etc/sudoers.d/devops" 

docker exec -it ansible_controller ansible all -m ping

docker compose down






