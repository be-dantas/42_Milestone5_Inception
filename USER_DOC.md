# Inception User Documentation (Mandatory Part)

## Services Provided

This project provides a fully functional WordPress website running behind an NGINX web server, with a MariaDB database for reliable data storage.

All traffic is served securely over HTTPS using TLS.

---

## Starting and Stopping the Project

You can control the project using the provided Makefile.

- **Start the project:**
  make
  or
  make up
  This builds the images and starts the containers in the background.

- **Stop the project:**
  make down
  Stops the containers without deleting data.

- **Clean the project:**
  make clean
  Removes containers, images, and volumes.

- **Full clean (including local data):**
  make fclean
  Deletes all Docker data and local persistent files.

---

## Accessing the Website

Open your browser and go to:

https://bedantas.42.fr

Since the project uses a self-signed SSL certificate, your browser will show a security warning.

You can proceed safely by clicking:

Advanced → Accept the risk / Proceed

---

## WordPress Admin Panel

To manage the website, access:

https://bedantas.42.fr/wp-admin/

Log in using the administrator credentials defined during the WordPress setup.

---

## Where Credentials are Stored

All sensitive information is stored in:

srcs/.env

This includes:

- Database name
- Database user
- Database passwords

⚠️ This file must never be committed to GitHub.

---

## Verifying Containers

To check if everything is running correctly:

docker compose -f srcs/docker-compose.yml ps

or:

docker ps

You should see three running containers:

nginx
wordpress
mariadb
