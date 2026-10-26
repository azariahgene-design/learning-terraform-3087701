# Fetch the latest Amazon Linux 2023 AMI via SSM (bypasses SCP DescribeImages restriction)[cite: 1, 3]
data "aws_ssm_parameter" "al2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

# Get the default VPC so the instance has a valid network to launch into
data "aws_vpc" "default" {
  default = true
}

# Get a default subnet inside that VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ssm_parameter.al2023.value
  instance_type = "t2.micro"
  
  # Explicitly assign to the first available default subnet to prevent placement errors
  subnet_id     = data.aws_subnets.default.ids[0]

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
