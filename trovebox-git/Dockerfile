FROM ubuntu
RUN apt-get update \
	&& echo "postfix postfix/main_mailer_type string 'Internet site'" | debconf-set-selections \
	&& echo "postfix postfix/mailname string 'HOSTNAME.EXAMPLE.COM'" | debconf-set-selections \
	&& echo "postfix postfix/root_address string 'ROOTMAIL@EXAMPLE.COM'" | debconf-set-selections \
	&& apt-get install -yq \
		git \
		postfix \
		wget \
	&& rm -rf /var/lib/apt/lists/*

RUN wget https://raw.githubusercontent.com/photo/frontend/master/documentation/guides/InstallationUbuntuApache.sh
RUN /bin/bash InstallationUbuntuApache.sh

COPY run.sh /run.sh

CMD sh /run.sh
