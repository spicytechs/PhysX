
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


DOCKER_RUN()
{
  docker run \
    --rm \
    --name ${CONTAINER_NAME} \
    --volume ${PWD}:/home \
    --workdir /home \
    -i ${IMAGE_NAME} \
    ${TOBEEXECUTED}
}


CONTAINER_NAME=nvcc_container
#IMAGE_NAME=nvcc_image 
IMAGE_NAME=${DUSERNAME}/${DREPOSITORY}:$(date +%s)

DUSERNAME
DPASSWORD

DOCKER_LOGIN

DOCKER_BUILD 

TOBEEXECUTED="ls -la"
DOCKER_RUN

TOBEEXECUTED="pwd"
DOCKER_RUN

TOBEEXECUTED="bash RUNNER.sh"
DOCKER_RUN

DOCKER_PUSH

#
# docker run --rm --name nvcc_container --volume ${PWD}:/home --workdir /home -i nvcc_image bash GET_NVCC.sh
#
