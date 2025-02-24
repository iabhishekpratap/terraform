# This file is used to create an EC2 instance in the public subnet

resource "aws_instance" "nginxserver" {
    ami = "ami-00bb6a80f01f03502"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public-subnet.id
    vpc_security_group_ids = [aws_security_group.nginx-sg.id]
    associate_public_ip_address = true


    user_data = <<-EOF
                #!/bin/bash
                sudo apt install nginx -y
                sudo systemctl start nginx
                EOF
    tags = {
        Name = "nginxserver"
    }
}
