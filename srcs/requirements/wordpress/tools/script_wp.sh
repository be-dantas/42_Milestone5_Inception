#!/bin/bash
set -e

cd /var/www/html

# baixa wordpress se não existir
if [ ! -f wp-config.php ]; then

    wget https://wordpress.org/latest.tar.gz
    tar -xzf latest.tar.gz
    mv wordpress/* .
    rm -rf wordpress latest.tar.gz

    cp wp-config-sample.php wp-config.php

    sed -i "s/database_name_here/$DB_NAME/" wp-config.php
    sed -i "s/username_here/$DB_USER/" wp-config.php
    sed -i "s/password_here/$DB_PASSWORD/" wp-config.php
    sed -i "s/localhost/$DB_HOST/" wp-config.php

    chown -R www-data:www-data /var/www/html
fi

# espera banco subir
until mysqladmin ping -h"$DB_HOST" --silent; do
    sleep 2
done

# instala wordpress automaticamente
if ! wp core is-installed --allow-root; then

    wp core install \
        --url=$DOMAIN_NAME \
        --title=$WP_TITLE \
        --admin_user=$WP_ADMIN_USER \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL \
        --skip-email \
        --allow-root

    wp user create $WP_USER $WP_USER_EMAIL \
        --role=author \
        --user_pass=$WP_USER_PASSWORD \
        --allow-root
fi

exec php-fpm8.2 -F