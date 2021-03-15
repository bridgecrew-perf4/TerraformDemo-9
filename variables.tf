##################################################
# Locals
##################################################
locals {
  environment = "demo"
  sshkeypath  = "/home/ubuntu/IAC/Terraform_DEMO/SSH/demo-keypair.pub"
}

##################################################
# Valiables
##################################################
variable "demo-region" {
  type    = string
  default = "ap-northeast-1"
}

variable "demo-az" {
  type = list(string)
  default = [
    "ap-northeast-1a",
    "ap-northeast-1c",
    "ap-northeast-1d"
  ]
}

variable "demo-accessgip" {
  type      = string
  default   = "0.0.0.0/0"
  sensitive = true
}

variable "demo-ingress-ports" {
  type    = list(number)
  default = [22, 80]
}

variable "demo-instance-type" {
  type    = string
  default = "t2.micro"
}
