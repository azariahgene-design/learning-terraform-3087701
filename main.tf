resource "aws_instance" "web" {
  # Hardcoded Amazon Linux 2023 AMI ID for us-west-2 (avoids data "aws_ami" lookup)
  ami           = "ami-0797582d9526acd22"
  
  # Standard free-tier eligible instance type
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
