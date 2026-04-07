FROM debian:bookworm

RUN apt-get update \
    && apt-get install -y \
    php8.2-fpm \
    php8.2-mysql \
    mariadb-client \
    wget \
    tar \
    && mkdir -p /run/php /var/www/html \
    && chown -R www-data:www-data /run/php /var/www/html \
    && sed -i 's|listen = /run/php/php8.2-fpm.sock|listen = 9000|' /etc/php/8.2/fpm/pool.d/www.conf \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

#php8.2-fpm: Instala o php-fpm. Processo que executa PHP. NGINX vai se comunicar com ele
#php8.2-mysql: Permite que o PHP converse com o MariaDB
#mariadb-client: Ferramenta para acessar o banco via terminal (util para testes)
#wget: Baixar arquivos da internet (baixar o WordPress)
#tar: extrair .tar.gz (extrair o WordPress baixado)
#mkdir: cria uma pasta que é usada pelo php-fpm, e outra onde o wordpress vai ficar
#chown -R www-data:www-data: muda o dono (owner) e o grupo (group) dessas pastas. Por padrão a pasta é root:root, dai mudamos para www-data:www-data por causa do PHP

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# define o diretório de trabalho padrão dentro do container
WORKDIR /var/www/html

COPY --chmod=755 tools/script_wp.sh /usr/local/bin/script_wp.sh

EXPOSE 9000

CMD ["/usr/local/bin/script_wp.sh"]