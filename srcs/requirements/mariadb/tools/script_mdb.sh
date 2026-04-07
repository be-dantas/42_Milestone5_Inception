#!/bin/bash

chown -R mysql:mysql /var/lib/mysql

# inicia temporariamente
mysqld_safe &

for i in {30..0}; do
    if mysqladmin ping -u root --silent; then
        break
    fi
    sleep 1
done

if [ "$i" = 0 ]; then
    exit 1
fi

mysql -u root << EOF
CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

# mata processo temporário
mysqladmin -u root -p${DB_ROOT_PASSWORD} shutdown

#sobe corretamente em foreground
exec mysqld_safe