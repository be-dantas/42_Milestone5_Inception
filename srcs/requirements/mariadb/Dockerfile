FROM debian:bookworm

RUN apt-get update -y /
    && apt-get install mariadb-server -y /
    && apt-get clean /
    && rm -rf var/lib/apt/lists/*
#clean: remove arquivos .deb baixados durante a instalacao
#rm -rf: remove as listas de pacotes baixada no apt-get update, nao serao mais necessarios

EXPOSE 3306

CMD ["mysqld"]