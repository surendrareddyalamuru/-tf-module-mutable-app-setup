data "aws_ami" "centos-8-ami" {
  name_regex  = "surendra centos8"
  owners      = ["762942456166"]
}