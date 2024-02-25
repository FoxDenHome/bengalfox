#!/bin/sh

docker stop steam_steam-headless_1
docker stop hashtopolis-agent_agent_1
docker stop jupyter_notebook_1
docker stop nas_jellyfin_1

rmmod nvidia_uvm nvidia_drm nvidia_modeset nvidia
rmmod nvidia_uvm nvidia_drm nvidia_modeset nvidia
rmmod nvidia_uvm nvidia_drm nvidia_modeset nvidia
rmmod nvidia_uvm nvidia_drm nvidia_modeset nvidia

modprobe nvidia_uvm
modprobe nvidia_drm
modprobe nvidia_modeset
modprobe nvidia

docker start steam_steam-headless_1
docker start hashtopolis-agent_agent_1
docker start jupyter_notebook_1
docker start nas_jellyfin_1
