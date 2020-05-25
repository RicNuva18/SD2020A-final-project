###########################################################
# AWS ECS-EC2
###########################################################
resource "aws_instance" "ec2_instance" {
  ami                    = var.ami
  subnet_id              =  "subnet-966331ff"
  instance_type          = "t2.small"
  vpc_security_group_ids =  ["${aws_security_group.ssh-ramp-up.id}"]
  key_name               = "proyectosd" 
  ebs_optimized          = "false"
  source_dest_check      = "false"
  user_data              = "${data.template_file.user_data.rendered}"
  associate_public_ip_address = "true"





  lifecycle {
    ignore_changes         = ["ami", "user_data", "subnet_id", "key_name", "ebs_optimized", "private_ip"]
  }
}

data "template_file" "user_data" {
  template = "${file("${path.module}/user_data.tpl")}"
}











