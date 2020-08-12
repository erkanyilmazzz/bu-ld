    
#!/bin/sh
#Erkan Yılmaz
#date 11/02/2020


#install all requarements
install_req(){

    echo "instalation is starting"
    sudo apt-get install -y docker.io || 
    { echo "error occurred while installing docker"; exit 1; }
    && echo "docker instaled"
    
    sudo apt-get install -y virtualbox || 
    { echo "error occurred while installing docker"; exit 1; }
    && echo "docker instaled"
    
    sudo apt-get install -y vagrant  || 
    { echo "error occurred while installing docker"; exit 1; }
    && echo "docker instaled"
    
    sudo apt-get install -y git || 
    { echo "error occurred while installing docker"; exit 1; }
    && echo "docker instaled"
    

}


#run a docker container(jenkins 2.60.3) in port 8080  
run_jenkins(){
    read -p "please enter a jenkins_home path" JENKINS_HOME_PATH
    echo "path is $JENKINS_HOME_PATH"
    mkdir -p $JENKINS_HOME_PATH
    sudo docker pull  jenkins:2.60.3
    sudo docker run -p 8080:8080 -p 50000:50000 -v $JENKINS_HOME_PATH:/var/jenkins_home -d  jenkins:2.60.3
    echo "you can find pasword in $JENKINS_HOME_PATH/secrets/initialAdminPassword"


}

run_vagrant(){

    read -p "please enter a path for vagrant freebsd" FREEBSD_PATH
    echo "vagrant path is $FREEBSD_PATH"


    mkdir -p $FREEBSD_PATH
    cd $FREEBSD_PATH

    #git path for vagrant config 
    #####asldında bunun yerine ssh kullanarak da servera indirebiliriz
    GIT_PATH="http://stash.logo.com.tr/projects/SGT/repos/build-staj/browse/vagrant_config/Vagrantfile?at=refs%2Fheads%2Fbranc_build_staj"

    if [0 !=$(git clone $GIT_PATH)]
        then
            echo "cant find vagrant file check your vpn or githup repo"
            exit -1
        else
            echo "vagrant file cloned"
    fi

    vagrant up

}

install_req
run_jenkins
run_vagrant
