resource "aws_instance" "xpix_server"{
    ami = var.ami_id
    associate_public_ip_address = true
    availability_zone = "us-east-1a"
    iam_instance_profile = var.instance_profile_name
    instance_type = "t3.micro"
    key_name = "webapp"
    subnet_id = aws_subnet.az1_public.id
    vpc_security_group_ids = [aws_security_group.sc_group.id]
    user_data = file("${path.module}/user_data.sh")




}
import {
to = aws_instance.xpix_server
id = "i-083647926d4263c65"

}

output "xpix_server_public_ip" {
    value = aws_instance.xpix_server.public_ip
  
}