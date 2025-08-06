ami-id= "ami-084a7d336e816906b"
instance-type = "t2.nano"
#if you want to change filee name instead of terraform.tfvars some thing like "dev.tfvars"
# then you have to explicitly declared using below apply command 
# terraform apply -var-file="dev.tfvars"