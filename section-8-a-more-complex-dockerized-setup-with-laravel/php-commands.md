# PHP commands

```bash
composer create-project --prefer-dist laravel/laravel blog
```

```bash
docker-compose run --rm composer create-project --prefer-dist laravel/laravel .
```

Composer is the service name that uses the previously defined entrypoint that happens to be composer, the command not the docker compose service.

. is the place where the application should be created, the previously set WORKDIR which is var/www/html

## Running a set of specific services

`docker-compose up` will start all services defined in the `docker-compose.yaml` by default.

```bash
docker-compose up -d server php mysql
```

or if you add this to your `docker-compose.yaml` file:

```dockerfile
services:
    server:
        depends_on:
            - php
            - mysql
```

you just can run this:

```bash
docker-compose up -d server
```

```bash
docker-compose run --rm artisan migrate
```

## With or Without Dockerfile

It is a good idea to create Dockerfiles because that shows the intention of the program.

When setting up the `context` bear in mind if the source code of the application comes from the host machine this context means all the files that the dockerfile has access to, so if you set the context to `./dockerfiles` it means that the `nginx.dockerfile` when building, will try to work with files that are outside of the dockerfile in question resulting in error, so that's why we set it like this

```bash
    build:
      context: .
      dockerfile: dockerfiles/nginx.dockerfile
```
