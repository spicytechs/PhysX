## Patchs
## 1. True ->False
## physx/buildtools/presets/public/linux.xml

## 2. clang++-9 -> clang++
## physx/buildtools/cmake_generate_projects.py

## 3. -Wno-alloca -Wno-anon-enum-enum-conversion 
## physx/source/compiler/cmake/mac/CMakeLists.txt


CHECK()
{
  ls 
  pwd 

  ## 1. SETUP 
  g++ --version       ## Apple clang version 12.0.0 (clang-1200.0.32.29)
  cmake --version     ## cmake version 3.23.2
  clang++ --version   ## Apple clang version 12.0.0 (clang-1200.0.32.29)
} 

export PATH="$PATH:/Users/poderozita/Downloads/DOCKERs/PhysX/Cmake3232/CMake.app/Contents/bin"

CHECK
#exit 

cd physx

bash generate_projects.sh linux 

ls -la compiler/linux-release

#make -C compiler/linux-release/ 

#exit
make -j -C compiler/linux-release/ install

## HEADERS AND LIBRARIES 
ls -la install/linux/PhysX

## EXAMPLES 
ls -la bin/mac.x86_64/release/

##
