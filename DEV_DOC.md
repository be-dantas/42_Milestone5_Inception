# Inception Developer Documentation (Mandatory Part)

## Project Architecture

The project implements a **3-tier web architecture**, fully containerized using Docker and based on Debian Bookworm images:

1. **NGINX**: Web server responsible for handling HTTPS requests.
2. **WordPress (PHP-FPM)**: Application layer executing PHP code.
3. **MariaDB**: Database layer responsible for persistent data storage.

---

## Docker Compose Services

The orchestration is defined in `docker-compose.yml`, containing exactly three services:

### nginx
- Handles incoming HTTPS traffic (port 443)
- Depends on WordPress
- Shares the `wordpress_data` volume to serve website files

### wordpress
- Runs PHP-FPM on port 9000 (internal)
- Depends on MariaDB
- Connects to the database using environment variables

### mariadb
- Provides database service on port 3306 (internal)
- Initializes database and user on first run

---

## Dockerfiles and Containers

Each service has its own `Dockerfile` located in:

```
srcs/requirements/<service>/
```

All containers are built from:

```
debian:bookworm
```

Each container runs a **foreground process** using `CMD`, ensuring proper container lifecycle:

```
nginx      → nginx -g "daemon off;"
wordpress  → php-fpm -F
mariadb    → mysqld (via script)
```

---

## Network

A custom Docker bridge network is defined:

```
network_inception
```

This network provides:

- Communication between containers
- Internal DNS resolution (e.g., `mariadb`, `wordpress`)
- Isolation from external networks

---

## Volumes and Persistence

Persistent storage is configured using bind mounts:

### mariadb_data
- Host: `/home/<login>/data/mariadb`
- Container: `/var/lib/mysql`

### wordpress_data
- Host: `/home/<login>/data/wordpress`
- Container: `/var/www/html`

This ensures:

- Data persists after container removal
- Database and WordPress files are preserved

---

## Environment Variables

Configuration is managed through:

```
srcs/.env
```

Example variables:

```
DB_NAME
DB_USER
DB_PASSWORD
DB_ROOT_PASSWORD
DB_HOST
```

Used to:

- Configure MariaDB
- Connect WordPress to the database

> ⚠️ The `.env` file must NOT be committed (add to `.gitignore`)

---

## Rebuilding the Environment

Available Makefile commands:

```bash
make        # build + up
make up     # start containers
make down   # stop containers
make clean  # remove containers, images, volumes
make fclean # full cleanup (including local data)
make re     # rebuild everything from scratch
```
