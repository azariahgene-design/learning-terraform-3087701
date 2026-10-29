# The data "aws_ami" lookup was removed because it calls ec2:DescribeImages,
# which your organization's SCP denies. The AMI ID is now passed in directly.

variable "ami_id" {
  description = "Bitnami Tomcat AMI ID for your region (e.g. ami-0123456789abcdef0)"
  type        = string

  validation {
    condition     = can(regex("^ami-[0-9a-f]{8,17}$", var.ami_id))
    error_message = "ami_id must look like ami-0123456789abcdef0."
  }
}

resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = "t3.nano"

  tags = {
    Name = "HelloWorld"
  }
}
