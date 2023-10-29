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
#   echo eyJwYXlsb2FkIjoiRzYwRFBiZjFhTklhdmJ3bnc4VkU1ZEFMczVPd0VEZkNzMmo2bEJpVGl6SGlLanI4MHVvcTZ3VXlDN2x3dUZiT1FDVlQ0L3BZSUt1QnlwUWtFTWVWZ1IwbDZrblZvTm4zMDFONGtpVVdHdUNjOEFIdCtlSnorRGUyR2crTldWUDZpVzZqUHYxZXJEbE8xVW9xVnJqRVpxaEo5eDVqQ25IK3dhVVVCOHlmTGdYem9OUUkyQi9KaVM0SG16ZE9qWGhYbjFzU0kvd0t0dzN5Mm51VmlUT0RzVVAxbmNHZHhsUXB4OGphcElhSjh6TXlNbTArb3VLUGJpSGp2WEhCOTdDTTkzRWpKQWFzWk1kVEVwa0hnaUtrK0g1Q1FHNElYSHBQVExHYXVuSC8vOXc3NlNyZlhpSW9Waml0cHRhU3oyOWplZGxFNjdWVUtSbVlZWW5iSjQ1NlZtMWhtUHREcko3OC9hbXltUDlCK2Q1dEx1WEZKeWVvOU1DRGNEUHpnY1R6cmRlVXZsRnlIZTd5K1ZZdnZ6N2lQbk5WK1NtZ0FrbUMrbUxaVWVYcGk3RmlLSE82TldhOGhkUmdqNWkrRFhocndqR0hHekg1MExvZStzMVNPL1U3VEViSUYxQmFkN0JQZGZjTHdmb2pxN1NPME1pajBTQnozb2NwZm90K0VhcXQ4b08zYXlKRndTK2VwR25uNGNuSlptRTRJdE5IUXM3SmIya2RJanByZEM2NW90NTJjaEtiQ2N5VklPOXJMRXh4cllJVC9EUGlmQlVQQnczYXJMdWdMV1BDUXVObW5DSTFiYkVUZ2d6cllDQmRUSllaN3NxTkFaMVN4RHkvNWRhejlMcWcwMmtZRzk1Qi9wUnBNd2wrQlFjZ2NxQjZwakJub1pNVXk1QzUrQURtLzlLSWJUeTZib3pTQ0NmR3JzWG9ER3BTMmhSb1FRNFVwdFNvb0NJMGtPYmRtbEdNdGFwL29hcjhYc1lFN1U2ZWplOVVkTVRRNnB4NXNFbFF0YS9FZmQrR1RnTHFTUnd3N2xBbi9oTnpDRzBsanI5dE1qblliN2pIaWxHZ3BMUGsrRlBrY29OU2N4bWxmOUJRdkdaVUlFcDVTVzZsZjkrdFdFZXNPS2xuS2VpSWxhK1JHUHJiTzRhdkVqN05HTUxVNmxmZnpmNGhod3JuQThSZUZObHpnMzhDUHRnSWZOMUxjY1dyQmZwWW0zNXhXNmxKcno4R2l2Tjk4YXlEaGRJMk01MGhHR1lPT2I5dmYxaUdST1QzOUhnSm1BL0FTeml6MTZURnlUcXRWcGFla1hkOXhBbzJuZmV5QUpnRU5RS3giLCJkYXRha2V5IjoiQVFJQkFIaGZyRlEyYUlJd0Y1VmM3OVJIRVBHbmNVV3VyMi9Kek04dC9aem9FdFJyQWdGcDlLblpzTHVualZyQWhvckFzcmF5QUFBQWZqQjhCZ2txaGtpRzl3MEJCd2FnYnpCdEFnRUFNR2dHQ1NxR1NJYjNEUUVIQVRBZUJnbGdoa2dCWlFNRUFTNHdFUVFNSkN4VVgrY3BDRXhuNWpwY0FnRVFnRHZVa2tuZCtTMXZmOFQ3T3VxSHhPcWdNM3E2VmtVeTA2b29XM0hSdWtLbGlSQi91dkdRSUMxWCtxcXZ2a0cycWZsYkl1OTd1bDdpZmFCeUJBPT0iLCJ2ZXJzaW9uIjoiMiIsInR5cGUiOiJEQVRBX0tFWSIsImV4cGlyYXRpb24iOjE2OTgyODA4NTF9 | docker login -u AWS --password-stdin 338315907544.dkr.ecr.eu-north-1.amazonaws.com
#   docker pull 338315907544.dkr.ecr.eu-north-1.amazonaws.com/examensarbete:latest
#   docker run -d -p 80:80 338315907544.dkr.ecr.eu-north-1.amazonaws.com/examensarbete:latest
#   EOF
# }

