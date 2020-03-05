resource "aws_instance" "teste" {
	ami = "ami-07ebfd5b3428b6f4d"
	instance_type = "t3.nano"
	key_name = "elk"
	#availability_zone = "${var.aws_region}"

	subnet_id = var.subnetid
	vpc_security_group_ids  = [var.securitygroup_id]

	tags = {
		Name = "teste"
	}
}
