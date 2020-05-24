#!/bin/bash -xe
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
sudo apt-get update -y 
sudo apt install software-properties-common -y
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt install ansible -y
echo " 
---
- hosts: localhost
  become: yes
  become_user: root
  become_method: sudo
  tasks:

   -  name: install java
      apt:
        pkg:
        - openjdk-8-jdk

   -  name: key
      shell: wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -

   -  name: add key
      shell: sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

   -  name: update
      shell: sudo apt-get update -y

   -  name: install jenkins
      shell: sudo apt-get install jenkins -y

   -  name: start service
      shell: sudo systemctl start jenkins" > jenkins.yml
ansible-playbook jenkins.yml