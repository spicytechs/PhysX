
CHECK()
{
  ## 1. SETUP 
  g++ --version       ## g++ (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
  cmake --version     ## cmake version 3.16.3
  clang++-9 --version ## clang version 9.0.1-12 
} 


CHECK

cd physx

bash generate_projects.sh linux 

ls -la compiler/linux-release

make -j -C compiler/linux-release/ install

## HEADERS AND LIBRARIES 
ls -la install/linux/PhysX

## EXAMPLES 
ls -la bin/linux.clang/release

##
