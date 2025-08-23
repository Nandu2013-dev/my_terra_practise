module "mymoduletest" {
source = "../mygan_modules"
ami-id = "ami-00ca32bbc84273381"
instance-type = "t2.micro"
name = "ganeshec2"
}