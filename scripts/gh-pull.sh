# pull multiple github repos using gh-cli
USER_NAME='tmeralus'
GIT_DIR="/home/$USER_NAME/github"
#GIT_DIR="/projects"
GIT_1019_DIR="${GIT_DIR}/1019studios"
GIT_ANSIBLE_DIR="${GIT_DIR}/ansible/roles"
GIT_DOCKER_DIR="${GIT_DIR}/docker"
GIT_GIMP_DIR="${GIT_DIR}/gimp"
GIT_MERCURY_DIR="${GIT_DIR}/mercury"
GIT_SCHOOL_DIR="${GIT_DIR}/school"
GIT_THEMES_DIR="${GIT_DIR}/code"
GIT_WEB_DIR="${GIT_DIR}/web"
GIT_WORK_DIR="${GIT_DIR}/work"
GIT_TEST_DIR="${GIT_DIR}/test"

echo "CREATING GITHUB DIRS"
if [ -d "$GIT_DIR" ];
then
  mkdir -p $GIT_1019_DIR
  mkdir -p $GIT_ANSIBLE_DIR
  mkdir -p $GIT_THEMES_DIR
  mkdir -p $GIT_DEVOPS_DIR
  mkdir -p $GIT_MERCURY_DIR
  mkdir -p $GIT_SCHOOL_DIR
  mkdir -p $GIT_WEB_DIR
#  mkdir -p $GIT_WORK_DIR
  mkdir -p $GIT_TEST_DIR
fi

echo "INSTALLING ANSIBLE REPOS"
while IFS='' read -r LINE || [ -n "${LINE}" ]; do
    gh repo clone tmeralus/${LINE} $GIT_ANSIBLE_DIR/${LINE}
done < scripts/git-repos/ansible.list

echo "INSTALLING CODE REPOS"
while IFS='' read -r LINE || [ -n "${LINE}" ]; do
    gh repo clone tmeralus/${LINE} $GIT_THEMES_DIR/${LINE}
done < scripts/git-repos/themes.list

echo "INSTALLING DEVOPS REPOS"
while IFS='' read -r LINE || [ -n "${LINE}" ]; do
    gh repo clone tmeralus/${LINE} $GIT_DEVOPS_DIR/${LINE}
done < scripts/git-repos/devops.list

echo "INSTALLING TEST REPOS"
while IFS='' read -r LINE || [ -n "${LINE}" ]; do
    gh repo clone tmeralus/${LINE} $GIT_TEST_DIR/${LINE}
done < scripts/git-repos/test.list

echo "INSTALLING WEB REPOS"
while IFS='' read -r LINE || [ -n "${LINE}" ]; do
    gh repo clone tmeralus/${LINE} $GIT_WEB_DIR/${LINE}
done < scripts/git-repos/web.list

echo "INSTALLING WORK REPOS"
while IFS='' read -r LINE || [ -n "${LINE}" ]; do
    gh repo clone tmeralus/${LINE} $GIT_DIR/${LINE}
done < scripts/git-repos/work.list

echo "INSTALLING GIMP REPOS"
while IFS='' read -r LINE || [ -n "${LINE}" ]; do
    gh repo clone tmeralus/${LINE} $GIT_WORK_DIR/${LINE}
done < scripts/git-repos/gimp.list

echo "INSTALLING MERCURY REPOS"
while IFS='' read -r LINE || [ -n "${LINE}" ]; do
    gh repo clone tmeralus/${LINE} $GIT_MERCURY_DIR/${LINE}
done < scripts/git-repos/mercury.list

echo "INSTALLING SCHOOL REPOS"
while IFS='' read -r LINE || [ -n "${LINE}" ]; do
    gh repo clone tmeralus/${LINE} $GIT_SCHOOL_DIR/${LINE}
done < scripts/git-repos/school.list

#echo "INSTALLING DND REPOS"
#while IFS='' read -r LINE || [ -n "${LINE}" ]; do
#    gh repo clone somediceguys/${LINE} $GIT_DND_DIR/${LINE}
#done < scripts/git-repos/dnd.list

#echo "INSTALLING 1019 REPOS"
#while IFS='' read -r LINE || [ -n "${LINE}" ]; do
#    gh repo clone 1019studios/${LINE} $GIT_1019_DIR/${LINE}
#done < scripts/git-repos/1019.list
