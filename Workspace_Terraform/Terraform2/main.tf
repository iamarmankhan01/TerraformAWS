variable "instance_type" {
  description = "This is instance type"
}


resource "aws_instance" "vm_1" {
  ami             = "ami-00af95fa354fdb788"  //on AWS and go on instance AMI copy
  instance_type   = var.instance_type
  key_name        = "devops_session"   //own Create 
  security_groups = ["default"]
}