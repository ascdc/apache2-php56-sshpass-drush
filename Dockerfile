FROM ascdc/apache2-php56-sshpass
MAINTAINER ASCDC <asdc.sinica@gmail.com>

ADD run.sh /run.sh
ENV DRUSH_VERSION 8.1.17
ENV LANG zh_TW.UTF-8  
ENV LANGUAGE zh_TW
ENV LC_ALL zh_TW.UTF-8 

RUN DEBIAN_FRONTEND=noninteractive && \
	chmod +x /*.sh && \
	apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get -y install openssh-server pwgen vim wget curl screen sudo mysql-client && \
	curl -fsSL -o /usr/local/bin/drush "https://github.com/drush-ops/drush/releases/download/$DRUSH_VERSION/drush.phar" && \
	chmod +x /usr/local/bin/drush && \
	mkdir -p /var/run/sshd &&  \
	sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && \
	sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config && \
	sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config && \
	echo "alias ll='ls -al'" >> /root/.profile && \
	apt-get install -y locales && \
	locale-gen zh_TW.UTF-8 && \
	DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales && \ 
	locale-gen zh_TW.UTF-8 && \
	echo "export LANG=zh_TW.UTF-8" >> /root/.profile && \ 
	echo "export LANGUAGE=zh_TW" >> /root/.profile && \
	echo "export LC_ALL=zh_TW.UTF-8" >> /root/.profile
	
ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh

ENV AUTHORIZED_KEYS **None**

EXPOSE 80
WORKDIR /var/www/html
ENTRYPOINT ["/run.sh"]
