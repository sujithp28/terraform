provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_instance" "sp" {
   ami = "ami-012261b9035f8f938"
   instance_type = "t2.micro"
   key_name = "k8"
}
