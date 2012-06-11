sudo sed -i 's/wget/#wget/g' /etc/rc.d/rc.local

#sudo sed -i "s/PasswordAuthentication yes/PasswordAuthentication no/g" /etc/ssh/sshd_config

#sudo echo -e "grapestack\grapestack" | passwd root

#sudo wget --no-check-certificate http://download.oracle.com/otn-pub/java/jdk/7/jdk-7-linux-x64.tar.gz -O /grape/install/jdk-7-linux-x64.tar.gz
#sudo wget --no-check-certificate http://www.apache.org/dist/tomcat/tomcat-7/v7.0.21/bin/apache-tomcat-7.0.21.tar.gz -O /grape/install/apache-tomcat-7.0.21.tar.gz

sudo wget --no-check-certificate http://beta.grapestack.com/downloads/jdk-7-linux-x64.tar.gz -O /grape/install/jdk-7-linux-x64.tar.gz
sudo wget --no-check-certificate http://beta.grapestack.com/downloads/apache-tomcat-7.0.21.tar.gz -O /grape/install/apache-tomcat-7.0.21.tar.gz

sudo mkdir /grape/sites/

cd /grape/install/
sudo tar -xf /grape/install/jdk-7-linux-x64.tar.gz
cd /grape/
sudo tar -xf /grape/install/apache-tomcat-7.0.21.tar.gz
sudo mv /grape/apache-tomcat-7.0.21 /grape/tomcat
#sudo rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-5.noarch.rpm
sudo rpm -Uvh http://mirror.cogentco.com/pub/linux/epel/6/i386/epel-release-6-7.noarch.rpm
sudo rpm -Uvh http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm
sudo yum -y install git

sudo chown -R grape /grape

sudo git clone git://github.com/grapestack/grapestack.git repo

sudo chown -R grape /grape

sudo grep -rl example.com /grape/repo/ | sudo xargs sudo sed -i "s|example.com|$DOMAINNAME|g"
sudo grep -rl grapestack.com /grape/repo/ | sudo xargs sudo sed -i "s|grapestack.com|$DOMAINNAME|g"

#sudo cp /grape/repo/assets/id_rsa /home/grape/.ssh/id_rsa
#sudo cp /grape/repo/assets/id_rsa.pub /home/grape/.ssh/id_rsa.pub

#sudo cp /grape/repo/assets/id_rsa /root/.ssh/id_rsa
#sudo cp /grape/repo/assets/id_rsa.pub /root/.ssh/id_rsa.pub

sudo yum -y install httpd mod_ssl
sudo yum -y install nginx
sudo yum -y install mysql-devel
sudo yum -y install mysql-server

#cd /grape/
#sudo wget http://nginx.org/download/nginx-1.0.5.tar.gz
#sudo tar zxvf nginx-1.0.5.tar.gz
#cd nginx-1.0.5
#yum install -y pcre-devel.x86_64
#sudo ./configure
#sudo make
#sudo make install

sudo mkdir /grape/sites
sudo mkdir /grape/sites/$DOMAINNAME
sudo mkdir /grape/sites/$DOMAINNAME/ROOT
sudo mkdir /grape/sites/$DOMAINNAME/ROOT/WEB-INF
sudo mkdir /grape/sites/$DOMAINNAME/ROOT/WEB-INF/lib

sudo mkdir /etc/httpd/conf/grape/

sudo cp /grape/repo/assets/httpd.conf /etc/httpd/conf/httpd.conf
sudo cp /grape/repo/assets/httpd-vhosts.conf /etc/httpd/conf/grape/httpd-vhosts.conf
sudo cp /grape/repo/assets/ssl.sh /etc/httpd/conf/ssl.sh

sudo cp /grape/repo/assets/nginx.conf /etc/nginx/nginx.conf

sudo cp /grape/repo/assets/catalina.properties /grape/tomcat/conf/catalina.properties
sudo cp /grape/repo/assets/server.xml /grape/tomcat/conf/server.xml
sudo cp /grape/repo/assets/webNoRewrite.xml /grape/tomcat/conf/web.xml

sudo cp /grape/repo/assets/web.xml /grape/sites/$DOMAINNAME/ROOT/WEB-INF/web.xml
sudo cp /grape/repo/assets/webNoRewrite.xml /grape/tomcat/webapps/ROOT/WEB-INF/web.xml
sudo cp /grape/repo/assets/urlrewrite.xml /grape/sites/$DOMAINNAME/ROOT/WEB-INF/urlrewrite.xml
sudo cp /grape/repo/assets/lib/urlrewrite-3.2.0.jar /grape/sites/$DOMAINNAME/ROOT/WEB-INF/lib/urlrewrite-3.2.0.jar

