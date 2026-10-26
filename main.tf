resource "aws_instance" "web" {
  # The AMI ID is hardcoded here so Terraform never queries AWS using DescribeImages
  ami           = "ami-07963b5f8c512d7c5" # Note: Ensure this matches your AWS Region (e.g., us-east-1)
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }
}
