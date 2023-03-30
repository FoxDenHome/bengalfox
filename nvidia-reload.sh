#!/bin/sh

docker stop steam_steam-headless_1
docker stop jupyter_notebook_1
docker stop nas_plex_1

rmmod nvidia_uvm nvidia_drm nvidia_modeset nvidia
rmmod nvidia_uvm nvidia_drm nvidia_modeset nvidia
rmmod nvidia_uvm nvidia_drm nvidia_modeset nvidia
rmmod nvidia_uvm nvidia_drm nvidia_modeset nvidia

modprobe nvidia_uvm nvidia_drm nvidia_modeset nvidia

docker start steam_steam-headless_1
docker start jupyter_notebook_1
docker start nas_plex_1
