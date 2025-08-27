provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-00ca32bbc84273381" # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  key_name      = "mysshkey" # Replace with your SSH key pair name

  tags = {
    Name = "ProvisionerExample"
  }

  provisioner "file" {
    source      = "script.sh"
    destination = "/home/ec2-user/script.sh"

    connection {
        # make sure that 22 port enabled for ssh at default Security group
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("mysshkey") # Replace with your .pem path
      host        = self.public_ip
      agent       = false
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ec2-user/script.sh",
      "sudo /home/ec2-user/script.sh"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("mysshkey")
      host        = self.public_ip
      agent       = false
    }
  }

  provisioner "local-exec" {
    command = "echo Instance ${self.id} with IP ${self.public_ip} was created."
  }
}
