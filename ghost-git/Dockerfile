FROM node

RUN wget https://ghost.org/zip/ghost-0.5.8.zip
RUN apt-get update -yq \
	&& apt-get install -yq \
		zip
RUN mkdir /app && cd /app && unzip ../ghost-0.5.8.zip
RUN cd /app && npm install --production

EXPOSE 2368

CMD cd /app && npm start
