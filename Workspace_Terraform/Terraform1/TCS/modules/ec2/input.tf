# modules/ec2/inputs.tf
variable "ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-00af95fa354fdb788"
}


variable "instance_type"{
    description = "Instance type for EC2"
    type        = string
    default     = "t3.micro"
}

variable "instance_name" {
  description = "Tag name for EC2 instance"
  type        = string
  default     = "MyEC2Instance"
}

