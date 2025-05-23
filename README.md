## Alpine SSH Container
Este repositório contém um contêiner Docker baseado no Alpine Linux configurado com um servidor SSH (sshd) que inicia automaticamente, suporte a locales (pt_BR.UTF-8 e en_US.UTF-8), e fuso horário configurado para America/Sao_Paulo. A senha do usuário root é definida diretamente no docker-compose.yml usando uma variável de ambiente.
Funcionalidades

Servidor SSH: OpenSSH configurado para aceitar conexões como root com autenticação por senha.
Locales: Suporte a pt_BR.UTF-8 e en_US.UTF-8 para caracteres especiais e acentos.
Fuso horário: Configurado para America/Sao_Paulo.
Pacotes incluídos: vim, busybox-extras, tcpdump, procps, sshpass, rsync, tzdata, bash, e musl-locales.
Configuração de senha: A senha do root é definida via variável de ambiente ROOT_PASSWORD no docker-compose.yml.

Pré-requisitos

Docker instalado no host.
Docker Compose para gerenciar o contêiner.
O contêiner pode ser executado em um ambiente como Proxmox (LXC), desde que o Docker esteja configurado corretamente.

Estrutura do Repositório

Dockerfile: Define a construção da imagem do contêiner.
entrypoint.sh: Script que configura a senha do root e inicia o sshd.
docker-compose.yml: Configura o contêiner com a variável de ambiente ROOT_PASSWORD.

Como Usar
1. Clone o Repositório
git clone https://github.com/AprendendoLinux/alpine.git
cd alpine

2. Configure a Senha do Root
Edite o arquivo docker-compose.yml para definir a senha do root. Abra o arquivo e configure a variável ROOT_PASSWORD na seção environment:
version: '3.8'
services:
  acesso:
    image: meu-container-ssh
    build:
      context: .
      dockerfile: Dockerfile
    ports:
      - "2222:22"
    container_name: acesso
    environment:
      - ROOT_PASSWORD=sua_senha_secreta

Substitua sua_senha_secreta pela senha desejada.
Nota: Evite expor senhas sensíveis em repositórios públicos. Para maior segurança, considere usar chaves SSH (veja a seção Configurar Chaves SSH).
3. Construa e Inicie o Contêiner
Construa a imagem e inicie o contêiner com Docker Compose:
docker-compose up -d --build

Isso cria um contêiner chamado acesso e mapeia a porta 2222 do host para a porta 22 do contêiner.
4. Acesse o Contêiner via SSH
Conecte-se ao contêiner usando a senha definida em ROOT_PASSWORD:
ssh root@localhost -p 2222

5. Teste Caracteres Especiais
Verifique se os locales estão funcionando corretamente:
docker exec -it acesso bash
echo "Teste com acentos: áéíóú çãõ" > teste.txt
cat teste.txt

6. Parar o Contêiner
Para parar o contêiner:
docker-compose down

Configuração Avançada
Alterar o Locale
O contêiner está configurado com pt_BR.UTF-8 por padrão. Para usar en_US.UTF-8, execute:
docker exec -it acesso bash
export LANG=en_US.UTF-8

Configurar Chaves SSH
Para maior segurança, desabilite a autenticação por senha e use chaves SSH:

Gere um par de chaves no cliente:ssh-keygen -t rsa -b 4096


Copie a chave pública para o contêiner:ssh-copy-id -p 2222 root@localhost


Edite /etc/ssh/sshd_config no contêiner para desabilitar senhas:PasswordAuthentication no


Reinicie o contêiner:docker-compose restart



Executar em Proxmox/LXC
Se estiver rodando em um container LXC no Proxmox, verifique se o Docker está configurado corretamente. Caso enfrente problemas de permissões, execute o contêiner com privilégios:
docker run --privileged -d --name acesso -p 2222:22 meu-container-ssh

Segurança

Senhas: Não exponha a senha do root em repositórios públicos no docker-compose.yml. Considere usar chaves SSH para autenticação.
Chaves SSH: Prefira autenticação por chaves SSH em vez de senhas.
Firewall: No Proxmox, configure o firewall para permitir tráfego na porta mapeada (ex.: 2222).

Solução de Problemas

Erro de conexão SSH: Verifique os logs do contêiner:docker logs acesso


Caracteres especiais incorretos: Confirme que o cliente SSH/terminal está configurado para UTF-8 (ex.: no PuTTY, defina Window > Translation > UTF-8).
Permissões no Proxmox: Se o contêiner não iniciar, tente usar --privileged ou verifique as configurações do LXC.

Contribuições
Contribuições são bem-vindas! Abra uma issue ou pull request no GitHub para sugerir melhorias.
Licença
Este projeto está licenciado sob a MIT License.

