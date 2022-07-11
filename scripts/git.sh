# Script to use and authenticate github-cli
# input gh token

# SETUP AND INSTALL GH CLI
echo "SET GH TOKEN"
touch scripts/mytoken.txt

if ! [ -x "$(command -v gh)" ]
then
  echo "APT package distro found" ##&& sleep 2
  echo "setup and install github-cli"
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
  sudo apt update
  sudo apt install gh
  sudo apt clean
  echo "USING GH-CLI TO AUTHENTICATE" && sleep 4
  echo $TOKEN > /tmp/clitoken
  gh auth login --with-token /tmp/ghcli-token
else
  echo "GH-CLI package already installed"
  echo "Skipping APT Setup"
  echo "USING GH-CLI TO AUTHENTICATE" && sleep 4
  gh auth login --with-token /tmp/ghcli-token
fi

# CONFIGURE GH-CLI GLOBAL VARS
echo "setting up config variables"
gh config set editor vim
gh config set editor "code --wait"
gh config set git_protocol ssh --host github.com
gh config set prompt disabled



# PULL GITHUB REPOS
echo "PULL GITHUB REPOS WITH GH-CLI" && sleep 10
sh scripts/gh-pull.sh


# clear gh token to prevent saving to git repo
echo "Clearing gh auth token"
echo "gh auth token goes here" > scripts/mytoken.txt
