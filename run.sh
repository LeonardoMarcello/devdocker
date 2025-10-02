#!/bin/bash

# ------------------------------------------------------------
#	DEFINE PARAMS
# ------------------------------------------------------------
# Select docker image
DOCKER_IMAGE=franka
# Select user
DOCKER_USER=franka

# ------------------------------------------------------------
#	PARSE ARGUMENT
# ------------------------------------------------------------
# Check if a parameter is provided
# Note: parameters are descriminated with $1.
#	first parameters $0 is always the program name.
#	$@ iterate over all args
#	-z check if the string is empty
for arg in "$@"; do
    if [ "$arg" == "-h" ] || [ "$arg" == "--help" ]; then
    	# Print program option
	echo "devdocker - manager of a custom container for developing purpouse"
	echo ""
	echo "Usage: $0 [OPTIONS]"
	echo ""
	echo "Options:"
	echo "  -h, --help    Show this help message and exit"
    	echo "  -b, --build    Build image from Dokerfile"
	exit 1
    elif [ "$arg" == "-b" ] || [ "$arg" == "--build" ]; then	
    	# Build docker image	
    	$HOME/devdocker/build.sh	
	exit 1
    elif [ "$arg" == "-s" ] || [ "$arg" == "--setting" ]; then	
    	# Build docker image	
        nano "$0"   # <--- or use your favorite editor like code, vim, etc.
        exit 1
    fi
done

# Get the current directory
CURRENT_DIR=$(pwd)
# Select project workspace
PROJECT_NAME=$(basename "$PWD")
echo "Shared Directory: $CURRENT_DIR -> /home/${DOCKER_USER}/${PROJECT_NAME}"


# ------------------------------------------------------------
#	RUN CONTAINER
# ------------------------------------------------------------
# uncomment to grant permission to access server X to all user
# disable access control
xhost +

#run container
docker run \
	-it \
	--rm \
  	--cap-add=sys_nice \
  	--ulimit rtprio=99 \
  	--ulimit memlock=-1 \
	--runtime=nvidia --gpus all \
	--name ${PROJECT_NAME} \
	--privileged --network=host --ipc=host \
	--device=/dev/ttyACM0 \
	--device=/dev/ttyUSB0 \
	--device=/dev/video4 \
	-v /tmp/.X11-unix:/tmp/.X11-unix:rw --env DISPLAY=$DISPLAY \
	-v /home/$USER/.config/terminator:/home/${DOCKER_USER}/.config/terminator --env NO_AT_BRIDGE=1 \
	-v ~/.bash_history:/home/${DOCKER_USER}/.bash_history \
	-v $CURRENT_DIR:/home/${DOCKER_USER}/${PROJECT_NAME} \
	-w /home/${DOCKER_USER}/${PROJECT_NAME} \
	${DOCKER_IMAGE} 
	
# uncomment to remove permissions to acces server X to all users
# enable access control
xhost -
