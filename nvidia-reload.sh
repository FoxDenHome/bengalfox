#!/bin/sh

docker stop hashtopolis-agent-gpu-1
docker stop nas-jellyfin-1
docker stop ollama-ollama-1

rmmod nvidia_uvm nvidia_drm nvidia_modeset nvidia
rmmod nvidia_uvm nvidia_drm nvidia_modeset nvidia
rmmod nvidia_uvm nvidia_drm nvidia_modeset nvidia
rmmod nvidia_uvm nvidia_drm nvidia_modeset nvidia

modprobe nvidia_uvm
modprobe nvidia_drm
modprobe nvidia_modeset
modprobe nvidia

docker start hashtopolis-agent-gpu-1
docker start nas-jellyfin-1
docker start ollama-ollama-1
