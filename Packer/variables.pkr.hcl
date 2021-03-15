##################################################
# Locals
##################################################
locals {
  ENVIRONMENT = "demo"
}

##################################################
# Region Variable
##################################################
variable "REGION" {
  type    = string
  default = "ap-northeast-1"
}

##################################################
# Instance Type Variable
##################################################
variable "INSTANCE_TYPE" {
  type    = string
  default = "t2.micro"
}

##################################################
# Ami Variable
##################################################
variable "AMIS" {
  type    = string
  default = "ami-09d28faae2e9e7138"
}