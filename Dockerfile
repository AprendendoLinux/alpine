# Imagem de origem
FROM alpine:latest

# Instala os pacotes necessários
RUN apk update && apk upgrade && apk add \
        openssh \
        vim \
        busybox-extras \
        tcpdump \
        procps \
        bash && \
        rm /var/cache/apk/* && \
        sed -i "s/bin\/sh/bin\/bash/" /etc/passwd

# Define o diretório de trabalho padrão para /root
WORKDIR /root

# Declara o diretório /root como home do usuário root
ENV HOME=/root

# Declara o diretório /root como volume
VOLUME ["/root"]

# Define o comando para manter o contêiner ativo
CMD ["bash", "-c", "trap : TERM INT; sleep infinity & wait"]
