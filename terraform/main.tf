terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
  shared_credentials_file = "/home/${var.user_name}/.aws/credentials"
  profile = "minecraft"
}

variable "aws_region" {
  description = "aws region to deploy your server"
  type = string
}

variable "user_name" {
  description = "userName from your local system deploying in AWS"
  type = string
}

variable "minecraft_keypair" {
  description = "AWS keypair to access the instance"
  type = string
}

variable "ubuntu_server_ami" {
  description = "AWS ami for ubuntu server"
  type = string
}

resource "aws_security_group" "allow_ssh_and_minecraft" {
  name = "allow_ssh_and_minecraft"
  description = "Allow ssh trafic and minecraft conections"

  ingress {
    description      = "SSH from Internet"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Minecraft from Internet"
    from_port        = 25565
    to_port          = 25565
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags{
    Name = "allow_ssh_and_minecraft"
  }
}

resource "aws_instance" "minecraftServer" {
  ami = ""
  instance_type = "t2.micro"
  key_name = var.minecraft_keypair
  associate_public_ip_address = "true"
  security_groups = [aws_security_group.allow_ssh_and_minecraft.name]

  tags{
    Name = "MinecraftServer"
  }
}
