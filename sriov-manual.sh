#!/bin/sh
set -ex

ip link set dev 'enp129s0f0np0' vf '126' mac '5e:8c:f2:cd:c8:4a' vlan '0' spoofchk on
