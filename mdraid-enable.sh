#!/bin/sh

mdadm=/usr/sbin/mdadm

$mdadm --assemble --scan

#$mdadm --run --readwrite md0
$mdadm --run --readwrite md1
$mdadm --run --readwrite md2

exit 0
