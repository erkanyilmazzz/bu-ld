  
#!/bin/sh
#Erkan Yılmaz
#date 11/02/2020


#install all requarements
install_req(){

    echo "instalation is starting"
    sudo apt-get install -y docker.io || { echo "error occurred while installing docker"; exit 1; }
    
    sudo apt-get install -y virtualbox || { echo "error occurred while installing virtualbox"; exit 1; }
    
    sudo apt-get install -y vagrant  || { echo "error occurred while installing vagrant "; exit 1; }

    sudo apt-get install -y git || { echo "error occurred while installing git"; exit 1; }
    
}


#run a docker container(jenkins 2.60.3) in port 8080  
run_jenkins(){
    JENKINS_HOME_PATH="/home/erkan/jenkins_home"
    echo "path is $JENKINS_HOME_PATH"
    mkdir -p $JENKINS_HOME_PATH
    sudo docker pull  jenkins:2.60.3
    sudo docker run -p 8080:8080 -p 50000:50000 -v $JENKINS_HOME_PATH:/var/jenkins_home -d  jenkins:2.60.3
    echo "you can find pasword in $JENKINS_HOME_PATH/secrets/initialAdminPassword"


}

run_vagrant(){

    FREEBSD_PATH="/home/erkan/vagrant_freebsd"
    echo "vagrant path is $FREEBSD_PATH"


    mkdir -p $FREEBSD_PATH
    cd $FREEBSD_PATH

    #git path for vagrant config 
    #####asldında bunun yerine ssh kullanarak da servera indirebiliriz
    GIT_PATH="http://stash.logo.com.tr/projects/SGT/repos/build-staj/browse/vagrant_config/Vagrantfile?at=refs%2Fheads%2Fbranc_build_staj"

    git clone $GIT_PATH ||{echo "cant clone";exit 1;}
    
    vagrant up

}

install_req
run_jenkins
run_vagrant
