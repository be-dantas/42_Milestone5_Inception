FROM debian:bookworm

RUN apt-get update \
    && apt-get install nginx openssl -y \
    && mkdir -p /etc/nginx/ssl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

#openssl: HTTPS (porta 443), nele já gera o .crt(certificado) e key(chave privada)
#mkdir: criar pasta para certificados SSL

# gera certificado autoassinado
RUN openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/CN=bedantas.42.fr"

COPY ./tools/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]