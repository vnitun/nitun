
variable "keyname"{
  
}
variable "region" {
  type        = string
  default     = "us-west-2"
  description = "default region"
}

variable "ami"{
 type = string
  default = "ami-00f7e5c52c0f43726"
}


variable "vpc_cidr" {
  type        = string
  default     = "196.16.0.0/16"
  description = "default vpc_cidr_block"
}

variable "pub_sub_a_cidr_block"{
   type        = string
   default     = "196.16.1.0/24"
}

variable "pub_sub_b_cidr_block"{
   type        = string
   default     = "196.16.2.0/24"
}
variable "pub_sub_c_cidr_block"{
   type        = string
   default     = "196.16.3.0/24"
}
variable "prv_sub_a_cidr_block"{
   type        = string
   default     = "196.16.4.0/24"
}
variable "prv_sub_b_cidr_block"{
   type        = string
   default     = "196.16.5.0/24"
}

variable "prv_sub_c_cidr_block"{
   type        = string
   default     = "196.16.6.0/24"
}

variable "sg_name"{
 type = string
 default = "my_alb_sg"
}

variable "sg_description"{
 type = string
 default = "sg for alb"
}

variable "sg_tagname"{
 type = string
 default = "ALB-SG"
}

variable "sg_ws_name"{
 type = string
 default = "webserver_sg"
}

variable "sg_ws_description"{
 type = string
 default = "SG for web server"
}

variable "sg_ws_tagname"{
 type = string
 default = "SG for web"
}

variable "AWS_ACCESS_KEY" {
}

variable "AWS_SECRET_KEY" {
}


variable "PATH_TO_PRIVATE_KEY" {
  default = "practical"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "practical.pub"
}

variable "bucket_name" {
  default = "my-one-practical-bucket"
}