FROM ubuntu:focal 
RUN apt-get --yes -qq update 
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata
RUN apt-get --yes -qq update 

RUN apt-get --yes -qq install wget xz-utils
RUN apt-get --yes -qq install build-essential  
RUN apt-get --yes -qq install gcc g++  
RUN apt-get --yes -qq install cmake 
RUN apt-get --yes -qq install cmake-curses-gui ## ccmake 
RUN apt-get --yes -qq clean
RUN rm -rf /var/lib/apt/lists/*
