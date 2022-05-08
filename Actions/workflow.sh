
DOCKER_LOGIN() 
{
  docker login -u ${DUSERNAME} -p ${DPASSWORD}
}


DOCKER_PUSH() 
{
  docker push ${IMAGE_NAME}   
}


DOCKER_BUILD()
{
  docker build . \
    --file Dockerfile.ci \
    --tag $IMAGE_NAME  \
    > /dev/null 
}


DOCKER_IMAGES()
{
  IMAGE_ID=$(docker images --filter=reference=$IMAGE_NAME --format "{{.ID}}") 
  echo "IMAGE_ID:", $IMAGE_ID    
}


DOCKER_CP() 
{
  docker cp ./physx ${CONTAINER_NAME}:/home/
}


DOCKER_RUN_VOLUME()
{
  docker run \
    --rm \
    --name ${CONTAINER_NAME} \
    --volume ${DVOLUME}:/home \
    --workdir /home \
    -i ${IMAGE_NAME} \
    ${TOBEEXECUTED}
}


DOCKER_RUN()
{
  docker run \
    --rm \
    --name ${CONTAINER_NAME} \
    --workdir /home \
    -i ${IMAGE_NAME} \
    ${TOBEEXECUTED}
}


DPASSWORD=$1
DUSERNAME=$2
DREPOSITORY=$3
DVOLUME=$4

 
ls ${DVOLUME}
echo "DVOLUME:'${DVOLUME}'"

CONTAINER_NAME=physx_container
IMAGE_NAME=${DUSERNAME}/${DREPOSITORY}:$(date +%s)

DOCKER_LOGIN

DOCKER_BUILD 


echo "LS"
TOBEEXECUTED="ls -la"
DOCKER_RUN


TOBEEXECUTED="pwd"
DOCKER_RUN
echo "LS"


#DOCKER_CP 

TOBEEXECUTED="bash Actions/RUNNER.sh"
#DOCKER_RUN

#DOCKER_PUSH

#
# docker run --rm --name nvcc_container --volume ${PWD}:/home --workdir /home -i nvcc_image bash GET_NVCC.sh
#
