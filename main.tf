# data "aws_ami" was removed because it calls ec2:DescribeImages,
# which your organization's SCP denies.
#
# ami_id now has a default (empty), so Terraform no longer asks for it.
# - If you set ami_id (e.g. your Bitnami Tomcat AMI), that AMI is used.
# - If you leave it empty, the latest Amazon Linux 2023 AMI is read from
#   the public SSM parameter (no ec2:DescribeImages needed).

variable "ami_id" {
  description = "Optional AMI ID. Leave empty to use the latest Amazon Linux 2023."
  type        = string
  default     = ""
}

data "aws_ssm_parameter" "al2023" {
  count = var.ami_id == "" ? 1 : 0
  name  = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

locals {
  ami_id = var.ami_id != "" ? var.ami_id : nonsensitive(data.aws_ssm_parameter.al2023[0].value)
}

resource "aws_instance" "web" {
  ami           = local.ami_id
  instance_type = "t3.nano"

  tags = {
    Name = "HelloWorld"
  }
}

output "ami_used" {
  value = local.ami_id
}