sudo cp /grape/repo/java.sh /etc/profile.d/java.sh
sudo chmod +x /etc/profile.d/java.sh

sudo cp /grape/repo/assets/tomcat /etc/init.d/tomcat
sudo chmod +x /etc/init.d/tomcat

sudo cp /grape/repo/assets/bigcouch /etc/init.d/bigcouch
sudo chmod +x /etc/init.d/bigcouch

source /etc/bashrc
source ~/.bashrc

cd /grape/install/

#sudo wget --no-check-certificate http://www.getrailo.org/down.cfm?item=/railo/remote/download/3.2.3.000/custom/all/railo-3.2.3.000-jars.tar.gz -O /grape/install/railo.tar.gz
sudo wget --no-check-certificate http://beta.grapestack.com/downloads/railo-3.3.1.000-jars.tar.gz -O /grape/install/railo.tar.gz

sudo tar -xvf /grape/install/railo.tar.gz

sudo mv /grape/install/railo-3.3.1.000-jars /grape/tomcat/railo

cd /grape/sites/

sudo git clone git://github.com/ColdBox/coldbox-platform.git
cd /grape/sites/coldbox-platform
sudo git checkout development

sudo mv /grape/sites/coldbox-platform /grape/sites/coldbox

#sudo cp -r /grape/sites/coldbox /grape/sites/$DOMAINNAME/ROOT/coldbox

