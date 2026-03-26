FROM debian:bookworm

RUN apt-get update -y \
    && apt-get install mariadb-server -y \
    && mkdir -p /run/mysqld \
    && chown -R mysql:mysql /run/mysqld
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

#mkdir -p /run/mysqld: cria a pasta se não existir, aqui que o Mariadb coloca arquivos temporários (socket e PID)
#chown -R mysql:mysql /run/mysqld: chown -R mysql:mysql /run/mysqld
#clean: remove arquivos .deb baixados durante a instalacao
#rm -rf: remove as listas de pacotes baixada no apt-get update, nao serao mais necessarios

COPY ./tools/custom.cnf /etc/mysql/mariadb.conf.d/

COPY --chmod=755 ./tools/init.sh /init.sh

EXPOSE 3306

CMD ["/init.sh"]