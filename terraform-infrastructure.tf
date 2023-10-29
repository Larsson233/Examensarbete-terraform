provider "aws" {
  region = "eu-north-1"
}

# resource "aws_instance" "my_instance" {
#   ami               = "ami-0550c2ee59485be53"
#   instance_type     = "t3.micro"
#   key_name          = "AwsKey"
#   security_groups   = ["security-group-ogge"]
#   availability_zone = "eu-north-1a"
#   user_data         = <<-EOF
#   #!/bin/bash
#   # Update package lists
#   sudo yum update -y
#   sudo amazon-linux-extras enable docker
#   sudo yum install -y docker
#   sudo systemctl start docker
#   sudo systemctl enable docker
#   sudo usermod -aG docker ec2-user
#   echo eyJwYXlsb2FkIjoiR0dHNldmWU1qS3ZZRGxlNXE3QWFtc0w4V1VPNkFNNjdlWS8wcDRHajN5ZU9CVVZzK0tQVncxL3FzdGhnRW1Oa0Y4R2Q1RmxVSGVIK0FOM0crVlhvdWNCQW9iaC8veDJZTHlBeFpMb2Q3SlVhbzFpb3JYbVFxcy91eXIxTm8wcXVFMmJ2VDEyUkMycEM2emZ6T0lEWksvS3Y5cVhRYTRqWWxLMHhveWptV3FvdlBnMGFEcmI3LzJWUlg5UEpzOWIyNEYvMUphYXlqWTN3R21PclF6Y05rcU5NYWRVSkFrbG8yYWNDNlN6a3VUc0tsV3JmcVlsbSs0eGpBN1BFQTYyNzVKQjdEYU9kZTR3Znc1emVMNzUrT3h6eCtDVi9paHdQZXBETjVEajQ3NEhhRTFwN1hKdHlzSjBxOEJjN2pseDlLcG5YUjIvWm1qSStmck5VbnV5L0xlcDRsTGJjOXAyL2xvaFBuQ0hWSC84Y0EybG1vS3IvdXExRC9wUjhadW9nRmFVT0JUWTBTRlhNSE1jMmRvdVEwL3ZOQnNNSFg1dTExeHhERHhZTGprS3lyUGI3dVltZTBHUEwycGgxOFU1a1JyMUVRZGtGWU10Wmx0TjlKUnlaZHBQS042WUhNUkxUYWw5ZVpCWTZvSVJra0k4aUpvcmkxeDNPU09uSVY0M3g0Y3RFVFcyQXFzaGUySE5xblB1dUNvbmtnK0lhWUlyV2tTTEY2MEM1QlgyVHNlbm0wMUVmSWVOZVRwUkM1bUFud1dadGxCUW1RZXBKanJ6QUpsTERnaW1iaWVhMTc5NUFBdVRFYXM3T1lCVHY1RUhvZHEyenVtMmlnS2RnOUUrS3prdCtnakJRdHlSSVdlS3lXWDJCZkxjaGVLODh0Y2ZhN0R4WkZBMXZUNklzVWpIaE9xbnA5SFc2Q1ZOUUdPeWgyZzUyMFlhNjROcUVocFQwZmtFRVhsbTBuWjZmQ3M2SEZ5R0NER3cvVTNES2VObW5BOTQzbHJaU0wvN0plNjh5YTdZYTgyd1VUYTR1QkdsWlZBK0djYmFRU2hhR05rOVRKQ0xsOVRnUy9HUWZFR010TlppcUlBdFliVTJQSUROelZia3NhWlJhbzh6WG5TbDRwcUtpMjVJdmdpdDN0Y0xlWmJMVzZJK3FxTmEwM3B4ei9qRGpLQ1U4cXE3ckFOWWRQcWdzZGJkUFVCcG5LR1RORDR0NDkzaGI0R21JWHcxY0l4dFFOdFlNeCsxZFM0ayt0VkRzSVhGd25NZ2xNV2FKc01nMVJLZWk1TktzWmx3OGVTeGhDVzMzaGpYWHFKcXlhSXpPN3luRWFnNWdOdzlPVjNXMUphbFRuL2o2VXJRc1oxQWdmSlQvNjFiQVY1VEJFSlNvaC9KMUYxRkIzUlp0ZlE9PSIsImRhdGFrZXkiOiJBUUVCQUhoK2RTK0JsTnUwTnhuWHdvd2JJTHMxMTV5amQrTE5BWmhCTFpzdW5PeGszQUFBQUg0d2ZBWUpLb1pJaHZjTkFRY0dvRzh3YlFJQkFEQm9CZ2txaGtpRzl3MEJCd0V3SGdZSllJWklBV1VEQkFFdU1CRUVESWFiTzZxalJUdVE4a2UrYmdJQkVJQTdsaWladVBpZUY0YjJURVBoUTZ5VWpSdkNKSms1Vm9Ma0loZER0WDVpT01iK0xZT0NCWkQrelVlUDZETU1xUSs5SzJlNHVCTUdXV0pMaWZzPSIsInZlcnNpb24iOiIyIiwidHlwZSI6IkRBVEFfS0VZIiwiZXhwaXJhdGlvbiI6MTY5ODY1MjEyN30= | docker login -u AWS --password-stdin 338315907544.dkr.ecr.eu-north-1.amazonaws.com
#   docker pull 338315907544.dkr.ecr.eu-north-1.amazonaws.com/examensarbete:latest
#   docker run -d -p 80:80 338315907544.dkr.ecr.eu-north-1.amazonaws.com/examensarbete:latest
#   EOF
# }

