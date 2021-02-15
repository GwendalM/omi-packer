#!/bin/bash
set -e

if [[ "$1" == "debian"* ]] || [[ "$1" == "ubuntu"* ]]; then
    #### UPDATES
    chroot /mnt/ apt update -y
    chroot /mnt/ apt upgrade -y
    chroot /mnt/ apt clean

    #### OUTSCALE PACKAGES
    wget https://osu.eu-west-2.outscale.com/outscale-official-packages/udev/osc-udev-rules-20190314_amd64.deb -P /mnt/tmp
    chroot /mnt/ dpkg -i /tmp/osc-udev-rules-20190314_amd64.deb

    #### PACKAGE LIST
    chroot /mnt/ apt list --installed > /tmp/packages

elif [[ "$1" == "centos"* ]] || [[ "$1" == "rhel"* ]]; then
    #### UPDATES
    chroot /mnt/ yum upgrade -y
    chroot /mnt/ yum clean all

    #### OUTSCALE PACKAGES
    chroot /mnt yum install -y https://osu.eu-west-2.outscale.com/outscale-official-packages/udev/osc-udev-rules-20160516-1.x86_64.rpm

    #### PACKAGE LIST
    chroot /mnt yum list installed > /tmp/packages

fi