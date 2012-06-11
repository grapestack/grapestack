#!/bin/bash

sudo yum -y install drbd-utils
sudo dd if=/dev/zero of=/drbd-loop.img bs=1M count=8192

sudo chmod a+x /etc/init.d/loop-for-drbd
sudo chkconfig loop-for-drbd on
sudo /etc/init.d/loop-for-drbd start

sudo IP=$(/sbin/ifconfig eth1 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')

sudo cp /grape/repo/assets/r0.res /etc/drbd.d/r0.res

sudo sed -i 's/usage-count yes/usage-count no/g' /etc/drbd.d/global_common.conf

sudo drbdadm create-md r0
sudo /etc/init.d/drbd start && chkconfig drbd on

#primary only
drbdsetup /dev/drbd0 primary -o

until sudo cat /proc/drbd | grep 'UpToDate/UpToDate'
	do
		echo "Sleeping"
		sleep 5
	done
	
#secondary only
drbdadm primary r0
	
sudo yum -y install ocfs2-tools

sudo mkdir /etc/ocfs2/

sudo cp /grape/repo/assets/cluster.conf /etc/ocfs2/cluster.conf

sudo chkconfig o2cb on && chkconfig ocfs2 on
sudo /etc/init.d/o2cb start && /etc/init.d/ocfs2 start

#primary only
sudo mkfs.ocfs2 -L "web" /dev/drbd0

sudo mkdir /mnt/storage
sudo echo "/dev/drbd0  /mnt/storage  ocfs2  noauto,noatime  0 0" >> /etc/fstab
sudo mount /dev/drbd0
sudo echo "mount /dev/drbd0" >> /etc/rc.local

sudo sed -i "s/1.1.1.1/$IP/g" /etc/ocfs2/cluster.conf