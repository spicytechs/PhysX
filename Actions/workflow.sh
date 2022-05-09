
DOCKER_PUSH() 
{
  echo "[DOCKER_PUSH] ..."

  ## Go To: 
  ##       https://hub.docker.com/repository/docker/${DUSERNAME}/${DREPOSITORY}
  ## 
  docker push ${IMAGE_NAME}   
}

DOCKER_LOGIN() 
{
  echo "[DOCKER_LOGIN] ..."
  docker login -u ${DUSERNAME} -p ${DPASSWORD}
}

DOCKER_BUILD() 
{
  echo "[DOCKER_BUILD] ..."
  
  DOCKERFILE="Actions/Dockerfile.ci"
  
  docker build . \
    --file ${DOCKERFILE} \
    --tag ${IMAGE_NAME}  \
    > /dev/null 
}


DOCKER_RUN_DETACHED()
{
  echo "[DOCKER_RUN_DETACHED] ..."

  DOCKER_WORDIR=/DUMMY
  
  CONTAINER_ID=$(
     docker run \
        --detach \
        --rm \
        --name ${CONTAINER_NAME} \
        --workdir ${DOCKER_WORDIR} \
        --interactive ${IMAGE_NAME} \
        ${TOBEEXECUTED}
  )
  
  docker ps -a
}


DOCKER_EXEC()
{
  echo "[DOCKER_EXEC] ..."

  echo "[$1] Runnnig ..."
  docker exec ${CONTAINER_NAME} $1
  echo "[$1] Done!"
}


DOCKER_COPY_TO_WORDIR()
{
  echo "[DOCKER_COPY] ..."

  DOCKER_WORDIR=/DUMMY

  docker cp \
  ${TOBECOPIED} \
  ${CONTAINER_NAME}:${DOCKER_WORDIR}
}


DOCKER_STOP() 
{ 
  echo "[DOCKER_STOP]" 
  ${docker stop ${CONTAINER_NAME}} 
}


## Input parameters 
DPASSWORD=$1      # DOCKER_HUB_TOKEN 
DUSERNAME=$2      # DOCKER_HUB_USERNAME
DREPOSITORY=$3    # DOCKER_HUB_REPOSITORY 

##
DVOLUME=$4        # github.workspace   

## Docker ... 
CONTAINER_NAME=physx_container
IMAGE_NAME=${DUSERNAME}/${DREPOSITORY}:$(date +%s)

DOCKER_LOGIN ##
DOCKER_BUILD ##
DOCKER_RUN_DETACHED ## 

TOBEEXECUTED="pwd"
DOCKER_EXEC $TOBEEXECUTED

TOBEEXECUTED="ls -la"
DOCKER_EXEC $TOBEEXECUTED

TOBECOPIED="LICENSE.md"
DOCKER_COPY_TO_WORDIR

TOBEEXECUTED="ls -la"
DOCKER_EXEC $TOBEEXECUTED

TOBEEXECUTED="bash Actions/RUNNER.sh"
#DOCKER_EXEC $TOBEEXECUTED

DOCKER_STOP ## 
#DOCKER_PUSH ## 


##
## docker run --rm --name nvcc_container --volume ${PWD}:/home --workdir /home -i nvcc_image bash GET_NVCC.sh
##

DOCKER_IMAGES()
{
  IMAGE_ID=$(docker images --filter=reference=$IMAGE_NAME --format "{{.ID}}") 
  echo "IMAGE_ID:", $IMAGE_ID    
}


DOCKER_CP() 
{
  CONTAINER_ID=$(docker create $IMAGE_NAME)
  docker cp ${DVOLUME}/LICENSE.md ${CONTAINER_ID}:/home
  docker rm -v $CONTAINER_ID  §§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
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
