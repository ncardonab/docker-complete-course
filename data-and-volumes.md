# Data and volumes

| Application<br>(Code + Environment)           | Temporary App Data<br>(e.g. entered user input) | Permament App Data<br>(e.g. user accounts)                |
| --------------------------------------------- | ----------------------------------------------- | --------------------------------------------------------- |
| Written & provided by you (= the developer)   | Fetched / Produced in running container         | Fetched / Produced in running container                   |
| Added to image and container in build phase   | Stored in memory or temporary files             | Stored in files or a database                             |
| "Fixed": Can't be changed once image is built | Dynamic and changing, but cleared regularly     | Must not be lost if container stops / restarts            |
| Read-only, hence stored in Images             | Read + write, hence stored in Containers        | Read + write, permanent, stored with Containers & Volumes |

- Once you run a container and create data there, it'll last the time the container is not removed, if this gets removed you'll lose all that data, even if you try to run the container again, it would be a new one.
- If you stop the container and then start it again the created data will be there.

## The problem: Not knowing how to persist data

But first, a brief peek to:

### TWO TYPES OF EXTERNAL DATA STORAGES

| Volumes<br>(Managed by Docker)                                            |                                                                                                                             | Bind Mounts<br>(Managed by you) |
| ------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------- | ------------------------------- |
| **Anonymous Volumes**                                                     | **Named Volumes**                                                                                                           |                                 |
| **Exist as longs as their containers exist** as they are closely attached | **Is independent from containers**, it is created at first instance by a container but once it gets removed it's standalone |                                 |
| We can only **create containers inside the Dockerfile**                   | We can only **create named containers via CLI**, not with the Dockerfile                                                    |                                 |
| Docker automatically allocates both types of volumes in an unknown path   |                                                                                                                             |                                 |

Here's a brief demo of what we're talking about:

```bash
docker run -d -p 3000:80 --rm --name feedback-app feedback-node:volumes
docker volume ls
```

You'll see:

```bash
DRIVER      VOLUME NAME
local       fe6167c8122
```

Then, stopping the container and listing the volumes:

```bash
docker stop feedback-app
docker volume ls
```

We get:

```bash
DRIVER      VOLUME NAME
```

It's empty! As mentioned, the anonymous volume is attached to the container, if this gets removed (because of `--rm` flag) so will be the volume.
Unless you haven't add the `--rm` flag in that case the volume will be alive but you can't access to it.
So you can remove the volume by running `docker volume rm <volume-name>` or `docker volume prune` to delete all of them.

Yeah, yeah, yeah, but... **How do we actually persist the data???**

Well, by creating a named container:

```bash
docker run -d -p 3000:80 -rm --name feedback-app -v feedback:/app/feedback feedback-node:volumes
# Syntax
docker run <volume-name>:<container-path>
```

So the `<container-path>` is where you want the data to be stored/mapped into.
