variable "environment" {
  description = "The environment to deploy to"
  type        = string
  default     = "dev"
}

variable "project" {
  description = "The name of the project"
  type        = string
  default     = "myapp"
}

variable "instance_type" {
  description = "Instance type to use"
  type        = string
  default     = "t2.micro"
}
