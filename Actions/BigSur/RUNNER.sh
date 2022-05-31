## Patchs
## 1. True ->False
## physx/buildtools/presets/public/linux.xml

## 2. clang++-9 -> clang++
## physx/buildtools/cmake_generate_projects.py

## 3. -Wno-alloca -Wno-anon-enum-enum-conversion 
## physx/source/compiler/cmake/mac/CMakeLists.txt


PATCHES()
{
  cp Actions/BigSur/Patchs/linux.xml physx/buildtools/presets/public/linux.xml
  cp Actions/BigSur/Patchs/CMakeLists.txt physx/source/compiler/cmake/mac/CMakeLists.txt 
  cp Actions/BigSur/Patchs/cmake_generate_projects.py physx/buildtools/cmake_generate_projects.py
}


CHECK()
{
  ls 
  pwd 

  ## 1. SETUP 
  g++ --version       ## Apple clang version 12.0.0 (clang-1200.0.32.29)
  cmake --version     ## cmake version 3.23.2
  clang++ --version   ## Apple clang version 12.0.0 (clang-1200.0.32.29)
} 


PATCHES
CHECK

cd physx
bash generate_projects.sh linux 

ls -la compiler/linux-release
make -j -C compiler/linux-release/ install

ls -la install/linux/PhysX
ls -la bin/mac.x86_64/release/
