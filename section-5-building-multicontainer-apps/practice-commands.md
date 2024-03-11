# Practice exercise commands

---

## Creating the network

```bash
docker network create goals-network
```

## Database

```bash
docker run --name goals-db \
    -e MONGO_INITDB_ROOT_USERNAME=nick \
    -e MONGO_INITDB_ROOT_PASSWORD=secret \
    -v db-vol:/data/db \
    --rm \
    -d \
    --network goals-network
    mongo
```

## API

### Build Image

```bash
docker build -t goals-api:latest .
```

### Run Container

```bash
docker run --name goals-api \
    -v goals-app-vol:/app/logs \
    -v "/Users/ncardona/Workspace/docker-complete-course/section-5-building-multicontainer-apps/multi-01-starting-setup/backend:/app" \
    -v /app/node_modules \
    --rm \
    -d \
    -p 80:80 \
    --network goals-network \
    goals-api:latest
```

## APP

### Build Image

```bash
docker build -t goals-app:latest .
```

### Run Container

```bash
docker run --name goals-app \
    -v "/Users/ncardona/Workspace/docker-complete-course/section-5-building-multicontainer-apps/multi-01-starting-setup/frontend:/app" \
    -v /app/node_modules \
    --rm \
    -d \
    -it \
    -p 3000:3000 \
    goals-app:latest
```

## Tearing down everything

```bash
docker stop $(docker ps -aq)
```

```bash
docker rmi $(docker images -aq)
```

```bash
docker volume prune
```
