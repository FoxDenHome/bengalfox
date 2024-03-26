#!/bin/sh

docker stop hashtopolis-agent_gpu_1
docker stop nas_jellyfin_1

rmmod nvidia_uvm nvidia_drm nvidia_modeset nvidia
rmmod nvidia_uvm nvidia_drm nvidia_modeset nvidia
rmmod nvidia_uvm nvidia_drm nvidia_modeset nvidia
rmmod nvidia_uvm nvidia_drm nvidia_modeset nvidia

modprobe nvidia_uvm
modprobe nvidia_drm
modprobe nvidia_modeset
modprobe nvidia

docker start hashtopolis-agent_gpu_1
docker start nas_jellyfin_1
