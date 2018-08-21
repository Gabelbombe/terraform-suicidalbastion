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
  description = "AWS region to host the Ehimeprefecture network"
  default     = "us-west-2"
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
