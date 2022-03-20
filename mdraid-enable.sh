#!/bin/sh

mdadm=/usr/sbin/mdadm

$mdadm --stop md1
$mdadm --stop md2

$mdadm --assemble --scan

$mdadm --run --readwrite md1
$mdadm --run --readwrite md2

exit 0

