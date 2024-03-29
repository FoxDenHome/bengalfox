#!/bin/bash
set -xe

modprobe nvidia_uvm nvidia_drm nvidia_modeset nvidia || true
sleep 1

export DISPLAY=':0'
/usr/lib/xorg/Xorg vt8 -config /opt/docker/steam/xorg.conf -noreset -novtswitch -sharevts -dpi 96 +extension GLX +extension RANDR +extension RENDER +extension MIT-SHM "$DISPLAY" &
sleep 1

nvidia-smi -pm 1
sleep 0.1
nvidia-settings -a 'GPUMemoryTransferRateOffsetAllPerformanceLevels=0' -a 'GPUFanControlState=0' -a 'GPUPowerMizerMode=0'
sleep 0.1
nvidia-settings -a 'GPUMemoryTransferRateOffsetAllPerformanceLevels=1000' -a 'GPUFanControlState=1' -a 'GPUTargetFanSpeed=100' -a 'GPUPowerMizerMode=1'
sleep 0.1
nvidia-settings -q 'GPUMemoryTransferRateOffsetAllPerformanceLevels' -q 'GPUFanControlState' -q 'GPUCurrentFanSpeed' -q 'GPUTargetFanSpeed' -q 'GPUPowerMizerMode'
sleep 0.1
nvidia-smi -pm 0
sleep 0.1

killall Xorg
wait
