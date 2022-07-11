# BASH ALISES FOR DEV ENVIRONMENT 
#setting color to bash 
force_color_prompt=yes
color_prompt=yes 
alias less='less --RAW-CONTROL-CHARS'
export LS_OPTS='--color=auto'
alias ls='ls ${LS_OPTS}'
export TERM=xterm-color
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
#export CLICOLOR=1
#export LSCOLORS=ExFxCxDxBxegedabagacad 
# set colors in terminal
export TERM=xterm-256color
# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
#A list of color codes
#Color 	Code
#Black 	0;30
#Blue 	0;34
#Green 	0;32
#Cyan 	0;36
#Red 	0;31
#Purple 0;35
#Brown 	0;33
# 
#\u - user name
#\h - short hostname
#\W - current working dir
#\? - exit status of the command
export PS1="{\[\e[32m\]\u\[\e[m\]@\[\e[36m\]\h\[\e[m\]:\W_\$?}$ "
# set vim as default editor 
export EDITOR=vim
# Color Options 
export NC='0' # No Color
export BLACK='0;30'
export GRAY='1;30'
export RED='0;31'
export LIGHT_RED='1;31'
export GREEN='0;32'
export LIGHT_GREEN='1;32'
export BROWN='0;33'
export YELLOW='1;33'
export BLUE='0;34'
export LIGHT_BLUE='1;34'
export PURPLE='0;35'
export LIGHT_PURPLE='1;35'
export CYAN='0;36'
export LIGHT_CYAN='1;36'
export LIGHT_GRAY='0;37'
export WHITE='1;37'

# alias shortcuts 
alias logs='journalctl -f'
alias end-logs='journalctl -xe'
alias start='systemctl start'
alias stop='systemctl stop'
alias status='systemctl status'
alias restart='systemctl restart'
alias update-bashrc='cp /home/username/github/dev-environment/bash_aliases /home/username/.bash_aliases'
alias update-alias='source ~/.bashrc'
alias campfire='aafire -driver curses'
alias check-moon='curl wttr.in/Moon'
alias check-weather='curl wttr.in'
alias crypto-rates='curl rate.sx' 
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias install='sudo apt install -y'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls --color=auto'
alias cdans='cd /home/username/github/ansible'
alias p3='python3'
alias p3p='python3 -m pip'
alias samba-deps='cd /run/user/1000/gvfs/smb-share:server=brain,share=departments'
alias search='apt-cache search'
alias start-matrix='cmatrix'
alias tartar='tar -zxvf'
alias update='sudo apt-get update'
alias update-bashrc='source ~/.bashrc' 
alias upgrade='sudo apt-get upgrade -y'
alias dush='du -sh *'
alias dusort='du -sh * | sort -h'
# kubernetes shortcut 
alias k='kubectl'
alias mk='minikube'

