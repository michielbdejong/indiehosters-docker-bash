FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
	&& echo "postfix postfix/main_mailer_type string 'Internet site'" | debconf-set-selections \
	&& echo "postfix postfix/mailname string 'HOSTNAME.EXAMPLE.COM'" | debconf-set-selections \
	&& echo "postfix postfix/root_address string 'ROOTMAIL@EXAMPLE.COM'" | debconf-set-selections \
	&& apt-get -yq install \
		apache2 \
		curl \
		exiftran \
		git \
		libapache2-mod-php5 \
		libpcre3-dev \
		mysql-client \
		mysql-server-5.5 \
		php-apc \
		php-pear \
		php5-curl \
		php5-gd \
		php5-imagick \
		php5-intl \
		php5-json \
		php5-mcrypt \
		php5-mysql \
		php5-xmlrpc \
		postfix \
	&& rm -rf /var/lib/apt/lists/*

# Add image configuration and scripts
COPY apache.conf /etc/apache2/sites-enabled/000-default.conf
COPY init /init
COPY run.sh /run.sh
RUN a2enmod rewrite \
	&& a2enmod deflate \
	&& a2enmod expires \
	&& a2enmod headers \
	&& pecl install oauth \
	&& mkdir -p /etc/php5/apache2/conf.d/ \
	&& echo "extension=oauth.so" >> /etc/php5/apache2/conf.d/oauth.ini \
	&& sed \
		-i "s/variables_order.*/variables_order = \"EGPCS\"/g" \
		-i "s/file_uploads.*/file_uploads = On/g" \
		-i "s/upload_max_filesize.*/upload_max_filesize = 16M/g" \
		-i "s/post_max_size.*/post_max_size = 16M/g" \
		/etc/php5/apache2/php.ini \
	&& chmod 755 /run.sh

CMD ["/run.sh"]
EXPOSE 80
