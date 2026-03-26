FROM debian:bookworm

RUN apt-get update \
    && apt-get install -y \
    php8.2-fpm \
    php8.2-mysql \
    mariadb-client \
    wget \
    tar \
    && mkdir -p /run/php /var/www/html \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

#php8.2-fpm: Instala o php-fpm. Processo que executa PHP. NGINX vai se comunicar com ele
#php8.2-mysql: Permite que o PHP converse com o MariaDB
#mariadb-client: Ferramenta para acessar o banco via terminal (util para testes)
#wget: Baixar arquivos da internet (baixar o WordPress)
#tar: extrair .tar.gz (extrair o WordPress baixado)
#makdir: cria uma pasta que é usada pelo php-fpm, e outra onde o wordpress vai ficar

EXPOSE 9000