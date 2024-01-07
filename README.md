# Docker

## Dockerfile walkthrough

Image that the container is going to be based on

```docker
FROM node:14
```

Sets the working directory

```docker
WORKDIR /app
```

Whenever you see dot (.) it refers to the previously set working directory
Copies a file to the working directory

```docker
COPY package.json .
```

Runs a command

```docker
RUN npm install
```

Copying the whole application into the working directory

```docker
COPY . /app
```

Exposing the container 80 port so it's accesible

```docker
EXPOSE 80
```

This command will keep the container running until it is stopped

```docker
CMD [ "node", "app.mjs"]
```

Why not `RUN node app.mjs`? because that instruction runs everytime the image is created
So with `CMD` this runs everytime we start a container

## Docker CLI

### To build the docker image

(In order to the dot (.) to work the dockerfile should be in the same route you are running the command from)

```bash
docker build .
```

### To run the brand new docker container by your image

```bash
docker run -p 3000:80 container-name/id
```

`--publish list` or for short `-p`
Publish a container's port(s) to the host

`<Host port>:<container exposed port>`

---

As an additional quick side-note: For all docker commands where an ID can be used, you don't always have to copy / write out the full id.

You can also just use the first (few) character(s) - just enough to have a unique identifier.

So instead of

```bash
docker run abcdefg
```

you could also run

```bash
docker run abc
```

or, if there's no other image ID starting with "a", you could even run just:

```bash
docker run a
```

This applies to ALL Docker commands where IDs are needed.

### Check docker processes

```bash
docker ps
```

### Layer-based architecture

The images are built on a layer-based architecture

- If you rebuild an image with no changes in your code it'll use the **cached layers**
- If there're **changes in your code** that layer will be **rebuilt** from scratch as well as all the subsequent layers since docker can't tell that those subsequent layers might or might not have been changed, it just doesn't do a deep code analysis.

So in order to have a performant docker image build process we have to optimize the code so some process doesn't get carried over again without any need.

Let's say that you just changed some code, with this architecture docker will install all the dependencies all over again needlessly.

```docker
COPY . /app

RUN npm install
```

Now, what if we change it, so it doesn't install all the dependencies? By simply adding what I call, a "watcher" to the `package.json` file, so when the user actually updates the dependencies it'll install them. But not when the source code gets updated.

```docker
COPY package.json .

RUN npm install

COPY . /app
```
