# Docker Alpine com Bash, SSH e Configuração Personalizada

Esta imagem Docker é baseada no **Alpine Linux** e inclui algumas customizações úteis, como suporte ao **Bash**, **SSH**, diretório `/root` configurado como volume, e um comportamento otimizado para manter o contêiner ativo. A imagem está disponível no Docker Hub e pode ser utilizada para diversos fins de desenvolvimento e aprendizado.

## Funcionalidades

- Base: **Alpine Linux** (imagem leve e eficiente).
- Shell padrão: **Bash** (configurado como shell padrão em vez do `sh`).
- Diretório `/root` configurado como:
  - Volume persistente para armazenar dados.
  - Diretório inicial (`HOME`) ao acessar o contêiner.
- Inclui o pacote **OpenSSH**.
- Configuração para manter o contêiner em execução continuamente.

## Como Usar

### 1. Baixar a Imagem

A imagem está disponível no Docker Hub como **`aprendendolinux/alpine:latest`**. Para baixá-la, execute:

```bash
docker pull aprendendolinux/alpine:latest
```

### 2. Executar o Contêiner

Para iniciar o contêiner:

```bash
docker run -dit --name meu-container aprendendolinux/alpine:latest
```

Isso criará e executará o contêiner com o nome `meu-container`.

### 3. Acessar o Contêiner

Para acessar o contêiner em modo interativo com Bash:

```bash
docker exec -it meu-container bash
```

O diretório inicial será `/root`.

### 4. Personalizar ou Persistir Dados

Como o diretório `/root` é configurado como volume, qualquer dado salvo neste diretório será persistido. Para mapear o volume manualmente para o host:

```bash
docker run -dit --name meu-container -v /caminho/local:/root aprendendolinux/alpine:latest
```

Substitua `/caminho/local` pelo diretório que deseja utilizar no host.

---

## Teste e Diagnóstico

- Verifique a presença de Bash:
  ```bash
  bash --version
  ```
- Valide se o contêiner está ativo:
  ```bash
  docker ps
  ```

---

## Licença

Esta imagem é fornecida como está, sem garantias. Sinta-se à vontade para utilizá-la em projetos pessoais ou educacionais. Modificações e contribuições são bem-vindas!

---

## Sobre

Imagem criada pela comunidade **Aprendendo Linux** para auxiliar no aprendizado de Docker e Linux. 
