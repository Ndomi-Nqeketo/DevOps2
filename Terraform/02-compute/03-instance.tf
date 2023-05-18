module "network" {
  source = "../01-network"
}

module "SSM_agent" {
  source = "../05-SSMagent"
  
}


resource "aws_instance" "myec2vm" {
  ami = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type
  subnet_id = module.network.subnet_id
  key_name = var.key
  user_data = file("${path.module}/apache.sh")
  monitoring = true
  iam_instance_profile = module.SSM_agent.profile_id
  vpc_security_group_ids = [module.network.SSHsecurityGroupID, module.network.WEBsecurityGroupID]

  tags = {
    "Name" = "EC2 Demo"
  }
}