#!/bin/bash
#run.sh

docker compose up -d

docker exec -it ansible_controller ansible-playbook -u student -k playbooks/main.yml -i ./inventory/inventory

docker compose down


