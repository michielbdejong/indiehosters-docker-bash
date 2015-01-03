# known-git

This image adds Known to the lamp-git image.

````
sudo docker build -t indiehosters/known-git .
sudo docker run -it -v $(pwd)/data:/data -p 80:80 indiehosters/known-git /bin/bash
````

And inside:

````
sh /run.sh &
sh /init/known.sh
exit
````

Now you don't need this specific image anymore, but can run your instance with the generic lamp-git image:

````
sudo docker build -t indiehosters/lamp-git .
sudo docker run -it -v $(pwd)/data:/data -p 80:80 indiehosters/lamp-git /bin/bash
````