resource "aws_launch_template" "example" {

  name                 = "ogges-launch-template"
  description          = "Example Launch Template for Auto Scaling Group"
  image_id             = "ami-0550c2ee59485be53"
  instance_type        = "t3.micro"
  key_name             = "AwsKey"
  security_group_names = ["security-group-ogge"]
  user_data            = base64encode(<<-EOF
  #!/bin/bash
  sudo yum update -y
  sudo amazon-linux-extras enable docker
  sudo yum install -y docker
  sudo systemctl start docker
  sudo systemctl enable docker
  sudo usermod -aG docker ec2-user
  echo eyJwYXlsb2FkIjoiRzYwRFBiZjFhTklhdmJ3bnc4VkU1ZEFMczVPd0VEZkNzMmo2bEJpVGl6SGlLanI4MHVvcTZ3VXlDN2x3dUZiT1FDVlQ0L3BZSUt1QnlwUWtFTWVWZ1IwbDZrblZvTm4zMDFONGtpVVdHdUNjOEFIdCtlSnorRGUyR2crTldWUDZpVzZqUHYxZXJEbE8xVW9xVnJqRVpxaEo5eDVqQ25IK3dhVVVCOHlmTGdYem9OUUkyQi9KaVM0SG16ZE9qWGhYbjFzU0kvd0t0dzN5Mm51VmlUT0RzVVAxbmNHZHhsUXB4OGphcElhSjh6TXlNbTArb3VLUGJpSGp2WEhCOTdDTTkzRWpKQWFzWk1kVEVwa0hnaUtrK0g1Q1FHNElYSHBQVExHYXVuSC8vOXc3NlNyZlhpSW9Waml0cHRhU3oyOWplZGxFNjdWVUtSbVlZWW5iSjQ1NlZtMWhtUHREcko3OC9hbXltUDlCK2Q1dEx1WEZKeWVvOU1DRGNEUHpnY1R6cmRlVXZsRnlIZTd5K1ZZdnZ6N2lQbk5WK1NtZ0FrbUMrbUxaVWVYcGk3RmlLSE82TldhOGhkUmdqNWkrRFhocndqR0hHekg1MExvZStzMVNPL1U3VEViSUYxQmFkN0JQZGZjTHdmb2pxN1NPME1pajBTQnozb2NwZm90K0VhcXQ4b08zYXlKRndTK2VwR25uNGNuSlptRTRJdE5IUXM3SmIya2RJanByZEM2NW90NTJjaEtiQ2N5VklPOXJMRXh4cllJVC9EUGlmQlVQQnczYXJMdWdMV1BDUXVObW5DSTFiYkVUZ2d6cllDQmRUSllaN3NxTkFaMVN4RHkvNWRhejlMcWcwMmtZRzk1Qi9wUnBNd2wrQlFjZ2NxQjZwakJub1pNVXk1QzUrQURtLzlLSWJUeTZib3pTQ0NmR3JzWG9ER3BTMmhSb1FRNFVwdFNvb0NJMGtPYmRtbEdNdGFwL29hcjhYc1lFN1U2ZWplOVVkTVRRNnB4NXNFbFF0YS9FZmQrR1RnTHFTUnd3N2xBbi9oTnpDRzBsanI5dE1qblliN2pIaWxHZ3BMUGsrRlBrY29OU2N4bWxmOUJRdkdaVUlFcDVTVzZsZjkrdFdFZXNPS2xuS2VpSWxhK1JHUHJiTzRhdkVqN05HTUxVNmxmZnpmNGhod3JuQThSZUZObHpnMzhDUHRnSWZOMUxjY1dyQmZwWW0zNXhXNmxKcno4R2l2Tjk4YXlEaGRJMk01MGhHR1lPT2I5dmYxaUdST1QzOUhnSm1BL0FTeml6MTZURnlUcXRWcGFla1hkOXhBbzJuZmV5QUpnRU5RS3giLCJkYXRha2V5IjoiQVFJQkFIaGZyRlEyYUlJd0Y1VmM3OVJIRVBHbmNVV3VyMi9Kek04dC9aem9FdFJyQWdGcDlLblpzTHVualZyQWhvckFzcmF5QUFBQWZqQjhCZ2txaGtpRzl3MEJCd2FnYnpCdEFnRUFNR2dHQ1NxR1NJYjNEUUVIQVRBZUJnbGdoa2dCWlFNRUFTNHdFUVFNSkN4VVgrY3BDRXhuNWpwY0FnRVFnRHZVa2tuZCtTMXZmOFQ3T3VxSHhPcWdNM3E2VmtVeTA2b29XM0hSdWtLbGlSQi91dkdRSUMxWCtxcXZ2a0cycWZsYkl1OTd1bDdpZmFCeUJBPT0iLCJ2ZXJzaW9uIjoiMiIsInR5cGUiOiJEQVRBX0tFWSIsImV4cGlyYXRpb24iOjE2OTgyODA4NTF9 | docker login -u AWS --password-stdin 338315907544.dkr.ecr.eu-north-1.amazonaws.com
  docker pull 338315907544.dkr.ecr.eu-north-1.amazonaws.com/examensarbete:latest
  docker run -d -p 80:80 338315907544.dkr.ecr.eu-north-1.amazonaws.com/examensarbete:latest
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
