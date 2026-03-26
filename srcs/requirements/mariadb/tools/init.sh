# “execute este script usando o interpretador bash”
#!/bin/bash

# dá acesso ao banco
chown -R mysql:mysql /var/lib/mysql

# inicia o mysql, o & significa: “execute em background”, sem & o script para aqui
mysqld_safe &

# espera o banco subir
for i in {30..0}; do
    if mysqladmin ping -u root --silent; then
        break
    fi
    sleep 1
done

# só cria se ainda não existir. Usa heredoc -> EOF
if [ ! -d "/var/lib/mysql/$DB_NAME" ]; then
    mysql -u root << EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF
fi

exec mysqld