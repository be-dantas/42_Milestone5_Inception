# Inception

This project has been created as part of the 42 curriculum by bedantas

---

## Overview

Inception is a system administration project focused on deploying a small infrastructure using Docker Compose.

The objective is to build a **multi-container architecture** composed of:

- NGINX (web server)
- WordPress (application)
- MariaDB (database)

Each service runs in its own isolated container.

---

## Architecture

- **NGINX**
  - Acts as the single entrypoint to the infrastructure
  - Serves the website over HTTPS (TLS)

- **WordPress**
  - Runs with PHP-FPM
  - Processes PHP requests from NGINX
  - Connects to MariaDB

- **MariaDB**
  - Stores all WordPress data (users, posts, etc.)

- **Network**
  - Containers communicate through a custom bridge network:
    ```
    network_inception
    ```

- **Volumes**
  - Data persistence is handled using bind mounts:
    - `/home/bedantas/data/mariadb`
    - `/home/bedantas/data/wordpress`

---

## How to Run

Make sure Docker and Docker Compose are installed.

Start the project:

```
make
```

Or using specific commands:

```
make up
make down
make clean
make fclean
```

---

## Resources / Explanations

### VM vs Docker
- Virtual Machines emulate a full operating system
- Docker uses the host kernel, making containers lightweight and faster

### Env Variables
- Configuration is managed using a `.env` file
- Contains database credentials and configuration values
- Must never be committed to Git

### Docker Network
- A custom network (`network_inception`) enables:
  - Internal communication between containers
  - DNS resolution (e.g., `mariadb`, `wordpress`)
  - Isolation from the host network

### Volumes (Bind Mounts)
- Data is stored on the host machine:
  - `/home/bedantas/data/...`
- Ensures persistence even if containers are removed

---

## Mandatory Scope

This project includes only the required services:

- NGINX (HTTPS)
- WordPress (PHP-FPM)
- MariaDB (database)
- Docker networking
- Persistent storage
- Environment-based configuration

No bonus features are included.

---

## Use of AI Tools

AI tools were used as a support resource during development:

- Assistance in structuring Dockerfiles
- Help writing and refining scripts (entrypoints)
- Reviewing configurations and architecture

All configurations were manually validated and fully understood.
AI was used strictly as a learning aid.
