#!/bin/bash
# ==============================================================================
# Setup Inicial da Instância EC2 (User Data)
# ==============================================================================
# Prepara o ambiente instalando o Docker e iniciando a aplicação.

# Adquire privilégios de root
sudo su

# Atualiza pacotes do sistema
yum update -y

# Instala o Docker
yum install -y docker

# Inicia o serviço do Docker
service docker start

# Adiciona o usuário 'ec2-user' ao grupo docker (permite rodar comandos sem sudo)
usermod -a -G docker ec2-user

# Executa o contêiner da aplicação (porta 8080 do host -> porta 80 do contêiner)
docker run -d -p 8080:80 --name sfbjj umluks/sfbjj-app:1.0.0
