provider "aws" {
  region     = "ap-south-1"                               # AWS Region (Mumbai)
  access_key = ""                     # Replace with your Access Key
  secret_key = "" # Replace with your Secret Key
}
#-------------------------------
# Create a Key Pair
# -------------------------------
resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "terraform_key" {
  key_name   = "terraform-key"
  public_key = tls_private_key.ec2_key.public_key_openssh
}

# Save the private key locally (optional)
resource "local_file" "private_key" {
  content  = tls_private_key.ec2_key.private_key_pem
  filename = "${path.module}/terraform-key.pem"
}

# -------------------------------
# Security Group (Allow SSH)
# -------------------------------
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # ⚠️ Open to all — restrict in production
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh_sg"
  }
}

# -------------------------------
# EC2 Instance
# -------------------------------
resource "aws_instance" "linux_server" {
  ami                    = "ami-00af95fa354fdb788" # Amazon Linux 2 AMI for ap-south-1
  instance_type          = "t3.micro"
  key_name               = "devops_session"
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "TerraformLinuxEC2"
  }
}
