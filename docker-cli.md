# Docker CLI

- You can use `-h` or `--help` with all the docker commands
- `<container-name>` means the container's name or id.

## Images

Can be tagged

```bash
-t
docker tag
```

Can be listed

```bash
docker images
```

Can be analyzed

```bash
docker images inspect
```

Can be removed

```bash
docker rmi
docker prune
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

Attached simply listens to the terminal output, whilst dettached don't.

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
