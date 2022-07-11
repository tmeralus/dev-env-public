#!/bin/bash
#####
#
# BEGIN INSTALLING DEV BASED PACKAGES
#
#####
echo "CONFIGURING ANSIBLE DIRS"
mkdir -p /home/$USER_NAME/github/ansible
mkdir -p /home/$USER_NAME/github/ansible/roles
mkdir -p /home/$USER_NAME/github/ansible/inventory
mkdir -p /home/$USER_NAME/temp
sudo touch /var/log/ansible.log
sudo chown $USER_NAME:$USER_NAME /var/log/ansible.log
sudo cp -R files/ansible/dev-hosts /home/$USER_NAME/github/ansible/inventory/dev
sudo touch /etc/ansible/ansible.cfg
sudo cp -R files/ansible/ansible.cfg /etc/ansible/ansible.cfg
sudo chown $USER_NAME:$USER_NAME -R /home/$USER_NAME/github/ansible/inventory/dev

echo "Install and configure minikube"  sleep 2 
if [ ! -f /usr/local/bin/minikube ];then
  curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
  chmod +x minikube-linux-amd64
  sudo mkdir -p /usr/local/bin/
  sudo mv minikube-linux-amd64 /usr/local/bin/minikube
fi

# install terraform
#echo "Installing TERRAFORM"
#curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
#sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
#sudo apt update && sudo apt-get install terraform

#INSTALL TFENV TERRAFORM MANAGER 
echo "INSTALLING TFENV TERRAFORM MANAGER"
git clone https://github.com/tfutils/tfenv.git ~/.tfenv
echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> ~/.bash_profile
mkdir -p ~/.local/bin/
. ~/.profile
ln -s ~/.tfenv/bin/* ~/.local/bin
echo "TEST THAT tfenv was installed"
which tfenv && sleep 10

#####
#
# FINISH INSTALLING DEV BASED PACKAGES
#
#####

