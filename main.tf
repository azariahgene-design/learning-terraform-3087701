resource "aws_instance" "web" {
  ami           = "ami-07963b5f8c512d7c5" # Make sure there are NO brackets [ ] around the ID
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }
}
