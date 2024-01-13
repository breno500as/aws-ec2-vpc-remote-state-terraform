 


resource "aws_key_pair" "key" {
  key_name           = "aws-public-key"
  public_key = file("./ec2-key.pub")
}

 

resource "aws_instance" "ec2" {
  ami                         = "ami-0c7217cdde317cfec"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.key.key_name
  subnet_id                   = data.terraform_remote_state.vpc.outputs.subnet_id
  vpc_security_group_ids      = [data.terraform_remote_state.vpc.outputs.security_group_id]
  associate_public_ip_address = true
  user_data                   = file("./docs/init.sh")

  tags = {
    Name = "ec2-terraform"
  }

}