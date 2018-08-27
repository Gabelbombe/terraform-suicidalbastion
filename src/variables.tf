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

/** Region which is used by default during te rollout */
variable "region" {
  description = "AWS region to host the Ehimeprefecture network"
  default     = "us-west-2"
}

/** AZ which is used by default during the deployment */
variable "default_az" {
  type = "map"

  description = "Default AZ"

  default = {
    us-east-1      = "us-east-1a"
    us-east-2      = "us-east-2a"
    us-west-1      = "us-west-1a"
    us-west-2      = "us-west-2a"
    ca-central-1   = "ca-central-1a"
    eu-west-1      = "eu-west-1a"
    eu-central-1   = "eu-central-1a"
    eu-west-2      = "eu-west-2a"
    ap-southeast-1 = "ap-southeast-1a"
    ap-southeast-2 = "ap-southeast-2a"
    ap-northeast-1 = "ap-northeast-1a"
    ap-northeast-2 = "ap-northeast-2a"
    ap-south-1     = "ap-south-1a"
    sa-east-1      = "sa-east-1a"
  }
}

variable "vpc_gw" {
  description = "GW for the vpc"
  default     = "10.0.0.1"
}

variable "ehime_gw" {
  description = "GW for the Ehimeprefecture network"
  default     = "10.0.1.1"
}

variable "vpc_cidr" {
  description = "CIDR for VPC"
  default     = "10.0.0.0/16"
}

variable "ehime_ip" {
  description = "Ehimeprefecture Director IP (if needed)"
  default     = "10.0.1.6"
}

variable "ehime_subnet_cidr" {
  description = "CIDR for Ehimeprefecture subnet"
  default     = "10.0.1.0/24"
}

variable "public_subnet_cidr" {
  description = "CIDR for public subnet"
  default     = "10.0.0.0/24"
}

variable "death_clock" {
  description = "Countdown [in hours] until box commits suicide"
  default     = "1"
}
