provider "aws" {
  region = "eu-west-2"
  
}

# Get latest Amazon Linux AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

# Security group
resource "aws_security_group" "ec2_sg2_new" {

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["81.129.228.123/32"] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 instance
resource "aws_instance" "web2" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

vpc_security_group_ids = [aws_security_group.ec2_sg2_new.id]

 user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Hello from Terraform EC2</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "simple-web2"
  }
}



output "public_ip" {
  value = aws_instance.web2.public_ip
}