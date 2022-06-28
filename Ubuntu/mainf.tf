terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "Web_Server" {
  ami           = "ami-052efd3df9dad4825"
  instance_type = "t2.micro"
  key_name      = "Key-RicardoCosta"
  user_data     = <<-EOF
                    #!/bin/bash
                    cd /home/ubuntu
                    echo "<h1>Terraform Init HTML Page Welcome</h1>" > index.html
                    nohup busybox httpd -f -p 8080 & 
                    EOF
  vpc_security_group_ids = [
    "sg-05ab2fb5bca4c0c1d",
    "sg-01c755d675702f501",
    "sg-0677f61f65d157377"
  ]
  tags = {
    Name = "Web_Server_IaC_UBU_02"
  }
}