FROM ascdc/apache2-php56
MAINTAINER ASCDC <asdc.sinica@gmail.com>

ADD run.sh /run.sh
ENV DRUSH_VERSION 8.1.2
RUN DEBIAN_FRONTEND=noninteractive && \
	chmod +x /*.sh && \
	apt-get update && \
	apt-get -y install sshpass && \
	curl -fsSL -o /usr/local/bin/drush "https://github.com/drush-ops/drush/releases/download/$DRUSH_VERSION/drush.phar" && \
	chmod +x /usr/local/bin/drush

EXPOSE 80
WORKDIR /var/www/html
ENTRYPOINT ["/run.sh"]
