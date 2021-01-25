#!/bin/bash 

# Enable X share if required (required on Xubuntu 20.04)
xhost +

# Build the image described in the Dockerfile
sudo docker build --tag ubuntu-pyspice .

# Run docker with X forwarding
sudo docker run -it \
    --net=host -e DISPLAY -v /tmp/.X11-unix \
    ubuntu-pyspice 

# Reset X share to standard setting
xhost -