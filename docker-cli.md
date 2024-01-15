# Docker CLI

- You can use `-h` or `--help` with all the docker commands
- `<container-name>` means the container's name or id.

## Images

Can be tagged

```bash
-t
docker tag
```

### What's the idea behind image tags?

An image can have a name and the multiple "versions" of that image attached on the same name.

Can be listed

```bash
docker images
```

Can be analyzed
This command outputs all the configuration properties this image has (including the layers).

```bash
docker image inspect <image-id>
```

Can be removed

```bash
docker rmi
docker image prune -a
```

## Containers

Can be named

```bash
--name
```

Can be configured in detail

```bash
--help
```

Can be listed

```bash
docker ps
```

Can be removed

```bash
docker rm <container-name>
```

Can be restarted (Runs the container in the **background** not as `docker run` which runs in the **foreground** )

```bash
docker start <container-name>
```

### Dettached and attached modes

Attached simply listens to the terminal output, whilst dettached doesn't.

```bash
docker run -p 8000:80 -d <container-name>
```

You can re-attach to the container with `attach`

```bash
docker attach <running-container-name>
docker start -a <stopped-container-name>
```

Or if you don't want to get attached to the container, but just see the logs, you can do so!

```bash
docker logs -f <running-container-name>
```

Here docker will output the container's logs and keep listening to it, of course you can remove that flag and just see the logs.

### Interactive mode, Pseudo-TTY and STDIN stream

The container is attached to the host by default but just the STDOUT (Standard Output Stream) not to the STDIN (Standard Input Stream).

So... how do we do that?
By using two flags:

- `-i` to enter to interactive mode (input something).
- `-t` to expose the terminal to the host machine.

```bash
docker run -it <container-name>
docker start -a -i <container-name>
```

- When the program is finished so does the container.

### How can we remove a container when it's finished?

```bash
docker run -p 3000:80 -d --rm <container-name> # Deletes the container as well
docker stop <container-name>
docker ps -a
```

By listing all the containers you'll see that the container that you ran is nowhere to be found.

### How do we copy a file from/into a running container?

```bash
docker cp dummy/. <container-name>:/<filename> # From host machine to container
docker cp <container-name>:/<filename> dummy # From container to host machine
```

Brokendown:

```bash
docker cp <source> <destination>
```

Something to hightlight is that the `<container-name>:/` resembles the windows `C:/` root directory.

- Can we update a code to avoid building again the images?
  - Yes, but it's not recommended since it's error prone.
  - And in case you're wondering you can't replace a file which is currently running.

### How do we share an image?

First off, we share images not containers, because if you have the image you can run the container.

So we can share **Dockerfiles along with all the code inside a zip**, this will require for you to build the image and then run the container.

On the other hand, you can just **share the plain image** and run the container right away.

### Which ways are used to share Docker images?

1. Docker Hub
   1. Official Docker Image Registry.
   2. Public, private and "official" Images.
2. Private registry
   1. Any provider / registry you want to use.
   2. Only your own (or team) Images.

```bash
# Share:
docker push <image-name>
# Use:
docker pull <image-name>
```

`<image-name>` needs to be `HOST:NAME` to talk to a private registry.

When pushing the image you'll stumble upon this:

```bash
denied: requested access to the resource is denied
```

Basically you are not logged in.

To log in.

```bash
$ docker login

Login with your Docker ID to push and pull images from Docker Hub. If you don't have a Docker ID, head over to https://hub.docker.com to create one.
Username: <username>
Password: <password>
Login Succeeded
```

Then you'll be able to upload your images.

And to logout just `docker logout`

### Pulling and using sharing images

- If the image is public you don't have to be logged in to pull it.
- You don't have to pull it, just run a container specifying the image name and if it doesn't exist in your local machine, docker will use the image registry (dockerhub) and pull it from there.
