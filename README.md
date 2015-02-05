# Using just Docker and bash

Here's how to run a postfix-forwarder, haproxy, and lamp-based web backend containers on an off-the-shelf Ubuntu server.

If you are using CoreOS (or at least systemd), then you probably want to have a look at [gh:indiehosters/indiehosters](https://github.com/indiehosters/indiehosters).

Note that not all servers support Docker, because of kernel modules etcetera; of the images I tried at Gandi, only the Ubuntu 12.04-64 one
allowed me to actually run `docker ps`, and even on there, I was not able to run `docker run debian apt-get update` because from the looks
of it, containers are not allowed to contact the outside world. In the end I got a Debian 7.6 server at Linode and an Ubuntu 14.10-64 server at vultr.com, they both work fine.

Note that about 5GB of disk space will be used, and when running multiple sites, 2Gb of RAM is probably also well-spent. At Vultr, this is a bit cheaper than at Linode (currently 15 vs 20 usd/month).

Here's what I did to prepare the server:

````bash
apt-get update && apt-get -y upgrade
apt-get -y install unattended-upgrades git

dpkg-reconfigure -plow unattended-upgrades
# set unattended upgrades to 'Yes'

ssh-keygen -t rsa
# select all the defaults by hitting <enter> repeatedly

# Install Docker:
curl -sSL https://get.docker.com/ | sh

# Install docker-enter ([recommended](https://github.com/jpetazzo/nsenter#nsenter-in-a-can)):
# This also tests your server (there should be no 'could not resolve' errors).
docker run --rm -v /usr/local/bin:/target jpetazzo/nsenter

# In this case of Debian I also had to:
/etc/init.d/exim stop
````


Then I added the .ssh/id_rsa.pub to .ssh/authorized_keys at both backup server accounts, and ran:

````
git clone git@bu25:postfix
cd postfix; ./runme.sh; cd ..
git clone git@bu25:haproxy
cd haproxy; ./runme.sh; cd ..
````

These 'postfix' and 'haproxy' repos with their `runme.sh` files look like the samples in the `data/` folder of this repo.

And then for each domain I host:

````
git clone git@bu25:michielbdejong.com
cd michielbdejong.com; ./runme.sh; cd ..
````

These domain repos look quite similar to the IndieHosters migration format, except that there is a `runme.sh` file in there,
as follow:

````
docker rm michielbdejong.com
docker run -d --restart=always --name michielbdejong.com -v $(pwd):/data indiehosters/lamp-git
docker inspect -f {{.NetworkSettings.IPAddress}} michielbdejong.com
````

And furthermore, the dump.sql file includes the 'mysql' database as well as the 'known' database, so that the local 'root' user
is created, and the php files of Known 0.6.5 are included (will iron out that difference when switching from generic lamp-git
image to specific Known image).

Now the only thing you need to be careful with is to start haproxy *after* starting the backends, otherwise the container linking
doesn't work. This means reboots are not actually safe, and also, at the time of writing, hourly backups are not working yet in the
lamp-git image, so be aware that this is a work in progress. :)

The idea of this setup would be to eventually support the migration format in a programmatic way.

# Adding domains

To add a domain, choose one of the applications in this repo. First, build them all. From the root of this repo:

````
sudo docker build -t michielbdejong/lamp-git lamp-git/
sudo docker build -t michielbdejong/wordpress-git wordpress-git/
sudo docker build -t michielbdejong/known-git known-git/
sudo docker build -t michielbdejong/owncloud-git owncloud-git/
etc ...
````

To initialize an ownCloud instance, go into e.g. /data/domains/example.com, and run:

````
sudo docker run -d -v $(pwd):/data -p 80:80 michielbdejong/owncloud-git
````

Follow the logs of this container, it will prompt you to visit http://localhost/ with your browser. For the other apps you can
do the same, but with michielbdejong/<app>-git as the Docker image.

Once the first backup has run, you don't need this specific image anymore, but can run your instance with the generic lamp-git image:

````
sudo docker run -it -v $(pwd):/data -p 80:80 michielbdejong/lamp-git
````

For trovebox, run the trovebox-git image in production, and make sure /data/hostname is a text file containing the desired hostname.
