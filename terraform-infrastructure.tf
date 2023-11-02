provider "aws" {
  region = "eu-north-1"
}

resource "aws_ecs_cluster" "my_ecs_cluster" {
  name = "MyECSCluster"
}

# Notera att "DependsOn" inte används i Terraform; Terraform hanterar automatiskt beroenden.

resource "aws_security_group" "my_sec_grp" {
  name        = "MySecGrp"
  description = "MySecGrp"
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


resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                   = "OggesTaskDef"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE", "EC2"]

  execution_role_arn = "arn:aws:iam::338315907544:role/ECSTaskExecution"

  cpu    = "256"
  memory = "512"
  container_definitions = jsonencode([
    {
      name  = "oggescontainer"
      image = "nginx"
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]

    }
  ])
}

resource "aws_ecs_service" "ecs_service" {
  name            = "OggesECSService"
  cluster         = aws_ecs_cluster.my_ecs_cluster.id
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count   = 2

  network_configuration {
    subnets = [
      "subnet-038809d3d73720fb5",
      "subnet-0b5058e004fd8e2bb",
      "subnet-06b09862b947ee15c",
    ]

    security_groups = [aws_security_group.my_sec_grp.id]

    assign_public_ip = "true"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.my_target_group.arn
    container_name   = "oggescontainer"
    container_port   = 80
  }
}

resource "aws_lb_target_group" "my_target_group" {
  name     = "MyTargetGroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-0fc88ebe86ed9b792"

  health_check {
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  target_type = "ip"
}

resource "aws_lb_listener" "my_listener" {
  load_balancer_arn = aws_lb.my_load_balancer.arn
  protocol          = "HTTP"
  port              = 80

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_target_group.arn
  }
}

resource "aws_lb" "my_load_balancer" {
  name               = "MyLB"
  load_balancer_type = "application"
  ip_address_type    = "ipv4"
  security_groups    = [aws_security_group.my_sec_grp.id]

  subnet_mapping {
    subnet_id = "subnet-038809d3d73720fb5"
  }

  subnet_mapping {
    subnet_id = "subnet-0b5058e004fd8e2bb"
  }

  subnet_mapping {
    subnet_id = "subnet-06b09862b947ee15c"
  }
}

resource "aws_codebuild_project" "ogges_build_project" {
  name         = "TerraformBuildProject"
  service_role = "arn:aws:iam::338315907544:role/oggeaccess"

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:7.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true
  }

  source {
    type     = "CODECOMMIT"
    location = "https://git-codecommit.eu-north-1.amazonaws.com/v1/repos/ExamensarbeteCC"
  }

  logs_config {
    cloudwatch_logs {
      status = "ENABLED"
    }
  }
}

resource "aws_codepipeline" "ogges_pipeline" {
  name = "TerraformPipeLine"

  artifact_store {
    location = "ogges-unika-s3-hink-king"
    type     = "S3"
  }

  role_arn = "arn:aws:iam::338315907544:role/oggeaccesspipeline"

  stage {
    name = "Source"

    action {
      name     = "SourceAction"
      category = "Source"
      owner    = "AWS"
      version  = "1"
      provider = "CodeCommit"

      configuration = {
        RepositoryName = "ExamensarbeteCC"
        BranchName     = "main"
      }

      output_artifacts = ["SourceOutput"]
    }
  }

  stage {
    name = "Build"

    action {
      name     = "BuildAction"
      category = "Build"
      owner    = "AWS"
      version  = "1"
      provider = "CodeBuild"

      configuration = {
        ProjectName = aws_codebuild_project.ogges_build_project.name
      }

      input_artifacts  = ["SourceOutput"]
      output_artifacts = ["BuildOutput"]
    }
  }

  stage {
    name = "Deploy"

    action {
      name     = "DeployAction"
      category = "Deploy"
      owner    = "AWS"
      version  = "1"
      provider = "ECS"

      configuration = {
        ClusterName = aws_ecs_cluster.my_ecs_cluster.name
        ServiceName = aws_ecs_service.ecs_service.name
        FileName    = "imagedefinitions.json"
      }

      input_artifacts = ["BuildOutput"]
    }
  }
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "ogges-unika-s3-hink-king"
}


