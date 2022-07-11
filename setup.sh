#!/bin/bash
# author: username
# Bash script to setup my dev environment for fresh installs
INSTALL='sudo apt install -y'
SNAP_INSTALL='sudo snap install'
UPDATE="sudo apt update -y"
CLEAN="sudo apt clean" 
USER_NAME='username'
USER_EMAIL="username@gmail.com"
TOKEN="token" # gh-cli / github token required for pulling github repos
PROJECT_DIR='/projects'
APT_PKG_LIST=(build-essential docker docker-compose gnome-tweaks snapd texlive-font-utils)
PKG_LIST=(autoconf automake cmake curl elinks git gparted ffmpeg gvfs magic-wormhole nano ncdu ncureutils rses-hexedit net-tools neofetch openssl policycopython3 pre-commit python3-pip ranger ripgrep rsync rsyslog samba-common snapd snmpd steam vim vlc wget xclip youtube-dl yt-dlp)
SNAP_PKG_LIST=(code gimp k9s kubectl slackteams zoom-client)

for i in "$@"
do
  case "$1" in
    -a | --alias )
      cp bash_aliases /home/$USER_NAME/.bash_aliases 
      source ~/.bashrc
      echo "${GREEN} Aliases have been updated" 
      exit
      ;;
    -g | --git )
      sh scripts/git.sh  
      echo "SETUP GITHUB CLI" && sleep 3
      exit
      ;;      
    -h | --help)
      "This is a script for setting up a new dev environment"
      exit 2
      ;;
    -w | --work )
      echo "SETUP WORK PACKAGES" && sleep 5
      sh scripts/work.sh  
      exit
      ;; 
    --)
      shift;
      break
      ;;
    *)
      echo "Unexpected option: $1"
      ;;
  esac
done 


echo "SETTING UP DEV ENVIRONMENT" && sleep 2
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Not running as root"
    exit
fi

# Setup Bash aliases 
echo "Setting up bash aliases" && sleep 2
cp bash_aliases /home/$USER_NAME/.bash_aliases 

echo "setup crontab script" && sleep 3
cp scripts/cron-cleantrash /etc/cron.d/cron-cleantrash
echo "check cron.d dir"
ls /etc/cron.d/ && sleep 3
cp scripts/cron-cleantrash.sh /home/$USER_NAME/cron-cleantrash.sh
echo "sudo crontab clean trash on reboot" && sleep 3
sudo crontab @reboot bash /home/$USER_NAME/cron-cleantrash.sh 
echo "checking crontab"
sudo crontab -l

echo "Configure Sudoers" && sleep 2
sudo cp files/sudo /etc/sudoers.d/sudo
echo "check sudoers" && sleep 2
sudo cat /etc/sudoers.d/sudo && sleep 2

#INSTALL DEBIAN/UBUNTU PACKAGES 
echo "INSTALLING PACKAGE BASE" && sleep 4
for i in ${APT_PKG_LIST[@]}; do
  $INSTALL $i 
done  

#INSTALL LINUX PACKAGES 
echo "INSTALLING MISC PACKAGES" && sleep 4
for i in ${PKG_LIST[@]}; do
  $INSTALL $i 
done  

echo "UPDATE"
$UPDATE
$CLEAN 

echo "INSTALL SNAP PACKAGES" && sleep 3
#INSTALL SNAP PACKAGES
for i in ${SNAP_PKG_LIST[@]}; do
  $SNAP_INSTALL $i --classic
done 
 
echo "SETTING GLOBAL GIT VARIABLES" && sleep 2
git config --global user.name $USER_NAME
git config --global user.email $USER_EMAIL
git config --global core.editor vim

echo "Update pip in python3"
python3 -m pip install --user --upgrade pip 
echo "INSTALL PYTHON PACKAGES" && sleep 2
pip3 install -r requirements.txt

echo "SETUP AND ENABLE DOCKER" 
sudo usermod -aG docker $USER
sudo systemctl enable docker
sudo systemctl start docker

echo "COPYING WALLPAPER TO PICTURES DIR" && sleep 3
# photos and wallpaper
rsync -arv files/photos/* /home/$USER_NAME/Pictures/

echo "create temp dirs" sleep 2
mkdir -p /home/$USER_NAME/temp
sudo mkdir -p $PROJECT_DIR 
sudo chown $USER_NAME:$USER_NAME -R $PROJECT_DIR 

echo "SETUP WORK PACKAGES" && sleep 5
sh scripts/work.sh

echo "SETUP GITHUB CLI" && sleep 3
sh scripts/git.sh

echo "SCRIPT COMPLETED!!"
echo "test by exiting this terminal"
echo "and checking aliases"
