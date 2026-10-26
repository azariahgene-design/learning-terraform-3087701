resource "aws_instance" "web" {
  # The AMI ID is hardcoded here so Terraform never queries AWS using DescribeImages
  ami           = "ami-0c7217cdde317cfec" # Note: Ensure this matches your AWS Region (e.g., us-east-1)
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }
}
