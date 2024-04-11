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
variable "auto_deploy" {
  description = "Auto deploy the API Gateway"
  type        = bool  
}