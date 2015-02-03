FROM indiehosters/lamp-git

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
	&& apt-get -yq install \
		pwgen \
	&& rm -rf /var/lib/apt/lists/*

RUN cd /init && curl -O https://codeload.github.com/idno/Known/tar.gz/v0.7 && mv v0.7 known.tgz

COPY init/known.sh /init/known.sh
COPY init/config.ini /init/config.ini

CMD sh /init/known.sh