# Add git branch if its present in working dir
parse_git_branch () {
 git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
if [ "$color_prompt" = yes ]; then
 PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;31m\]$(parse_git_branch)\[\033[00m\]\$ '
else
 PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(parse_git_branch)\$ '
fi
#unset color_prompt force_color_prompt

###############################
# DOCKER ALIASES 
###############################

# Docker Shortcuts  
alias dcps='sudo docker ps'
alias dci='sudo docker images'
alias dcvls='sudo docker volume ls'
alias dcnls='sudo docker network ls'
alias dck='docker rmi -f $(docker images -a -q)'
alias dcstop='sudo docker stop $(docker ps -a -q)'
alias dcom='docker-compose'
alias dcu='docker-compose up -d'
alias dcd='docker-compose down'
alias dcl='docker-compose logs'
alias dckb='docker-compose build'
alias dcub='docker-compose up --build'
alias dcvp='docker volume prune -f'
alias dcnp='docker network prune -f'
alias dcrmi='docker rmi -f $(docker images -a -q)' 

dcc () {
  # The function will
  #  - first stop all running containers (if any),
  #  - remove containers
  #  - remove images
  #  - remove volumes

  # stop all running containers
  echo '####################################################'
  echo 'Stopping running containers (if available)...' 
  echo '####################################################'
  docker stop $(docker ps -aq) $$ sleep 1

  # remove all stopped containers
  echo '####################################################'
  echo 'Removing containers ..'
  echo '####################################################'
  docker rm $(docker ps -aq)  $$ sleep 1


  # remove all images
  echo '####################################################'
  echo 'Removing images ...'
  echo '####################################################'
  docker rmi $(docker images -q)  $$ sleep 1

  # remove all stray volumes if any
  echo '####################################################'
  echo 'Revoming docker container volumes (if any)'
  echo '####################################################'
  docker volume rm $(docker volume ls -q)  $$ sleep 1

}

###############################
# GIT ALIASES 
###############################
#alias gcm='git commit -m'
gitdefaultbranch () { #noface
  local gitbranch=$(git branch -a)
  if [[ $gitbranch == *"origin/HEAD -> origin/main"* ]]; then
    echo "main"
  else
    echo "master"
  fi
}

# update all git repo's in github dir
gpall () {
  cd /home/username/github/
  find . -mindepth 1 -maxdepth 1 -type d -print -exec git -C {} pull \;
  cd -
} 

function gcm() {
  git checkout $(gitdefaultbranch)
}

# create new branch
gnb () {
  branchName=$1
  git checkout -b $branchName
  git push --set-upstream origin $branchName
} 

# delete branch
gdb () {
  branchName=$1
  git branch -d $branchName
  git push origin --delete $branchName
}

# delete branch and return to master or main
gdbm () {
  local branches=$(git branch)
  local top=$(gitdefaultbranch)
  local oldbranch=$(git rev-parse --abbrev-ref HEAD)
  if [[ $oldbranch == $top ]]; then
    echo "${RED}current branch is $top, exiting...${NOCOLOR}"
    return
  fi
  git checkout $top
  git pull
  gdb $oldbranch
}

# create pull request from current branch to target branch, default to master
gpr () {
  local target=$1
  if [[ $target == "" ]]; then
    target=$(gitdefaultbranch)
  fi
  local currentbranch=$(git branch --show-current)
  local prstatus=$(gh pr status)
  local currentbranchstatus=$(echo $prstatus | rg -i "$currentbranch")
  if [[ $currentbranchstatus == *"Merged"* || $prstatus == *"There is no pull request associated with [$currentbranch]"* ]]; then
    echo "${BLUE}[ creating pull request... ]${NOCOLOR}"
    gh pr create --base $target --fill
    local prurl=$(getprurl $currentbranch)
    echo -n $prurl | pbcopy
    echo "${YELLOW}copied to clipboard${NOCOLOR}"
  else
    echo "${BLUE}[ pull request already exists ]${NOCOLOR}"
    local prurl=$(getprurl $currentbranch)
    echo "pr url: $prurl"
    echo -n $prurl | pbcopy
    echo "${YELLOW}copied to clipboard${NOCOLOR}"
  fi
}

# git add and commit
gcom () {
  local msg=${1}
  if [[ $msg == "" ]]; then
    echo "Missing commit message. Exiting..."
    return
  else
    echo "Running command: ${BLUE}git add . ${NOCOLOR}&&${GREEN} git commit -m \"${YELLOW}$msg${GREEN}\"${NOCOLOR}"
    echo "[ ${BLUE}GIT ADD${NOCOLOR} ]"
    git add .
    git status
    echo "[ ${GREEN}GIT COMMIT${NOCOLOR} ]"
    git commit -m "$msg"
    echo "[ ${GREEN}GIT COMMIT STATUS${NOCOLOR} ]"
    git status 
    echo "pushing code"  && sleep 5
    git push
  fi
}

# search and list all repos that match the filters
grls () {
  local searchCMD="gh repo list username -L 1000 --no-archived"
  for var in ${1}
  do
    local add=" | rg -i --fixed-strings --color=never '$var' "
    if [[ $var == *"-"* ]]; then
      local add=" | rg -i --color=never -e '$var' "
    fi
    searchCMD="$searchCMD$add"
  done
  echo "${YELLOW}searching for repositories...${NOCOLOR}"
  local found=$(eval $searchCMD)
  echo "${GREEN}[ found ]: ${NOCOLOR}"
  local parts=("${(@f)found}")
  for repo in $parts
  do
    local name=${repo%%$'\t'*}
    echo $name
  done
}

# search repos in github using filter and clone to local
grclone () {
  local args=(${1})
  local searchCMD="gh repo list username -L 1000 --no-archived"
  if [[ $1 == "--no-tf" ]]; then
    args=(${2})
    searchCMD="$searchCMD | rg -v -e '-tf'"
  fi
  for arg in $args
  do
    local add=" | rg -i --fixed-strings --color=never '$arg' "
    if [[ $arg == *"-"* ]]; then
      local add=" | rg -i --color=never -e '$arg' "
    fi
    searchCMD="$searchCMD$add"
  done
  echo "${YELLOW}searching for repositories...${NOCOLOR}"
  local found=$(eval $searchCMD)
  if [[ $found == "" ]]; then
    echo "${RED}no matching projects found, exiting...${NOCOLOR}"
    return
  fi
  local first=$(head -1 <<< $found)
  local firstname=${first%%$'\t'*}
  echo "${GREEN}[ found ]:${NOCOLOR}"
  local parts=("${(@f)found}")
  for repo in $parts
  do
    local name=${repo%%$'\t'*}
    for filter in $range
    do
      name=${name/$filter/"${RED}$filter${NOCOLOR}"}
    done
    echo $name
  done
  echo -n "${BLUE}do you want to clone: [ ${YELLOW}$firstname${BLUE} ]: ${NOCOLOR}"
  read -k1
  if [[ ${REPLY} == $'\n' ]]; then
    echo "${GREEN}[ cloning ]: ${NOCOLOR}${YELLOW}$firstname${NOCOLOR}" 
  else
    echo "${RED}\ncancelling clone...${NOCOLOR}"
  fi
}

###############################
# MISC ALIASES 
###############################

# remove spaces from files in current dir
clearspaces-file () {
  find . -name "* *" -type d | rename 's/ /_/g'
}

# remove spaces from directories in current dir
clearspaces-dir () { 
  find . -name "* *" -type f | rename 's/ /_/g'
}

# generate vipaccess code and copy to clipboard
vipcp () {
  local code=$(vipaccess)
  echo -n $code | pbcopy
  echo "[ ${YELLOW}$code${NOCOLOR} ]: vipaccess code copied to clipboard"
}

# search and get projects that match the provided filters
listp () {
  local args=(${1})
  if [[ $args == "" ]]; then
    echo "search filter missing..."
  else
    local color="always"
    if [[ $1 == *"--no-color"* ]]; then
      args=(${2})
      color="never"
    fi
    local searchCMD="ls $PROJECT_PATH"
    for arg in $args
    do
      local add=" | rg -i --fixed-strings --color=$color '$arg' "
      if [[ $arg == *"-"* ]]; then
        local add=" | rg -i --color=$color -e '$arg' "
      fi
      searchCMD="$searchCMD$add"
    done
    local found=$(eval $searchCMD)
    if [[ $found == "" ]]; then
      echo "${RED}failed to find matching projects...${NOCOLOR}"
    else
      echo "${GREEN}[ found ]:${NOCOLOR}"
      echo $found
    fi
  fi
}

# search the projects directory that match the filter and cd into the result
cdpr () {
  local searchCMD="ls $PROJECT_PATH"
  for var in ${1}
  do
    searchCMD="$searchCMD | rg -i --fixed-strings '$var'"
  done
  local found=$(eval $searchCMD)
  local first=$(head -1 <<< $found | sed -E "s/"$'\E'"\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K]//g")
  cd $PROJECT_PATH/$first
}

# show currently used colors
showcolors () {
  local colors=$(cat ${HOME}/.bashrc | rg "033\[")
  colors=("${(@f)colors}")
  for color in $colors
  do
    local code=${color##*"["}
    code=${code%%"\""*}
    local name=${color%%"="*}
    name=${name##*"export "}
    echo -n "\033[${code}$name : ${NOCOLOR}"
    echo -n "$code : "
    echo "\033[${code}the quick brown fox jumps over the lazy dog${NOCOLOR}"
  done
}

# print all available colors
coloropts () {
  for i in {0..10}
  do
    local code="38;5;${i}m"
    echo -n "$code : "
    echo "\033[${code}the quick brown fox jumps over the lazy dog${NOCOLOR}"
  done
}
 