sudo cp -r /grape/repo/application/* /grape/sites/$DOMAINNAME/ROOT/

sudo cp -r /grape/repo/assets/jqm /grape/sites/$DOMAINNAME/ROOT/

#sudo wget --no-check-certificate https://github.com/ColdBox/coldbox-platform/tarball/development -O /grape/sites/coldbox.tar.gz
#sudo tar xf coldbox.tar.gz

cd /grape

#sudo git clone git://github.com/grapestack/ContentBox.git
sudo git clone git://github.com/Ortus-Solutions/ContentBox.git

sudo mkdir /grape/sites/blog
sudo mkdir /grape/sites/blog/ROOT
sudo mkdir /grape/sites/blog/ROOT/WEB-INF
sudo mkdir /grape/sites/blog/ROOT/WEB-INF/lib

sudo mv /grape/ContentBox/* /grape/sites/blog/ROOT/

#sudo sed -i 's/"model/"model","modules/' /grape/sites/blog/ROOT/Application.cfc

sudo cp /grape/repo/assets/web.xml /grape/sites/blog/ROOT/WEB-INF/web.xml
sudo cp /grape/repo/assets/urlrewriteContentBox.xml /grape/sites/blog/ROOT/WEB-INF/urlrewrite.xml
sudo cp /grape/repo/assets/lib/urlrewrite-3.2.0.jar /grape/sites/blog/ROOT/WEB-INF/lib/urlrewrite-3.2.0.jar
sudo cp /grape/repo/assets/ContentBoxRoutes.cfm /grape/sites/blog/ROOT/config/Routes.cfm
sudo mkdir /grape/sites/blog/ROOT/WEB-INF/railo/
sudo cp /grape/repo/assets/railo/railo-webContentBox.xml.cfm /grape/sites/blog/ROOT/WEB-INF/railo/railo-web.xml.cfm

sudo cp -R /grape/repo/assets/contentbox/bootstrap/ /grape/sites/blog/ROOT/modules/contentbox/layouts

sudo mkdir /grape/sites/admin
sudo mkdir /grape/sites/admin/ROOT
sudo mkdir /grape/sites/admin/ROOT/WEB-INF
sudo mkdir /grape/sites/admin/ROOT/WEB-INF/lib

sudo cp /grape/repo/assets/web.xml /grape/sites/admin/ROOT/WEB-INF/web.xml
sudo cp /grape/repo/assets/urlrewrite.xml /grape/sites/admin/ROOT/WEB-INF/urlrewrite.xml
sudo cp /grape/repo/assets/lib/urlrewrite-3.2.0.jar /grape/sites/admin/ROOT/WEB-INF/lib/urlrewrite-3.2.0.jar

sudo cp /grape/repo/assets/railo/railo-webAdmin.xml.cfm /grape/sites/admin/ROOT/WEB-INF/railo/railo-web.xml.cfm

sudo cp -r /grape/repo/application/* /grape/sites/admin/ROOT/

sudo chmod +x /grape/*
sudo chown -R grape /grape

JAVA_HOME=/grape/install/jdk1.7.0
JAVA_PATH=/grape/install/jdk1.7.0

export JAVA_HOME=/grape/install/jdk1.7.0
export JAVA_PATH=/grape/install/jdk1.7.0

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin:/grape/install/jdk1.7.0/bin:/grape/install/maven/bin:/root/bin:/grape/install/jdk1.7.0:/grape/install/maven:/grape
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin:/grape/install/jdk1.7.0/bin:/grape/install/maven/bin:/root/bin:/grape/install/jdk1.7.0:/grape/install/maven:/grape

#/grape/tomcat/bin/startup.sh

sudo cp /grape/repo/assets/modules/mod_cache.so /etc/httpd/modules/mod_cache.so
sudo cp /grape/repo/assets/modules/mod_file_cache.so /etc/httpd/modules/mod_file_cache.so
sudo cp /grape/repo/assets/modules/mod_mem_cache.so /etc/httpd/modules/mod_mem_cache.so

EIP=$(/sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')

sudo sed -i "s/127.0.0.1/$EIP/g" /grape/tomcat/conf/server.xml

sudo yum -y install mod_perl

sudo mkdir /grape/modcfml

sudo chown -R grape /grape/modcfml

sudo wget --no-check-certificate http://beta.grapestack.com/downloads/mod_cfml.pm -O /grape/modcfml/mod_cfml.pm
sudo wget --no-check-certificate http://beta.grapestack.com/downloads/mod_cfml-valve.jar -O /grape/modcfml/mod_cfml-valve.jar
sudo cp /grape/modcfml/mod_cfml-valve.jar /grape/tomcat/lib/mod_cfml-valve.jar

sudo sed -i "s/#HTTPD=/HTTPD=/" /etc/sysconfig/httpd

sudo service tomcat start
sudo service httpd start
sudo service mysqld start

sleep 10

sudo mkdir /grape/tomcat/railo/railo-server/
sudo mkdir /grape/tomcat/railo/railo-server/context/
sudo mkdir /grape/tomcat/railo/railo-server/context/admin/
sudo mkdir /grape/tomcat/railo/railo-server/patches/
sudo mkdir /grape/tomcat/webapps/ROOT/WEB-INF/railo/
sudo mkdir /grape/tomcat/webapps/ROOT/WEB-INF/railo/context/
sudo mkdir /grape/tomcat/webapps/ROOT/WEB-INF/railo/context/admin/
sudo mkdir /grape/sites/$DOMAINNAME/ROOT/WEB-INF/railo/
sudo mkdir /grape/sites/$DOMAINNAME/ROOT/WEB-INF/railo/extension/
sudo mkdir /grape/sites/$DOMAINNAME/ROOT/WEB-INF/railo/extension/gateway/

sudo mkdir /grape/sites/$DOMAINNAME/ROOT/WEB-INF/railo/gateway/
sudo mkdir /grape/sites/$DOMAINNAME/ROOT/WEB-INF/railo/gateway/railo/
sudo mkdir /grape/sites/$DOMAINNAME/ROOT/WEB-INF/railo/gateway/railo/extension/
sudo mkdir /grape/sites/$DOMAINNAME/ROOT/WEB-INF/railo/gateway/railo/extension/gateway/

sudo mkdir /grape/sites/$DOMAINNAME/ROOT/WEB-INF/railo/context/
sudo mkdir /grape/sites/$DOMAINNAME/ROOT/WEB-INF/railo/context/admin/
sudo mkdir /grape/sites/$DOMAINNAME/ROOT/WEB-INF/railo/context/admin/cdriver/
sudo mkdir /grape/sites/$DOMAINNAME/ROOT/WEB-INF/railo/context/admin/gdriver/
sudo cp /grape/repo/assets/railo/railo-server.xml /grape/tomcat/railo/railo-server/context/railo-server.xml
sudo cp -r /grape/repo/assets/railo/lib /grape/tomcat/railo/railo-server/context/lib
sudo cp -r /grape/repo/assets/railo/extensions /grape/tomcat/railo/railo-server/context/extensions
sudo mkdir /grape/tomcat/webapps/ROOT/WEB-INF/railo/context/admin/cdriver/
sudo cp /grape/repo/assets/railo/MembaseCache.cfc /grape/tomcat/webapps/ROOT/WEB-INF/railo/context/admin/cdriver/MembaseCache.cfc
sudo cp /grape/repo/assets/railo/MembaseCache.cfc /grape/sites/$DOMAINNAME/ROOT/WEB-INF/railo/context/admin/cdriver/MembaseCache.cfc
sudo cp /grape/repo/assets/railo/railo-web.xml.cfm /grape/sites/$DOMAINNAME/ROOT/WEB-INF/railo/railo-web.xml.cfm

sudo cp -r /grape/repo/assets/gateway/gdriver/default.cfc /grape/sites/$DOMAINNAME/ROOT/WEB-INF/railo/context/admin/gdriver/
sudo cp -r /grape/repo/assets/gateway/defaultListener.cfc /grape/sites/$DOMAINNAME/ROOT/WEB-INF/railo/extension/gateway/
sudo cp -r /grape/repo/assets/gateway/default.cfc /grape/sites/$DOMAINNAME/ROOT/WEB-INF/railo/extension/gateway/
sudo cp -r /grape/repo/assets/gateway/Application.cfc /grape/sites/$DOMAINNAME/ROOT/WEB-INF/railo/extension/gateway/
sudo cp -r /grape/repo/assets/gateway/Application.cfm /grape/sites/$DOMAINNAME/ROOT/WEB-INF/railo/extension/gateway/

sudo cp -r /grape/repo/assets/gateway/defaultListener.cfc /grape/sites/$DOMAINNAME/ROOT/WEB-INF/railo/gateway/railo/extension/gateway/
sudo cp -r /grape/repo/assets/gateway/default.cfc /grape/sites/$DOMAINNAME/ROOT/WEB-INF/railo/gateway/railo/extension/gateway/
sudo cp -r /grape/repo/assets/gateway/Application.cfc /grape/sites/$DOMAINNAME/ROOT/WEB-INF/railo/gateway/railo/extension/gateway/
sudo cp -r /grape/repo/assets/gateway/Application.cfm /grape/sites/$DOMAINNAME/ROOT/WEB-INF/railo/gateway/railo/extension/gateway/

sudo chown -R grape /home/grape

qry="CREATE DATABASE mail  DEFAULT CHARACTER SET utf8  DEFAULT COLLATE utf8_general_ci; CREATE DATABASE grape  DEFAULT CHARACTER SET utf8  DEFAULT COLLATE utf8_general_ci; CREATE DATABASE contentbox  DEFAULT CHARACTER SET utf8  DEFAULT COLLATE utf8_general_ci; USE mysql; GRANT ALL PRIVILEGES ON *.* TO 'grape'@'%' IDENTIFIED BY 'stackpass' WITH GRANT OPTION; GRANT ALL PRIVILEGES ON *.* TO 'grape'@'localhost' IDENTIFIED BY 'stackpass' WITH GRANT OPTION; FLUSH PRIVILEGES;"

sudo /usr/bin/mysql -u root  << eof
$qry
eof

qry="USE contentbox; source /grape/repo/assets/blog.sql;"

sudo /usr/bin/mysql -u root  << eof
$qry
eof

qry="USE grape; source /grape/repo/assets/users.sql;"

sudo /usr/bin/mysql -u root  << eof
$qry
eof

qry="USE mail; source /grape/repo/assets/postfix/mail.sql;"

sudo /usr/bin/mysql -u root  << eof
$qry
eof

cd /grape/install

sudo yum -y install gcc.x86_64 make

#sudo wget http://curl.haxx.se/download/curl-7.22.0.tar.gz
#sudo tar -xf curl-7.22.0.tar.gz
#cd curl-7.20.1
#./configure --prefix=/usr/local
#sudo make
#sudo make install

sudo yum -y install curl-devel.x86_64 fuse.x86_64 fuse-devel.x86_64 fuse-libs.x86_64 libxml2.x86_64 libxml2-devel.x86_64 libcurl-devel

cd /grape

sudo git clone git://github.com/redbo/cloudfuse.git
cd cloudfuse
sudo ./configure
sudo make
sudo make install
which cloudfuse
sudo mkdir /grape/cloudfiles
sudo touch /home/grape/.cloudfuse
sudo chown -R grape /home/grape

sudo echo "username=rackspaceusername" >> /home/grape/.cloudfuse
sudo echo "api_key=rackspaceapikey" >> /home/grape/.cloudfuse

sudo yum -y install libidn

sudo yum -y install cyrus-sasl

sudo yum -y install openssl098e

#sudo wget http://files.couchbase.com/developer-previews/couchbase-server-2.0.0-dev-preview/linux/couchbase-server-community_x86_64_2.0.0r-1-ge4c8742.rpm -O /grape/install/couchbase-server-community_x86_64_2.0.0r-1-ge4c8742.rpm
sudo wget http://beta.grapestack.com/downloads/couchbase-server-community_x86_64_2.0.0r-1-ge4c8742.rpm -O /grape/install/couchbase-server-community_x86_64_2.0.0r-1-ge4c8742.rpm

sudo rpm --install /grape/install/couchbase-server-community_x86_64_2.0.0r-1-ge4c8742.rpm

bigcouch() {

sudo yum -y install zlib-devel rubygem-rake ruby-rdoc

#git clone git://github.com/cloudant/bigcouch.git
#cd bigcouch
#./configure -p /grape/bigcouch
#make
#sudo make install

sudo cat <<'EOF' > /etc/yum.repos.d/cloudant.repo
[cloudant]
name=Cloudant Repo
baseurl=http://packages.cloudant.com/rpm/$releasever/$basearch
enabled=1
gpgcheck=0
priority=1
EOF

sudo yum -y install bigcouch

}

if [ $answers_0 == 1 ]; then
	bigcouch
fi

#CouchDB 1.1, not available on CentOS 5.6
sudo yum -y install libicu-devel openssl-devel erlang js-devel libtool which xulrunner-devel ncurses-devel libicu icu
cd /grape/install
sudo wget http://beta.grapestack.com/downloads/apache-couchdb-1.1.1.tar.gz -O /grape/install/apache-couchdb-1.1.1.tar.gz
sudo tar -xf /grape/install/apache-couchdb-1.1.1.tar.gz
cd /grape/install/apache-couchdb-1.1.1
sudo adduser -r --home /grape/couch/var/lib/couchdb -M --shell /bin/bash --comment "CouchDB Administrator" couchdb
sudo mkdir /grape/couch
sudo mkdir /grape/couch/couchdb
sudo touch /grape/couch/couchdb/couchdb.pid
sudo ./configure --with-erlang=/usr/lib64/erlang/usr/include --prefix=/grape/couch --enable-js-trunk
#sudo ./configure --prefix=/usr/local --enable-js-trunk
sudo make
sudo make install
sudo cp /grape/repo/assets/default111.ini /grape/couch/etc/couchdb/default.ini
sudo chown -R couchdb:couchdb /grape/couch/var/lib/couchdb /grape/couch/var/log/couchdb
sudo chown -R couchdb:couchdb /grape/couch
sudo cp /grape/repo/assets/movies.couch /grape/couch/var/lib/couchdb/
sudo cp /grape/repo/assets/config.couch /grape/couch/var/lib/couchdb/
sudo cp /grape/repo/assets/cluster.couch /grape/couch/var/lib/couchdb/
sudo cp /grape/repo/assets/couchdb.init /etc/init.d/couchdb
sudo chmod +x /etc/init.d/couchdb
sudo chown -R couchdb:couchdb /grape/couch/

sudo mkdir /var/run/couchdb/
sudo chown couchdb:couchdb /var/run/couchdb/

sudo chown -R couchdb:couchdb /grape/couch

#sudo service couchdb start
#sudo -u couchdb /grape/couch/bin/couchdb

sudo cat > /etc/yum.repos.d/jpackage-generic-free.repo << EOF
[jpackage-generic-free]
name=JPackage generic free
baseurl=http://mirrors.dotsrc.org/jpackage/6.0/generic/free/
enabled=1
gpgcheck=1
gpgkey=http://www.jpackage.org/jpackage.asc
EOF

sudo cat > /etc/yum.repos.d/jpackage-generic-devel.repo << EOF
[jpackage-generic-devel]
name=JPackage Generic Developer
baseurl=http://mirrors.dotsrc.org/jpackage/6.0/generic/devel/
enabled=1
gpgcheck=1
gpgkey=http://www.jpackage.org/jpackage.asc
EOF

#BigCouch (CouchDB 1.1)
#sudo wget http://curl.haxx.se/download/curl-7.22.0.tar.gz
#sudo tar -xf curl-7.22.0.tar.gz
#cd curl-7.22.0
#./configure --prefix=/usr/local
#sudo make
#sudo make install
#yum -y install ncurses-devel
#curl -O https://raw.github.com/spawngrid/kerl/master/kerl; chmod a+x kerl
#./kerl build R14B03 r14b03
#./kerl install r14b03 /opt/erlang/r14b03
#. /opt/erlang/r14b03/activate
#yum install js-devel libicu libicu-devel openssl openssl-devel python python-devel libtool which xulrunner-devel
#git clone git://github.com/cloudant/bigcouch.git
#cd bigcouch
#./configure -p /grape/bigcouch
#make
#sudo make install

#starts on 5986
cd /grape/install
#sudo wget --no-check-certificate https://github.com/downloads/cloudant/bigcouch/bigcouch-0.3.1-1.x86_64.rpm
#sudo wget --no-check-certificate http://beta.grapestack.com/downloads/bigcouch-0.3.1-1.x86_64.rpm
#sudo rpm --install /grape/install/bigcouch-0.3.1-1.x86_64.rpm
sudo hostname mail.$DOMAINNAME.com
#sudo mv /opt/bigcouch /grape/bigcouch
sudo cp /grape/repo/assets/default.ini /opt/bigcouch/etc/default.ini
#sudo /grape/bigcouch/bin/bigcouch

sudo wget http://www.alliedquotes.com/mirrors/apache/maven/binaries/apache-maven-2.2.1-bin.tar.gz
sudo chmod 700 apache-maven-2.2.1-bin.tar.gz
sudo tar xzf apache-maven-2.2.1-bin.tar.gz
sudo mv /grape/install/apache-maven-2.2.1 /grape/install/maven

sudo echo "export M2_HOME=/grape/install/maven" >> /root/.bashrc
sudo echo "export PATH=${M2_HOME}/bin:${PATH}" >> /root/.bashrc

M2_HOME=/grape/install/maven
export M2_HOME=/grape/install/maven

JAVA_HOME=/grape/install/jdk1.7.0
JAVA_PATH=/grape/install/jdk1.7.0

export JAVA_HOME=/grape/install/jdk1.7.0
export JAVA_PATH=/grape/install/jdk1.7.0

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin:/grape/install/jdk1.7.0/bin:/grape/install/maven/bin:/root/bin:/grape/install/jdk1.7.0:/grape/install/maven:/grape
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin:/grape/install/jdk1.7.0/bin:/grape/install/maven/bin:/root/bin:/grape/install/jdk1.7.0:/grape/install/maven:/grape

cd /grape/install/
sudo git clone git://github.com/rnewson/couchdb-lucene.git
cd couchdb-lucene

JAVA_HOME=/grape/install/jdk1.7.0
export JAVA_HOME=/grape/install/jdk1.7.0

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin:/grape/install/jdk1.7.0/bin:/grape/install/maven/bin:/root/bin:/grape/install/jdk1.7.0:/grape/install/maven:/grape
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin:/grape/install/jdk1.7.0/bin:/grape/install/maven/bin:/root/bin:/grape/install/jdk1.7.0:/grape/install/maven:/grape

sudo JAVA_HOME=/grape/install/jdk1.7.0 /grape/install/maven/bin/mvn
cd target
sudo yum -y install unzip
sudo unzip /grape/install/couchdb-lucene/target/couchdb-lucene-0.9.0-SNAPSHOT-dist.zip
sudo cp /grape/repo/assets/couchdb-lucene.ini /grape/install/couchdb-lucene/target/couchdb-lucene-0.9.0-SNAPSHOT/conf/
sudo chown -R grape /grape
#sudo /grape/install/couchdb-lucene/target/couchdb-lucene-0.9.0-SNAPSHOT/bin/run > /dev/null 2>&1 &

#compiled and ready
#cd /grape/install
#sudo wget http://beta.grapestack.com/downloads/couchdb-lucene-0.9.0-SNAPSHOT-dist.tar.gz
#sudo tar -xvf /grape/install/couchdb-lucene-0.9.0-SNAPSHOT-dist.tar.gz

#riak
#sudo wget http://downloads.basho.com/riak/riak-1.0.0/riak-1.0.0-1.el5.x86_64.rpm
#sudo rpm -Uvh riak-1.0.0-1.el5.x86_64.rpm

#starts on 5985
#sudo yum -y install couchdb
#sudo cp /grape/repo/assets/couch/default.ini /etc/couchdb/default.ini
#sudo cp /grape/repo/assets/couch/local.ini /etc/couchdb/local.ini
#sudo service couchdb start

sudo cp /grape/repo/assets/railo/railo-server.xml /grape/tomcat/railo/railo-server/context/railo-server.xml
sudo cp -r /grape/repo/assets/railo/lib /grape/tomcat/railo/railo-server/context/
sudo cp -r /grape/repo/assets/railo/extensions /grape/tomcat/railo/railo-server/context/
sudo mkdir /grape/tomcat/webapps/ROOT/WEB-INF/railo/context/admin/cdriver/
sudo cp /grape/repo/assets/railo/MembaseCache.cfc /grape/tomcat/webapps/ROOT/WEB-INF/railo/context/admin/cdriver/MembaseCache.cfc
sudo cp /grape/repo/assets/railo/MembaseCache.cfc /grape/sites/$DOMAINNAME/ROOT/WEB-INF/railo/context/admin/cdriver/MembaseCache.cfc
sudo cp /grape/repo/assets/railo/railo-web.xml.cfm /grape/sites/$DOMAINNAME/ROOT/WEB-INF/railo/railo-web.xml.cfm

cd /grape/tomcat/railo/railo-server/patches/
sudo wget http://beta.grapestack.com/downloads/3.3.2.003.rc

sudo chown -R grape /home/grape
sudo chown -R grape /grape
sudo chown -R grape /grape/tomcat/railo/railo-server/patches/

sudo rpm -Uvh http://download.newrelic.com/pub/newrelic/el5/i386/newrelic-repo-5-3.noarch.rpm
sudo yum -y install newrelic-sysmond
sudo nrsysmond-config --set license_key=NEWRELICLICENSEKEY
#sudo /etc/init.d/newrelic-sysmond start

cd /grape/tomcat/
sudo wget http://beta.grapestack.com/downloads/newrelic_agent2.4.2.zip
sudo unzip newrelic_agent2.4.2.zip
cd newrelic
sudo java -jar newrelic.jar install


sudo service tomcat restart

cd /grape/install
sudo mkdir /grape/proxy
#sudo wget http://dev.mysql.com/get/Downloads/MySQL-Proxy/mysql-proxy-0.8.2-linux-rhel5-x86-64bit.tar.gz/from/http://mirror.services.wisc.edu/mysql/
sudo wget http://beta.grapestack.com/downloads/mysql-proxy-0.8.2-linux-rhel5-x86-64bit.tar.gz -O mysql-proxy-0.8.2-linux-rhel5-x86-64bit.tar.gz
sudo tar -xf mysql-proxy-0.8.2-linux-rhel5-x86-64bit.tar.gz
sudo mv /grape/install/mysql-proxy-0.8.2-linux-rhel5-x86-64bit /grape/proxy/mysql-proxy

sudo mkdir /grape/config
sudo cp /grape/repo/assets/config/mysql-proxy /grape/config/mysql-proxy
sudo chmod +x -R /grape/config
sudo chmod +x -R /grape/proxy

sudo chown -R grape /grape

sudo cp /grape/repo/assets/mysql-proxy /etc/init.d/mysql-proxy

sudo cp /grape/repo/assets/failover.lua /grape/proxy/failover.lua

#sudo /grape/mysql-proxy/bin/mysql-proxy --defaults-file=/grape/config/mysql-proxy.conf 	 

sudo chmod +x /etc/init.d/mysql-proxy

sudo service mysql-proxy start

sudo yum -y install bzip2 and bzip2-devel bzip2-libs

node() {

	cd /grape
	sudo wget http://beta.grapestack.com/downloads/Python-2.5.4.tgz

	sudo tar xzvf Python-2.5.4.tgz

	cd Python-2.5.4
	sudo ./configure
	sudo make
	sudo make install

	sudo ln -s /grape/Python-2.5.4/python /usr/bin/python

	sudo touch /etc/ld.so.conf.d/python2.5.conf

	sudo chown -R grape /etc/ld.so.conf.d/python2.5.conf

	sudo echo "'/usr/local/lib'" >> /etc/ld.so.conf.d/python2.5.conf

	sudo ldconfig

	PATH=$HOME/bin:/grape:$PATH
	export PATH=$HOME/bin:/grape:$PATH

	cd /grape

	sudo wget http://beta.grapestack.com/downloads/node-v0.6.6.tar.gz
	sudo tar xvf node-v0.6.6.tar.gz
	sudo mv node-v0.6.6 node
	cd node

	sudo yum -y install gcc-c++

	sudo CC=/usr/bin/gcc CXX=/usr/bin/g++ ./configure
	sudo make
	sudo make install

	sudo mkdir /grape/node/www

	sudo cp /grape/repo/assets/node.js /grape/node/www/node.js

	sudo chown -R grape /grape

	sudo rm /usr/local/bin/python

	sudo ln -s /usr/bin/python2.6 /usr/local/bin/python

	sudo ln -s /usr/bin/python2.6 /usr/bin/python
	
}

if [ $answers_0 == 1 ]; then
	node
fi

PATH=/grape/install/jdk1.7.0/bin:/grape:$PATH
export PATH=/grape/install/jdk1.7.0/bin:/grape:$PATH

cd /grape/
#sudo wget --no-check-certificate http://newverhost.com/pub//lucene/solr/3.4.0/apache-solr-3.4.0.tgz -O apache-solr-3.4.0.tgz
sudo wget --no-check-certificate http://beta.grapestack.com/downloads/apache-solr-3.4.0.tgz -O apache-solr-3.4.0.tgz
sudo tar -xf apache-solr-3.4.0.tgz
cd /grape/apache-solr-3.4.0/example
sudo mv /grape/apache-solr-3.4.0.tgz /grape/install/apache-solr-3.4.0.tgz
sudo cp /grape/repo/assets/schema.xml /grape/apache-solr-3.4.0/example/solr/conf/schema.xml
sudo chown -R grape /grape
#sudo java -Dsolr.solr.home=/grape/apache-solr-3.4.0/example/solr/ -jar start.jar
#sudo java -Dsolr.solr.home=/grape/apache-solr-3.4.0/example/solr/ -jar start.jar > /dev/null 2>&1 &

#sudo cp /grape/repo/assets/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo
sudo yum -y install postfix dovecot dovecot-mysql procmail spamassassin

sudo groupadd -g 5000 vmail
sudo useradd -s /usr/sbin/nologin -g vmail -u 5000 vmail -d /home/vmail -m

sudo chmod +x /home/vmail
sudo chown -R vmail /home/vmail
sudo chmod +w /home/vmail

sudo cp /grape/repo/assets/postfix/smtpd.conf /usr/lib64/sasl2/smtpd.conf

sudo cp -R /grape/repo/assets/postfix/* /etc/postfix/

sudo cp -R /grape/repo/assets/dovecot/* /etc/dovecot/

sudo cp -R /grape/repo/assets/mail/spamassassin/* /etc/mail/spamassassin/

sudo cp -R /grape/repo/assets/mail/aliases /etc/mail/aliases

sudo cp -R /grape/repo/assets/mail/procmailrc /etc/procmailrc

sudo cp -R /grape/repo/assets/mail/spamfilter /usr/local/bin/spamfilter

sudo cp -R /grape/repo/assets/postfix/virtual /etc/postfix/

sudo chmod o= /etc/postfix/mysql-*
sudo chgrp postfix /etc/postfix/mysql-*

sudo groupadd spamd
sudo useradd -g spamd -s /bin/false -d /var/log/spamassassin spamd
sudo chown spamd:spamd /var/log/spamassassin

sudo useradd spamfilter

sudo postmap /etc/postfix/virtual

sudo yum -y install crypto-utils

sudo chmod +x /grape/repo/assets/mail/mkcert.sh

sudo mkdir /grape/certs
sudo mkdir /grape/private

sudo chmod +x /grape/repo/assets/mail/mkcert.sh

sudo /grape/repo/assets/mail/mkcert.sh

sudo cp /grape/private/dovecot.pem /etc/pki/tls/private/mail.$DOMAINNAME.com.key
sudo cp /grape/certs/dovecot.pem /etc/pki/tls/certs/mail.$DOMAINNAME.com.cert

sudo chmod +x /usr/local/bin/spamfilter

sudo chown spamfilter /usr/local/bin/spamfilter

sudo service saslauthd start
sudo service spamassassin start
sudo service postfix start
sudo service dovecot start

sudo chown -R couchdb:couchdb /grape/couch

sudo service couchdb start

sudo chkconfig httpd on
sudo chkconfig mysqld on
sudo chkconfig tomcat on
sudo chkconfig mysql-proxy on
sudo chkconfig couchdb on

sudo echo "PATH=/grape/bin:/grape:$PATH" >> /home/grape/.bash_profile
sudo echo "export PATH=/grape/bin:/grape:$PATH" >> /home/grape/.bash_profile

sudo echo "PATH=/grape/bin:/grape:$PATH" >> /root/.bash_profile
sudo echo "export PATH=/grape/bin:/grape:$PATH" >> /root/.bash_profile