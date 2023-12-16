# Interact with aws-API
packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = ">=1.2.1"
    }
  }
}

# Configure the builer
source "amazon-ebs" "ubuntu" {
  # AMI Configuration
  ami_name = "my-first-packer-image"
  # Access Configuration
  access_key = "AKIAW3EIUF4SWAJAWONI"
  region     = "us-east-1"
  secret_key = "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"
  # Run Configuration
  instance_type = "t2.micro"
  source_ami    = "ami-06aa3f7caf3a30282"
  ssh_username  = "ubuntu"
  vpc_id        = "vpc-026b5a013d5ca15d7"
  subnet_id     = "subnet-0570f2e3586bbb02f"
}

build {
  name    = "my-first-build"
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "shell" {
    inline = [
      "sudo apt update",
      "sudo apt install nginx -y",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx",
      "sudo ufw allow proto tcp from any to any port 22,80,243",
      "echo y | show ufw enable"
    ]
  }
  #post-processor "vagrant" {}
  #post-processor "compress" {}
}



