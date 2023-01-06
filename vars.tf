variable "transit_gateway_id" {
  description = "Transit Gateway ID"
}

variable "transit_gateway_route_table_name" {
  description = "Nome da Tabela de Rotas do Transit Gateway"
}

variable "tags" {
  description = "Tags que serão adicionadas na Tabela de Rotas do Transit Gateway"
  type        = map
}

variable "transit_gateway_attachment_id" {
  description = "Transit Gateway Attachment ID para a Tabela Criada"
  type        = list
}

variable "transit_gateway_routes" {
  description = "Informações das Rotas de VPC e qual o destinho "
  type = list(object({
    attachment_id          = any
    blackhole              = bool
    destination_cidr_block = string
  }))
}

variable "propagation_route_table" {
  description = "Boolean Propagation Route Table"
  type        = bool
  default     = false
}
