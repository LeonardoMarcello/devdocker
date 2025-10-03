# Start from docker image with ros-noetic
FROM osrf/ros:noetic-desktop-full

# ====================================================================
# 	SETUP USER
# ====================================================================
# Add "franka" user with same UID and GID as your host system 
# (copied from https://code.visualstudio.com/remote/advancedcontainers/add-nonroot-user#_creating-a-nonroot-user)
ARG USERNAME=franka
ARG USER_UID=1000
ARG USER_GID=$USER_UID
RUN groupadd --gid $USER_GID $USERNAME \
	&& useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
	&& apt-get update \
	&& apt-get install -y sudo \
	&& echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
	&& chmod 0440 /etc/sudoers.d/$USERNAME

# Add user to video group to allow acces to webcam
RUN sudo usermod --append --groups video $USERNAME

# Update all packages
RUN sudo apt update && sudo apt upgrade -y

# Install terminator
RUN sudo DEBIAN_FRONTEND=noninteractive apt-get install terminator -y 

# ====================================================================
# 	INSTALL CUDA DRIVERS (controllare)
# ====================================================================
#ENV CUDA_RUN http://developer.download.nvidia.com/compute/cuda/6_5/rel/installers/cuda_6.5.14_linux_64.run
#
#RUN apt-get update && apt-get install -q -y \
#  wget \
#  build-essential 
#
#RUN cd /opt && \
#  wget $CUDA_RUN && \
#  chmod +x *.run && \
#  mkdir nvidia_installers && \
#  ./cuda_6.5.14_linux_64.run -extract=`pwd`/nvidia_installers && \
#  cd nvidia_installers && \
#  ./NVIDIA-Linux-x86_64-340.29.run -s -N --no-kernel-module
#
#RUN cd /opt/nvidia_installers && \
#  ./cuda-linux64-rel-6.5.14-18749181.run -noprompt
#
# Ensure the CUDA libs and binaries are in the correct environment variables
#ENV LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-6.5/lib64
#ENV PATH=$PATH:/usr/local/cuda-6.5/bin

# ====================================================================
# 	INSTALL EXTERNAL LIBRARIES
# ====================================================================
# Add here additional standard libraries
RUN sudo apt install -y \
	nano \
	python3-pip \
	python3-catkin-tools\
	libserial-dev\
	curl \
	
# ====================================================================
# 	INSTALL InterRealsense LIBRARIES
# ====================================================================
RUN apt-get update && \
    sudo mkdir -p /etc/apt/keyrings && \
    curl -sSf https://librealsense.intel.com/Debian/librealsense.pgp | sudo tee /etc/apt/keyrings/librealsense.pgp > /dev/null && \
    echo "deb [signed-by=/etc/apt/keyrings/librealsense.pgp] https://librealsense.intel.com/Debian/apt-repo $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/librealsense.list > /dev/null \
    apt-get update && apt-get install -y \
    librealsense2-dkms \
    librealsense2-utils \
    
# ====================================================================
# 	INSTALL ROS LIBRARIES
# ====================================================================
# Add here additional ros-libraries
# - Franka Control Interface
# - MoveIt!
# - USB Camera
# - RealSense (??)
# - AprilTag
# - Vision_msgs (yolov7)
RUN sudo apt install -y\
	ros-noetic-rqt-multiplot \
	ros-noetic-libfranka \
	ros-noetic-franka-ros \
	ros-noetic-moveit \
	ros-noetic-usb-cam \
	ros-noetic-realsense2-camera \
	ros-noetic-apriltag-ros \
	ros-noetic-vision-msgs \
	ros-noetic-ros-control \
	ros-noetic-rqt-joint-trajectory-controller


# ====================================================================
# 	INSTALL PYTHON LIBRARIES
# ====================================================================
# Add here python libraries
RUN pip3 install --upgrade \
	numpy \
	scipy \
	tifffile \
	torch \
	torchvision \
	opencv-python \
	seaborn \
	thop \
	requests \
	tqdm \
	pyyaml \
	pyfiglet



# Remove temporary apt files to lower the image size.
# To use apt install command while running a container
# they must be added again with: sudo apt update 
# RUN sudo rm -rf /var/lib/apt/lists/*

# ====================================================================
# 	SETUP COMMAND
# ====================================================================
# switch from root to user
USER $USERNAME

#ENTRYPOINT catkin_make && source devel/setup.bash
#ENTRYPOINT ["source", "devel/setup.bash"]

