Ansible - Host OS နှင့် Docker Container နှိုင်းယှဉ်ခြင်း
Host OS ပေါ်မှာ Ansible အသုံးပြုခြင်း
ကောင်းကျိုးများ:

    အလွယ်ကူဆုံး - Direct installation
    bash

# Ubuntu
sudo apt install ansible

# CentOS/RHEL
sudo yum install ansible

# macOS
brew install ansible

စက်အင်အားအပြည့် - Full system resources ကိုအသုံးချနိုင်

No network overhead - Docker networking မလို

Persistence - Configuration တွေပျောက်မသွား

Integration - Host system နဲ့တိုက်ရိုက်အလုပ်လုပ်
bash

# Host OS ရဲ့ features တွေကိုတိုက်ရိုက်သုံးနိုင်
ansible -i /etc/hosts ...

ဆိုးကျိုးများ:

    System pollution - Host OS မှာ package တွေစုပုံလာမယ်

    Version conflicts - Python version, library တွေကြားပြဿနာ

    No isolation - တခြား project တွေနဲ့ကြုံရင် conflict ဖြစ်နိုင်

    Dependency management ခက်ခဲ

Docker Container ထဲမှာ Ansible အသုံးပြုခြင်း
ကောင်းကျိုးများ:

    Isolation - သီးခြား environment
    dockerfile

# Dockerfile
FROM ubuntu:22.04
RUN apt update && apt install -y ansible

Clean environment - Host OS ကိုမထိခိုက်

Version control - Project တစ်ခုချင်းစီအတွက် version သီးသန့်
yaml

# docker-compose.yml
version: '3'
services:
  ansible-dev:
    image: ansible:2.15
  ansible-prod:
    image: ansible:2.9

Portability - ဘယ် machine မှာမဆို run လို့ရ

Quick setup/teardown - လွယ်ကူစွာစ/ရပ်နိုင်
bash

docker-compose up -d
docker-compose down

Testing different versions
bash

# Ansible 2.9
docker run --rm ansible:2.9 ansible --version

# Ansible 2.15
docker run --rm ansible:2.15 ansible --version

ဆိုးကျိုးများ:

    Network complexity - Docker networking ကိုနားလည်ရမယ်
    bash

# Host network သုံးရင်
docker run --network=host ansible-controller

# Bridge network သုံးရင်
docker network create ansible-net

File system access - Volume mount လုပ်ရမယ်
yaml

# docker-compose.yml
volumes:
  - ./ansible:/etc/ansible
  - ./inventory:/inventory
  - ~/.ssh:/root/.ssh  # SSH keys

    Performance overhead - Docker layer ကြောင့်နည်းနည်းနှေးနိုင်

    Learning curve - Docker ကိုနားလည်ရမယ်

ဥပမာ Use Cases
Case 1: Development Environment (Docker ကိုသုံးသင့်)
yaml

# docker-compose.yml - Developer အတွက်
version: '3'
services:
  ansible-dev:
    build:
      context: .
      dockerfile: Dockerfile.ansible
    volumes:
      - ./playbooks:/playbooks
      - ./inventory:/inventory
      - ~/.ssh:/home/ansible/.ssh
    networks:
      - ansible-network

Case 2: Production CI/CD (Docker ကိုသုံးသင့်)
yaml

# GitLab CI/CD
deploy:
  image: ansible/ansible:latest
  script:
    - ansible-playbook -i inventory deploy.yml

Case 3: Simple Management (Host OS ကိုသုံးသင့်)
bash

# Host OS ပေါ်မှာ direct run
ansible-playbook -i localhost, deploy.yml

