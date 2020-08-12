#!/bin/sh
#Erkan Yılmaz 
#date 11/02/2020

FREEBSD_PATH="/freebsd"
JENKINS_HOME_PATH="/jenkins_home"

##########################################
echo "instalation is starting"
apt-get install -y docker.io                #need for jenkins 
echo "docker instaled"
apt-get install -y virtualbox               #need for vagrant 
echo "virtual box instaled"
apt-get install -y vagrant                  #need for freebsd machine 
echo "vagrant  instaled"
############################################
                                            #this part can be change
apt-get install -y git                      #need for vagrantfile from git_repo
echo "git instaled"
mkdir -p $FREEBSD_PATH
cd $FREEBSD_PATH

GIT_PATH="http://stash.logo.com.tr/projects/SGT/repos/build-staj/browse/vagrant_config/Vagrantfile?at=refs%2Fheads%2Fbranc_build_staj"

if [0 !=$(git clone $GIT_PATH)]
then
    echo "cant find vagrant file check your vpn or githup repo"
    exit -1
else
    echo "vagrant file cloned"
fi
############################################
cd /
mkdir -p $JENKINS_HOME_PATH

docker pull jenkins:2.60.3
docker run -p 8080:8080 -p 50000:50000  -v $JENKINS_HOME_PATH:/var/jenkins_home  -d jenkins:2.60.3  
#sudo cat /jenkins_home/secrets
