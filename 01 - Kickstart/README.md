# Kickstart com Terraform

Inicializar projeto terraform

```bash
terraform init
```

<br>

Gerar plano de ação para os passos determinados

```bash
terraform plan
```

<br>

Aplicar as mudanças

```bash
terraform apply
```

## Variáveis

Existem várias maneiras de trabalhar com variáveis de ambiente no Terraform, desde inserir os valores durante a execução no prompt, como através do arquivo: <code>terraform.tfvars</code>, com variáveis de ambiente: <code>export TF_VAR_conteudo="Meu conteúdo"</code>, com o argumento <code>terraform apply -var "conteudo=xpto"</code> na linha de comando, e também é possível utilizar o arquivo de variáveis com o nome customisado: <code>terraform apply -var-file any-name.tfvars</code>.

Sintaxe da declaração de variáveis

```terraform
variable "conteudo" {
  type = string
  default = "value"
  description = "value"
  .
  .
  .
}
```
