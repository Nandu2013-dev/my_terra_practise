resource "aws_instance" "example" {
  ami           = "ami-00ca32bbc84273381"
  instance_type = "t2.micro"
  key_name      = "mysshkey"
  tags = {
    Name = "RemoteExecExample"
  }
}

resource "null_resource" "remote_script" {
  # Trigger this when instance ID or public IP changes
  triggers = {
    instance_id = aws_instance.example.id
    instance_ip = aws_instance.example.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "echo Hello from remote VM",
      "touch /home/ec2-user/created_by_null_resource.txt"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("mysshkey")  # path to your .pem file
      host        = aws_instance.example.public_ip
      agent       = false
    }
  }
}
