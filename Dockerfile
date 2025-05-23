# Imagem de origem
FROM alpine:latest

# Instala os pacotes necessários
RUN apk update && apk upgrade && apk add \
        openssh \
        vim \
        busybox-extras \
        tcpdump \
        procps \
        sshpass \
        rsync \
        tzdata \
        bash \
        musl-locales \
        musl-locales-lang && \
        rm -rf /var/cache/apk/* && \
        # Configura o shell padrão como bash
        sed -i "s/bin\/sh/bin\/bash/" /etc/passwd && \
        # Configura o fuso horário para São Paulo
        ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && \
        echo 'export TZ="America/Sao_Paulo"' >> /etc/profile && \
        # Configura o locale pt_BR.UTF-8 e en_US.UTF-8
        echo 'export LANG=pt_BR.UTF-8' >> /etc/profile && \
        echo 'export LC_ALL=pt_BR.UTF-8' >> /etc/profile && \
        echo 'export LANGUAGE=en_US.UTF-8' >> /etc/profile && \
        # Configura o SSH
        ssh-keygen -A && \
        echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
        echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config

# Copia o script de entrada
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Define o diretório de trabalho padrão para /root
WORKDIR /root

# Declara o diretório /root como home do usuário root
ENV HOME=/root

# Declara o diretório /root como volume
VOLUME ["/root"]

# Expõe a porta padrão do SSH
EXPOSE 22

# Define o entrypoint
ENTRYPOINT ["/entrypoint.sh"]
