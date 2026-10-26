data "aws_ami" "app_ami" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-kernel-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_instance" "web" {
  # Hardcoded Amazon Linux 2023 AMI ID for us-west-2 
  ami           = "ami-0797582d9526acd22"
  
  # Fixed instance type from invalid "t8i.micro" to standard "t2.micro"
  instance_type = "t2.micro"

  user_data = <<-EOF
    #!/bin/bash
    dnf install -y docker
    systemctl enable --now docker
    docker run -d --restart unless-stopped -p 8080:8080 public.ecr.aws/docker/library/tomcat:latest
  EOF

  tags = {
    Name = "HelloWorld"
  }
}
