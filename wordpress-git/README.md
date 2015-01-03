# wordpress-git

This image adds WordPress to the lamp-git image, using WP-CLI.

````
sudo docker build -t indiehosters/wordpress-git .
sudo docker run -it -v $(pwd)/data:/data -p 80:80 indiehosters/wordpress-git /bin/bash
````

And inside:

````
sh /run.sh &
sh /init/wordpress.sh
exit
````

Now you don't need this specific image anymore, but can run your instance with the generic lamp-git image:

````
sudo docker build -t indiehosters/lamp-git .
sudo docker run -it -v $(pwd)/data:/data -p 80:80 indiehosters/lamp-git /bin/bash
````
