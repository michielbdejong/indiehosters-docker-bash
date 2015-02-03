FROM indiehosters/lamp-git

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
	&& apt-get -yq install \
		pwgen \
	&& rm -rf /var/lib/apt/lists/*

RUN cd /init && curl -O https://codeload.github.com/photo/frontend/tar.gz/4.0.0-rc6 && mv 4.0.0-rc6 trovebox.tgz

COPY init/trovebox.sh /init/trovebox.sh
COPY init/config.ini /init/config.ini

CMD sh /init/trovebox.sh
