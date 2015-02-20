# forked from tutum/nginx
FROM ubuntu:trusty

RUN apt-get update && \
    apt-get install -y nginx && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN echo "daemon off;" >> /etc/nginx/nginx.conf
ADD sites-enabled/ /etc/nginx/sites-enabled/

EXPOSE 80

CMD ["/usr/sbin/nginx"]


