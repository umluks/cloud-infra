# AWS Provider Configuration
# Define a região padrão da AWS.
provider "aws" {
  region = "us-east-1"
}

# Security Group
# Controla o tráfego de rede da instância EC2.
resource "aws_security_group" "sfbjj" {
  name        = "sfbjj"
  description = "Permite acesso externo para os servicos web HTTP e acesso administrativo via SSH"

  # Libera a porta 80 (HTTP) para acesso público.
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Libera a porta 22 (SSH) para conexões administrativas.
  # Atenção: Em produção, restrinja o IP.
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["191.122.194.73/32"]
  }

  # Libera todo o tráfego de saída.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Key Pair
# Importa chave SSH local para acesso à EC2.
resource "aws_key_pair" "sfbjj" {
  key_name   = "sfbjj-keypar"
  public_key = file("~/.ssh/id_rsa.pub")
}

# EC2 Instance
# Instância principal que hospedará a aplicação.
resource "aws_instance" "sfbjj" {
  # Imagem base do SO.
  ami = "ami-00e801948462f718a"

  # Capacidade da instância (CPU/RAM).
  instance_type = "t3.micro"

  # Security Group da instância.
  vpc_security_group_ids = [aws_security_group.sfbjj.id]

  iam_instance_profile = "ECR_ROLE_SFBJJ"

  # Script de inicialização.
  user_data = file("./user_data.sh")

  # Chave SSH vinculada.
  key_name = aws_key_pair.sfbjj.key_name

  # Identificação do recurso.
  tags = {
    Name          = "sfbjj"
    ProvisionedBy = "Terraform"
    GitHub        = "github.com/umluks/sfbjj"
  }
}