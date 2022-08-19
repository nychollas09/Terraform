# O Terraform interagi com o seu Registry: https://registry.terraform.io
# resource = Bloco
# local_file = Provider
# exemplo = Mome do Provider no arquivo

resource "local_file" "exemplo" {
  filename = "meu-diretorio/exemplo123.txt"
  content  = var.conteudo
}

variable "conteudo" {
  type = string
}
