#!/bin/bash

# vai para a pasta do wordpress
cd /var/www/html

# baixa e configura só na primeira vez
if [ ! -f wp-config.php ]; then
    echo "Setting up WordPress..."

    wget https://wordpress.org/latest.tar.gz
    tar -xvf latest.tar.gz

    mv wordpress/* .
    rm -rf wordpress latest.tar.gz

    # cria arquivo de configuração
    cp wp-config-sample.php wp-config.php

    # conecta com MariaDB
    sed -i "s/database_name_here/$DB_NAME/" wp-config.php
    sed -i "s/username_here/$DB_USER/" wp-config.php
    sed -i "s/password_here/$DB_PASSWORD/" wp-config.php
    sed -i "s/localhost/$DB_HOST/" wp-config.php

    # permissões
    chown -R www-data:www-data /var/www/html
fi

echo "Starting PHP-FPM..."

# mantém container rodando corretamente. Se o container parar: NGINX tenta acessar PHP → falha, WordPress não responde, site quebra 
exec php-fpm8.2 -F