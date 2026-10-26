data "aws_ami" "app_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["bitnami-tomcat-*-x86_64-hvm-ebs-nami"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["979382823631"] # Bitnami
}

resource "aws_instance" "web" {
  ami           = "ami-0c7217cdde317cfec" # Replace with a valid AMI ID for your region
  instance_type = "t3.nano"

  tags = {
    Name = "HelloWorld"
  }
}
