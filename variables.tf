variable "private_subnets" {
  type        = list(string)
  description = "Network ranges for private subnets created in the VPC. Devices in private subnets communicate to internet through a NAT Gateway."
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  validation {
    condition     = length(var.private_subnets) >= 2
    error_message = "A network requires at least 2 private subnets for other AWS services to function properly."
  }
}

variable "vpc_id" {
  type = string
}

variable "nat_subnet_id" {
  type = string
}
