
INIT()
{
  ## 1. SETUP 
  g++ --version       ## g++ (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
  cmake --version     ## cmake version 3.16.3
  clang++-9 --version ## clang version 9.0.1-12 
} 



INIT

ls
pwd

ROOT=${PWD}

cd physx 
ls
bash generate_projects.sh linux 
cd compiler/linux-release
ls

make -j install  

ls

pwd
cd $ROOT
pwd

cd /home/physx
ls 

ls install/linux/PhysX/*

## 
