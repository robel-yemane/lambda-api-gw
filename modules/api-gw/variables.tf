variable "name" {
  description = "Name of the API Gateway"
  type        = string
  default = "api-gw"
  
}
variable "protocol" {
  description = "Protocol type"
  type        = string
  default = "HTTP"
}

variable "stage_name" {
  description = "Name of the stage"
  type        = string
    default = "dev"
}