
DOCKER_PUSH() 
{
  echo "[DOCKER_PUSH] ..."

  ## Go To: 
  ##       https://hub.docker.com/repository/docker/${DUSERNAME}/${DREPOSITORY}
  ##   

  docker commit ${CONTAINER_NAME} ${IMAGE_NAME2}
  docker push ${IMAGE_NAME2}   

  echo "[DOCKER_PUSH] DONE!"
}

DOCKER_LOGIN() 
{
  docker login -u ${DUSERNAME} -p ${DPASSWORD}
  echo "[DOCKER_LOGIN] DONE!"
}

DOCKER_BUILD() 
{
  echo "[DOCKER_BUILD] ..."
  
  DOCKERFILE="Actions/Dockerfile.binder"
  
  docker build . \
    --file ${DOCKERFILE} \
    --tag ${IMAGE_NAME}  \
    > /dev/null 

  echo "[DOCKER_BUILD] DONE!"
}


DOCKER_RUN_DETACHED()
{
  echo "[DOCKER_RUN_DETACHED] ..."
  
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
  echo "[DOCKER_RUN_DETACHED] DONE!"  
}


DOCKER_EXEC()
{
  echo "[DOCKER_EXEC] ..."

  echo "[${TOBEEXECUTED}] Runnnig ..."
  docker exec ${CONTAINER_NAME} ${TOBEEXECUTED}
  echo "[${TOBEEXECUTED}] Done!"
  
  echo "[DOCKER_EXEC] DONE!"  
}


DOCKER_COPY_TO_WORDIR()
{
  echo "[DOCKER_COPY] ..."
  
  echo "${TOBECOPIED} -> ${DOCKER_WORDIR}"
  docker cp \
  ${TOBECOPIED} \
  ${CONTAINER_NAME}:${DOCKER_WORDIR}
  
  echo "[DOCKER_COPY] DONE!" 
}


DOCKER_STOP() 
{ 
  #echo "[DOCKER_STOP]" 
  docker stop ${CONTAINER_NAME}
  echo "[DOCKER_STOP] DONE!"
}


## Input parameters 
DPASSWORD=$1      # DOCKER_HUB_TOKEN 
DUSERNAME=$2      # DOCKER_HUB_USERNAME
DREPOSITORY=$3    # DOCKER_HUB_REPOSITORY 

##
#DVOLUME=$4        # github.workspace   
DOCKER_WORDIR=/home/jovyan/work 

## Docker ... 
CONTAINER_NAME=mybinder_container
IMAGE_NAME=${DUSERNAME}/${DREPOSITORY}
IMAGE_NAME2=${DUSERNAME}/${DREPOSITORY}:last
#IMAGE_NAME2=${DUSERNAME}/${DREPOSITORY}:$(date +%s)

DOCKER_LOGIN ##
DOCKER_BUILD ##
DOCKER_RUN_DETACHED ## 

##
TOBECOPIED="Actions/RUNNER.sh"
DOCKER_COPY_TO_WORDIR

TOBEEXECUTED="ls -la"
DOCKER_EXEC

##
TOBECOPIED="externals"
DOCKER_COPY_TO_WORDIR

TOBECOPIED="kaplademo"
DOCKER_COPY_TO_WORDIR

TOBECOPIED="physx"
DOCKER_COPY_TO_WORDIR

TOBECOPIED="pxshared"
DOCKER_COPY_TO_WORDIR

TOBEEXECUTED="ls -la"
DOCKER_EXEC

## 
TOBEEXECUTED="bash RUNNER.sh"
DOCKER_EXEC

##
DOCKER_PUSH ## 
DOCKER_STOP ## 
