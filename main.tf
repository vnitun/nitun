
## VPC

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Project = "practical"
    Name = "My VPC"
 }
}

# PUBLIC SUBNET 1

resource "aws_subnet" "pub_sub_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.pub_sub_a_cidr_block
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true
  tags = {
    Project = "practical"
     Name = "public_subnet_a"
 
 }
}

#  PUBLIC SUBNET 2

resource "aws_subnet" "pub_sub_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.pub_sub_b_cidr_block
  availability_zone       = "us-west-2b"
  map_public_ip_on_launch = true
  tags = {
    Project = "practical"
    Name = "public_subnet_b" 
 }
}

#  PUBLIC SUBNET 3

resource "aws_subnet" "pub_sub_c" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.pub_sub_c_cidr_block
  availability_zone       = "us-west-2c"
  map_public_ip_on_launch = true
  tags = {
    Project = "practical"
    Name = "public_subnet_c" 
 }
}

# PRIVATE SUBNET 1

resource "aws_subnet" "prv_sub_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.prv_sub_a_cidr_block
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = false

  tags = {
    Project = "practical"
    Name = "private_subnet_a" 
 }
}

## PRIVATE SUBNET 2

resource "aws_subnet" "prv_sub_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.prv_sub_b_cidr_block
  availability_zone       = "us-west-2b"
  map_public_ip_on_launch = false

  tags = {
    Project = "practical"
    Name = "private_subnet_b"
  }
}

## PRIVATE SUBNET 3

resource "aws_subnet" "prv_sub_c" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.prv_sub_c_cidr_block
  availability_zone       = "us-west-2c"
  map_public_ip_on_launch = false

  tags = {
    Project = "practical"
    Name = "private_subnet_c"
  }
}

# INTERNET GATEWAY

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Project = "practical"
    Name = "internet gateway" 
 }
}

# PUBLIC ROUTE TABLE

resource "aws_route_table" "pub_sub1_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Project = "practical"
    Name = "route table" 
 }
}

# Create route table association of public subnet 1

resource "aws_route_table_association" "internet_for_pub_sub1" {
  route_table_id = aws_route_table.pub_sub1_rt.id
  subnet_id      = aws_subnet.pub_sub_a.id
}

# Create route table association of public subnet 2

resource "aws_route_table_association" "internet_for_pub_sub2" {
  route_table_id = aws_route_table.pub_sub1_rt.id
  subnet_id      = aws_subnet.pub_sub_b.id
}

# Create route table association of public subnet 3

resource "aws_route_table_association" "internet_for_pub_sub3" {
  route_table_id = aws_route_table.pub_sub1_rt.id
  subnet_id      = aws_subnet.pub_sub_c.id
}


# Create EIP for NAT GW1
  resource "aws_eip" "eip_natgw1" {
  count = "1"
}

# Create NAT gateway1

resource "aws_nat_gateway" "natgateway_1" {
  count         = "1"
  allocation_id = aws_eip.eip_natgw1[count.index].id
  subnet_id     = aws_subnet.pub_sub_a.id
}

# Create EIP for NAT GW2

resource "aws_eip" "eip_natgw2" {
  count = "1"
}

# Create NAT gateway2

resource "aws_nat_gateway" "natgateway_2" {
  count         = "1"
  allocation_id = aws_eip.eip_natgw2[count.index].id
  subnet_id     = aws_subnet.pub_sub_b.id
}


# Create EIP for NAT GW3

resource "aws_eip" "eip_natgw3" {
  count = "1"
}

# Create NAT gateway3

resource "aws_nat_gateway" "natgateway_3" {
  count         = "1"
  allocation_id = aws_eip.eip_natgw3[count.index].id
  subnet_id     = aws_subnet.pub_sub_c.id
}

# Create private route table for prv sub1

resource "aws_route_table" "prv_sub1_rt" {
  count  = "1"
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgateway_1[count.index].id
  }
  tags = {
    Project = "practical"
    Name = "private subnet1 route table" 
 }
}

# Create route table association betn prv sub1 & NAT GW1

resource "aws_route_table_association" "pri_sub1_to_natgw1" {
  count          = "1"
  route_table_id = aws_route_table.prv_sub1_rt[count.index].id
  subnet_id      = aws_subnet.prv_sub_a.id
}

# Create private route table for prv sub2

resource "aws_route_table" "prv_sub2_rt" {
  count  = "1"
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgateway_2[count.index].id
  }
  tags = {
    Project = "practical"
    Name = "private subnet2 route table"
  }
}

# Create route table association betn prv sub2 & NAT GW2

