# Cloud Infrastructure

Este repositório contém a infraestrutura como código (IaC) para o provisionamento e gerenciamento do ambiente na AWS utilizando Terraform. 

## Estrutura do Projeto

A configuração principal da infraestrutura encontra-se no diretório `infra/`:

- `infra/main.tf`: Declaração dos recursos principais da AWS, como a instância EC2, Security Groups, etc.
- `infra/backend.tf`: Configuração do backend do Terraform para armazenamento do estado (state).
- `infra/user_data.sh`: Script executado durante a inicialização da instância EC2 (provisionamento de dependências como Docker e a aplicação `sfbjj-app`).

## Pré-requisitos

Para trabalhar neste projeto, você precisará ter instalado:

- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- [AWS CLI](https://aws.amazon.com/cli/) configurado com suas credenciais (`~/.aws/credentials`)

## Como Usar

1. **Inicialize o Terraform:**
   Acesse a pasta da infraestrutura e inicialize o Terraform para baixar os providers e configurar o backend:
   ```bash
   cd infra
   terraform init
   ```

2. **Verifique o Plano de Execução:**
   Visualize as modificações que o Terraform fará na sua conta AWS:
   ```bash
   terraform plan
   ```

3. **Aplique as Configurações:**
   Para provisionar a infraestrutura descrita nos arquivos:
   ```bash
   terraform apply
   ```
   *(Confirme digitando `yes` quando solicitado).*

4. **Destruir a Infraestrutura:**
   Quando os recursos não forem mais necessários e para evitar custos adicionais:
   ```bash
   terraform destroy
   ```

## Notas Adicionais

- Certifique-re de que sua AWS CLI tem as permissões adequadas para criar instâncias EC2 e Security Groups.
- A imagem Docker da aplicação (`sfbjj-app`) é puxada via ECR ou Docker Hub, conforme parametrizado no `user_data.sh`.