resource "aws_launch_template" "example" {

  name          = "ogges-launch-template"
  description   = "Example Launch Template for Auto Scaling Group"
  image_id      = "ami-0550c2ee59485be53"
  instance_type = "t3.micro"
  key_name      = "AwsKey"

  iam_instance_profile {
    name = "NoCredentials" # Replace with your IAM role name or ARN
  }
  network_interfaces {
    device_index    = 0
    subnet_id       = "subnet-038809d3d73720fb5"
    security_groups = [aws_security_group.example.id]
  }
  user_data = base64encode(<<-EOF
  #!/bin/bash
  sudo yum update -y
  sudo yum install -y docker
  sudo systemctl start docker
  sudo systemctl enable docker
  sudo usermod -aG docker ec2-user
  sudo aws ecr get-login-password --region eu-north-1 | sudo docker login --username AWS --password-stdin 338315907544.dkr.ecr.eu-north-1.amazonaws.com
  sudo docker pull 338315907544.dkr.ecr.eu-north-1.amazonaws.com/examensarbete:latest
  sudo docker run -d -p 80:80 338315907544.dkr.ecr.eu-north-1.amazonaws.com/examensarbete:latest
  EOF
  )

}

resource "aws_security_group" "example" {
  name        = "security-group-ogge"
  description = "Example security group for port 80 (HTTP)"
  vpc_id      = "vpc-0fc88ebe86ed9b792"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Define the target group
resource "aws_lb_target_group" "example" {
  name     = "ogges-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-0fc88ebe86ed9b792"
}

# Create the Application Load Balancer (ALB)
resource "aws_lb" "example" {
  name               = "example-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = ["subnet-038809d3d73720fb5", "subnet-0b5058e004fd8e2bb", "subnet-06b09862b947ee15c"] # Specify your subnets

  enable_deletion_protection = false

  security_groups = [aws_security_group.example.id]

  enable_http2 = true
}

# Attach the target group to the ALB
resource "aws_lb_listener" "example" {
  load_balancer_arn = aws_lb.example.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.example.arn
  }
}


resource "aws_autoscaling_group" "example" {
  name              = "ogges-auto-scaling-group"
  target_group_arns = [aws_lb_target_group.example.arn]
  launch_template {
    id      = aws_launch_template.example.id
    version = "$Latest"
  }
  vpc_zone_identifier = ["subnet-038809d3d73720fb5", "subnet-0b5058e004fd8e2bb", "subnet-06b09862b947ee15c"] # Specify your subnet IDs here
  min_size            = 1
  max_size            = 3
  desired_capacity    = 2
}

#
# sudo aws ecr get-login-password --region eu-north-1 | sudo docker login --username AWS --password-stdin 338315907544.dkr.ecr.eu-north-1.amazonaws.com
#
#