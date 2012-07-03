#!/bin/bash

PATH=/grape/:$PATH
export PATH

software[0]="node.js";
software[1]="bigcouch"

answers[0]=1
answers[1]=1

for i in ${!answers[*]};do export answers_$i="${answers[$i]}";done

total=${#answers[@]}

ESC_SEQ="\x1b["
COL_FINAL=$ESC_SEQ"0m"
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"00;31m"
COL_GREEN=$ESC_SEQ"00;32m"
COL_YELLOW=$ESC_SEQ"33;01m"

run() {
echo "" >> /etc/hosts
echo "127.0.0.1 local.$DOMAINNAME" >> /etc/hosts
echo "127.0.0.1 www.$DOMAINNAME" >> /etc/hosts
echo "127.0.0.1 blog.$DOMAINNAME" >> /etc/hosts
#sudo echo "" >> /etc/hosts
#echo "10.183.130.31 beta.grapestack.com" >> /etc/hosts
echo "$DOWNLOADIP beta.grapestack.com" >> /etc/hosts
#sudo echo "" >> /etc/hosts

chmod +x /install.sh
#mkdir /grape
mv /install.sh /grape/install.sh
cd /grape

groupadd grape
useradd -g grape grape

sudo groupadd -g 5000 vmail
sudo useradd -s /usr/sbin/nologin -g vmail -u 5000 vmail -d /home/vmail -m

groupadd spamd
useradd -g spamd -s /bin/false -d /var/log/spamassassin spamd

iptables -I INPUT -p tcp -m tcp --dport 80 -j ACCEPT
iptables -I INPUT -p tcp -m tcp --dport 443 -j ACCEPT
iptables -I INPUT -p tcp -m tcp --dport 8080 -j ACCEPT
iptables -I INPUT -p tcp -m tcp --dport 8009 -j ACCEPT
iptables -I INPUT -p tcp -m tcp --dport 3306 -j ACCEPT
iptables -I INPUT -p tcp -m tcp --dport 4040 -j ACCEPT
iptables -I INPUT -p tcp -m tcp --dport 8091 -j ACCEPT
iptables -I INPUT -p tcp -m tcp --dport 8983 -j ACCEPT
iptables -I INPUT -p tcp -m tcp --dport 5983 -j ACCEPT
iptables -I INPUT -p tcp -m tcp --dport 5984 -j ACCEPT
iptables -I INPUT -p tcp -m tcp --dport 5985 -j ACCEPT
iptables -I INPUT -p tcp -m tcp --dport 5986 -j ACCEPT
iptables -I INPUT -p tcp -m tcp --dport 5987 -j ACCEPT
iptables -I INPUT -p tcp -m tcp --dport 11211 -j ACCEPT
iptables -I INPUT -p tcp -m tcp --dport 11210 -j ACCEPT
iptables -I INPUT -p tcp -m tcp --dport 4369 -j ACCEPT
iptables -I INPUT -p tcp -m tcp --dport 7789 -j ACCEPT
iptables -I INPUT -p tcp -m tcp --dport 7777 -j ACCEPT
iptables -I INPUT -p tcp -m tcp --dport 1337 -j ACCEPT

iptables -I INPUT -p tcp -m tcp --dport 25 -j ACCEPT
iptables -I INPUT -p tcp -m tcp --dport 587 -j ACCEPT
iptables -I INPUT -p tcp -m tcp --dport 465 -j ACCEPT
iptables -I INPUT -p tcp -m tcp --dport 110 -j ACCEPT
iptables -I INPUT -p tcp -m tcp --dport 995 -j ACCEPT
iptables -I INPUT -p tcp -m tcp --dport 993 -j ACCEPT
iptables -I INPUT -p tcp -m tcp --dport 143 -j ACCEPT

iptables -I INPUT -p tcp -m tcp --dport 21100:21199 -j ACCEPT

service iptables save
service iptables restart

echo "grape    ALL=(ALL)       ALL" >> /etc/sudoers
echo "%grape    ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers

mkdir /home/grape/.ssh

echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEArdZRM0IJr1QEwFrlVoJt0v6ggYjOJkL7GLW21hNJ09r6LyA6tBq4L6ngGv+V+bExk609eohMIhqUMWc2pEsbdR3BAgPYeZFU9dtTSPTuWhAgS8+2GrWHvdIurWcQ2jusYcv2TWI9jApDN3pJ27Yhl9nefo4yQ4YvWShdLx5fWWIK5yrKeLXpwh2/QA96sD/v6uIHGrUDaU5bk3yAtKsGu/7B9IGlHvqP5yLrR0HE0T3K4zedQf+fHiPv6Iq7Zz0BG7jL7kSsHB4U0vj5gZIxwexsxjvrqhTkHlbRBhvonJcCZDtEWGNo+EanFu6yHXrNr1QmlpIGRLG9sMc76zW3Xw== root@grape" >> /home/grape/.ssh/authorized_keys

mkdir /root/.ssh

cat /home/grape/.ssh/authorized_keys >> /root/.ssh/authorized_keys

chmod 700 /home/grape/.ssh
chmod 600 /home/grape/.ssh/authorized_keys

chmod 700 /root/.ssh
chmod 600 /root/.ssh/authorized_keys

chown -R grape /home/grape

sudo chmod 700 /home/grape/.ssh
sudo chmod 700 /root/.ssh

sudo chown -R grape /grape

cd /home/grape/.ssh
sudo ssh-keygen -N '' -f ./id_rsa -t rsa -q

sudo cp /home/grape/.ssh/id_rsa /root/.ssh/id_rsa
sudo cp /home/grape/.ssh/id_rsa.pub /root/.ssh/id_rsa.pub

sudo cat id_rsa.pub >> /home/grape/.ssh/authorized_keys
sudo cat id_rsa.pub >> /root/.ssh/authorized_keys

sudo chmod 600 /home/grape/.ssh/id_rsa
sudo chmod 600 /home/grape/.ssh/id_rsa.pub

sudo chmod 600 /root/.ssh/id_rsa.pub
sudo chmod 600 /root/.ssh/id_rsa

sudo mkdir /grape/cluster
sudo mkdir /grape/cluster/keys
cd /grape/cluster/keys
sudo ssh-keygen -N '' -f ./id_rsa -t rsa -q
sudo cat /grape/cluster/keys/id_rsa.pub >> /home/grape/.ssh/authorized_keys
sudo cat /grape/cluster/keys/id_rsa.pub >> /root/.ssh/authorized_keys
sudo cp /home/grape/.ssh/id_rsa.pub /grape/cluster/keys/cluster_key.pub
sudo cp /home/grape/.ssh/id_rsa /grape/cluster/keys/cluster_key

cd /grape

wget https://raw.github.com/grapestack/grapestack/master/setup.sh -O /grape/setup.sh

chmod +x /grape/setup.sh

mkdir /grape/install

mkdir /grape/cloudfiles

touch /grape/install/answers.txt
echo "yes" > /grape/install/answers.txt

JAVA_HOME=/grape/install/jdk1.7.0
JAVA_PATH=/grape/install/jdk1.7.0
export JAVA_HOME=/grape/install/jdk1.7.0
export JAVA_PATH=/grape/install/jdk1.7.0
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin:/grape/install/jdk1.7.0/bin:/grape/install/maven/bin:/root/bin:/grape/install/jdk1.7.0:/grape/install/maven:/grape
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin:/grape/install/jdk1.7.0/bin:/grape/install/maven/bin:/root/bin:/grape/install/jdk1.7.0:/grape/install/maven:/grape

#sudo echo "export M2_HOME=/grape/maven" >> /root/.bashrc
#sudo echo "export PATH=${M2_HOME}/bin:${PATH}" >> /root/.bashrc

echo "export JAVA_HOME=/grape/install/jdk1.7.0/" >> /etc/profile
echo "export JAVA_PATH=/grape/install/jdk1.7.0/" >> /etc/profile
echo "export PATH=$PATH:$JAVA_HOME/bin" >> /etc/profile

#echo "export JAVA_HOME=/grape/install/jdk1.7.0/" >> /etc/bashrc
#echo "export JAVA_PATH=/grape/install/jdk1.7.0/" >> /etc/bashrc
#echo "export PATH=$PATH:$JAVA_HOME/bin" >> /etc/bashrc

#echo "export JAVA_HOME=/grape/install/jdk1.7.0/" >> /root/.bash_profile
#echo "export JAVA_PATH=/grape/install/jdk1.7.0/" >> /root/.bash_profile
#echo "export PATH=$PATH:$JAVA_HOME/bin" >> /root/.bash_profile

chmod +x /grape/setup.sh
chmod +x /grape/*

chown -R grape /grape

sed -i 's/Defaults    requiretty/#Defaults    requiretty/g' /etc/rc.d/rc.local

cat <<'EOF' > /etc/yum.repos.d/cloudant.repo
[cloudant]
name=Cloudant Repo
baseurl=http://packages.cloudant.com/rpm/$releasever/$basearch
enabled=1
gpgcheck=0
priority=1
EOF

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin:/grape/install/jdk1.7.0/bin:/grape/install/maven/bin:/root/bin:/grape/install/jdk1.7.0:/grape/install/maven:/grape
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin:/grape/install/jdk1.7.0/bin:/grape/install/maven/bin:/root/bin:/grape/install/jdk1.7.0:/grape/install/maven:/grape

su grape /grape/setup.sh

echo "" >> /etc/rc.d/rc.local
sed -i 's/HOSTNAME=/#OLDHOSTNAME=/g' /etc/sysconfig/network
echo "HOSTNAME=mail.$DOMAINNAME.com" >> /etc/sysconfig/network
#echo "sudo /grape/bigcouch/bin/bigcouch >> /grape/bigcouch.log" >> /etc/rc.d/rc.local

cp /home/grape/.ssh/id_rsa /root/.ssh/id_rsa
cp /home/grape/.ssh/id_rsa.pub /root/.ssh/id_rsa.pub

IIP=$(/sbin/ifconfig eth1 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')
EIP=$(/sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')

echo "$IIP" >> /grape/internal
echo "$EIP" >> /grape/external
echo "$IIP" >> /grape/master

sed -i "s/127.0.0.1/$EIP/g" /grape/tomcat/conf/server.xml

chown grape /grape/internal
chown grape /grape/external


PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin:/grape/install/jdk1.7.0/bin:/grape/install/maven/bin:/root/bin:/grape/install/jdk1.7.0:/grape/install/maven:/grape
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin:/grape/install/jdk1.7.0/bin:/grape/install/maven/bin:/root/bin:/grape/install/jdk1.7.0:/grape/install/maven:/grape
echo "PATH=/grape/bin:/grape:$PATH" >> /root/.bash_profile
echo "export PATH=/grape/bin:/grape:$PATH" >> /root/.bash_profile

exit 0
}

packagesCall()
{
        packages
}

finish() {
echo "Installing GRAPE Stack..."
run
}

packages()
{
echo ""
echo "The following additional packages will be installed:"
for (( i=0; i<=$(( $total-1 )); i++ ))
do
        answer=${answers[$i]}

        color=$COL_GREEN
        if [ ${answers[$i]} -eq 0 ]
        then
                color=$COL_RED
        fi
echo -e "$color $i $COL_FINAL ${software[$i]}"
done
echo ""
echo "Enter the number of any software package you wish to enable/disable and press enter. When you are finished toggling software packages, press enter to continue:"
read item

        if [ -z "$item" ]; then
                finish
        elif [ $item -eq $item 2> /dev/null ]; then
                if [ ${answers[$item]} -eq 0 ]; then
                        answers[$item]=1
						for i in ${!answers[*]};do export answers_$i="${answers[$i]}";done
                else
                        answers[$item]=0
						for i in ${!answers[*]};do export answers_$i="${answers[$i]}";done
                fi
                clear
                packagesCall
        else
                echo "You must enter a valid number"
		fi
}

setup() {
        finish
}

options() {
        echo -e "Select an option:"
        echo -e "Press $COL_GREEN enter $COL_FINAL to install with defaults"
        echo -e "Press $COL_GREEN c $COL_FINAL to customize installation"

        read -n 1 -s install

                if [ -z "$install" ]; then
                        clear
                        setup
                elif [ $install == 'c' ]; then
                        clear
                        packages
                else
                        echo "You must select a valid option"
        fi
}

main() {
		
		if [ "$DOMAIN" == "" ]; then

        echo -e "Press $COL_GREEN enter $COL_FINAL to install using example.com as your domain name"
        echo -e "OR"
        echo -e "Type $COL_GREEN yourdomain.com $COL_FINAL to customize installation"
		
			read -e option

					if [ -z "$option" ]; then
							DOMAINNAME=example.com
					else
							DOMAINNAME=$option
			fi
				
		else
			
			DOMAINNAME=$DOMAIN					
		fi						
		
		if [ "$MASTER" == "" ]; then
			MASTER=$MASTER
		else
			echo "$MASTER" >> /grape/master
		fi

        export DOMAINNAME
		
		echo "$DOMAINNAME" >> /grape/domain

		if [ "$DOMAIN" == "" ]; then
		
			echo -e "Are you sure you want to install using $DOMAINNAME? (y or n)"

			read -n 1 -s confirm

					if [ "$confirm" == "y" ]; then
							packages
					else
							clear
							main
					fi
		
		else
		
			finish
		
		fi

}

host() {

		mkdir /grape

		DOWNLOADIP="10.183.130.31"
		echo "Determining download server..."
		ping -c 1 $DOWNLOADIP &> /dev/null
		if [ $? -eq 0 ] ; then
				HOST="r"
		else
				HOST="a"
		fi
		echo "Download server configured"

		if [ "$HOST" == "" ]; then
		
			echo -e "Select an host:"
			echo -e "Press $COL_GREEN r $COL_FINAL to install on Rackspace Cloud"
			echo -e "Press $COL_GREEN a $COL_FINAL to install on AWS"					
			
			read -n 1 -s install				
			
					if [ $install == 'r' ]; then
							DOWNLOADIP="10.183.130.31"
							clear
							echo "$install" >> /grape/host
							main
					elif [ $install == 'a' ]; then
							DOWNLOADIP="209.20.84.69"
							clear
							echo "$install" >> /grape/host
							main
					else
							echo "You must select a valid option"
							host
			fi
		
		else
		
			if [ $HOST == 'r' ]; then
					DOWNLOADIP="10.183.130.31"
					clear
					main
			elif [ $HOST == 'a' ]; then
					DOWNLOADIP="209.20.84.69"
					clear
					main
			fi
		
		fi
		
}

host