resource "aws_route_table_association" "pri_sub2_to_natgw1" {
  count          = "1"
  route_table_id = aws_route_table.prv_sub2_rt[count.index].id
  subnet_id      = aws_subnet.prv_sub_b.id
}

# Create private route table for prv sub3

resource "aws_route_table" "prv_sub3_rt" {
  count  = "1"
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgateway_3[count.index].id
  }
  tags = {
    Project = "practical"
    Name = "private subnet3 route table"
  }
}

# Create route table association betn prv sub3 & NAT GW3

resource "aws_route_table_association" "pri_sub3_to_natgw3" {
  count          = "1"
  route_table_id = aws_route_table.prv_sub3_rt[count.index].id
  subnet_id      = aws_subnet.prv_sub_c.id
}


# Create security group for load balancer

resource "aws_security_group" "elb_sg" {
  name        = var.sg_name
  description = var.sg_description
  vpc_id      = aws_vpc.main.id

ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "HTTP"
    cidr_blocks = ["0.0.0.0/0"]
  }

egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
 
 tags = {
    Name = var.sg_tagname
    Project = "practical" 
  }	
}

# Create security group for webserver

resource "aws_security_group" "webserver_sg" {
  name        = var.sg_ws_name
  description = var.sg_ws_description
  vpc_id      = aws_vpc.main.id

ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "HTTP"
    cidr_blocks = ["0.0.0.0/0"]

 }

ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "HTTP"
    cidr_blocks = ["0.0.0.0/0"]
  }
egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

 tags = {
    Name = var.sg_ws_tagname 
    Project = "practical"
  }
}

## S3 BUCKET 

resource "aws_s3_bucket" "my_bucket"{
  bucket = var.bucket_name
  acl    = "private"

  tags = {
    Name        = "my_practical_s3_1"
  }
}

## IAM ROLE AND POLICY 

resource "aws_iam_instance_profile" "test_profile" {
  name = "test_profile"
  role = aws_iam_role.my_role.name
}


resource "aws_iam_role" "my_role"{
  name                = "my_role"
 assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  managed_policy_arns = [aws_iam_policy.policy.arn]
}

resource "aws_iam_policy" "policy" {
  name = var.bucket_name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:PutObject", "s3:GetObject"]
        Effect   = "Allow"
        Resource = [aws_s3_bucket.my_bucket.arn]
      },
    ]
  })
}

# Create Target group

resource "aws_lb_target_group" "TG-tf" {
  name     = "Demo-TargetGroup-tf"
  # depends_on = ["aws_vpc.main"]
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.main.id}"
  health_check {
    interval            = 70
    path                = "/index.html"
    port                = 80
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 60 
    protocol            = "HTTP"
    matcher             = "200,202"
  }
}

# Create LB

resource "aws_lb" "ALB-tf" {
   name              = "practical-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.elb_sg.id]
  subnets            = [aws_subnet.pub_sub_a.id,aws_subnet.pub_sub_b.id,aws_subnet.pub_sub_c.id]

  tags = {
	name  = "Demo-AppLoadBalancer-tf"
    	Project = "practical"
  }
}

# Create LB Listener 

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.ALB-tf.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.TG-tf.arn
  }
}


# LAUCH CONFIGURATION FOR AUTOSCALING

resource "aws_launch_configuration" "webserver-launch-config" {
  name_prefix   = "webserver-launch-config"
  image_id      =  var.ami
  instance_type = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.test_profile.name
  key_name        = aws_key_pair.mykeypair.key_name
  security_groups = ["${aws_security_group.webserver_sg.id}"]
  
  root_block_device {
            volume_type = "gp2"
            volume_size = 10
            encrypted   = true
        }

    ebs_block_device {
            device_name = "/dev/sdf"
            volume_type = "gp2"
            volume_size = 5
            encrypted   = true
        }
       

  lifecycle {
    create_before_destroy = true
  }
  user_data = filebase64("${path.module}/nginx.sh")
}


# Create Auto Scaling Group
resource "aws_autoscaling_group" "Demo-ASG-tf" {
  name		     = "practical-scale-tf"
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1
  force_delete       = true
  # depends_on 	     = ["aws_lb.ALB-tf"]
  target_group_arns  =  ["${aws_lb_target_group.TG-tf.arn}"]
  health_check_type  = "EC2"
  launch_configuration = aws_launch_configuration.webserver-launch-config.name
  vpc_zone_identifier = ["${aws_subnet.prv_sub_a.id}","${aws_subnet.prv_sub_b.id}","${aws_subnet.prv_sub_c.id}"]
  
  
 tag {
    key                 = "Name"
    value               = "Demo-ASG-tf"
    propagate_at_launch = true
    }
} 

