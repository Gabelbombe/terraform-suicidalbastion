/**
  Access key.
  NOTE: DO NOT CHECK IN!!!!
*/
variable "access_key" {
  description = "Access Key"
}

/**
  Secret key.
  NOTE: DO NOT CHECK IN!!!!
*/
variable "secret_key" {
  description = "Secret Access"
}

/** AZ which is used by default during the deployment */
variable "default_az" {
  description = "Default AZ"
  default     = "us-west-2a"
}

/** Region which is used by default during te rollout */
variable "region" {
  description = "AWS region to host the GE Healthcare network"
  default     = "us-west-2"
}

variable "vpc_gw" {
  description = "GW for the vpc"
  default     = "10.0.0.1"
}

variable "ge_gw" {
  description = "GW for the GE Healthcare network"
  default     = "10.0.1.1"
}

variable "vpc_cidr" {
  description = "CIDR for VPC"
  default     = "10.0.0.0/16"
}

variable "ge_ip" {
  description = "GE Healthcare Director IP"
  default     = "10.0.1.6"
}

variable "ge_subnet_cidr" {
  description = "CIDR for GE Healthcare subnet"
  default     = "10.0.1.0/24"
}

variable "public_subnet_cidr" {
  description = "CIDR for public subnet"
  default     = "10.0.0.0/24"
}

/* Ubuntu amis by region */
variable "amis" {
  type        = "map"
  description = "Base AMI to launch the vms"

  default = {
    ap-northeast-1 = "ami-084c11d846d999fea"
    ap-northeast-2 = "ami-0c03fb8e268249fdf"
    ap-northeast-3 = "ami-09a84070ca902bba4"
    ap-south-1     = "ami-0dc9f97e867772871"
    ap-southeast-1 = "ami-04883cdb7979d6824"
    ap-southeast-2 = "ami-0128a9ab7ef617d5c"
    ca-central-1   = "ami-c021aca4"
    cn-north-1     = "ami-0bf4c4979299204bf"
    cn-northwest-1 = "ami-01f7fe0edf7d647f9"
    eu-central-1   = "ami-047c33b824c3c615d"
    eu-west-1      = "ami-01d0677b864af7b79"
    eu-west-2      = "ami-6c90640b"
    eu-west-3      = "ami-0c5c5600091426c44"
    sa-east-1      = "ami-08fc3529a805a0d62"
    us-east-1      = "ami-0bfea244934cad3de"
    us-east-2      = "ami-0b5e57bda6c6f5b58"
    us-gov-west-1  = "ami-6bd6490a"
    us-west-1      = "ami-097d4ca5afbcbb272"
    us-west-2      = "ami-0d260575"
  }
}
