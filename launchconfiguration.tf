resource "aws_launch_configuration" "web" {
  name_prefix = "web-"

  image_id = "ami-0947d2ba12ee1ff75" # Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type = "t2.medium"
  key_name = "test servers"

  security_groups = [ aws_security_group.allow_http.id ]
  associate_public_ip_address = true
 
  }
}
