variable "conteudo" {
  type = string
}

resource "local_file" "exemplo" {
  filename = "exemplo.txt"
  content  = var.conteudo
}

data "local_file" "conteudo-exemplo" {
  filename = "exemplo.txt"
}

output "id-do-arquivo" {
  value = resource.local_file.exemplo.id
}

output "datasource-result" {
  value = data.local_file.conteudo-exemplo.content
}
