# AWS Provider Configuration
provider "aws" {
  region = "ap-south-1"  # Region for Mumbai (you can change to your desired region)
}

# Security Group: Allow SSH and HTTP traffic
resource "aws_security_group" "hello" {
  name        = "allow_ssh_http"
  description = "Allow SSH (22) and HTTP (3000) traffic"

  # Allow SSH (port 22) traffic
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere
  }

  # Allow HTTP (port 3000) traffic
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP from anywhere
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance Configuration
resource "aws_instance" "example" {
  ami           = "ami-0f918f7e67a3323f0"  # Amazon Linux 2 AMI for Mumbai region
  instance_type = "t2.micro"               # Instance type (t2.micro for free tier)

  key_name = var.key_name  # SSH Key name from input variable

  # Corrected reference to the security group
  security_groups = [aws_security_group.hello.name]  # Attach Security Group

  tags = {
    Name = "MyEC2Instance"
  }
}
