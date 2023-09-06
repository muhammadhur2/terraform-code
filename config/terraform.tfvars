app_name         = "google"
environment_name = "terraform"


vpc_cidr = #add ip cidr
subnets-public = {
  "public_subnet1" = {
    cidr = #add ip1
  },
  "public_subnet2" = {
    cidr = #add ip2
  }
}

subnets-private = {
  "private_subnet1" = {
    cidr = #add ip1
  },
  "private_subnet2" = {
    cidr = #add ip2
  }
}

subnets-db = {
  "db_subnet1" = {
    cidr = #add ip1
  },
  "db_subnet2" = {
    cidr = #add ip2
  }
}




s3_frontend_public_block_properties = {
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

cloudfront_distribution_properties = {
  cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
  allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
  cached_methods         = ["GET", "HEAD"]
  viewer_protocol_policy = "redirect-to-https"
  error_caching_min_ttl  = 10
  error_code             = 403
  response_code          = 200
  response_page_path     = "/index.html"
  geo_restriction_type   = "none"
  locations              = []
}

sse_algorithm = "AES256"

db_properties = {
  "db1" = {
    allocated_storage   = 30,
    instance_class      = "db.t3.micro",
    engine              = "postgres",
    username            = #add username,
    password            = #add password,
    skip_final_snapshot = true
  }
}


public_access = true

ecs_task_definition_properties = {
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = "arn:aws:iam::881011112570:role/addnamehere"
  requires_compatibilities = ["EC2", "FARGATE"]
  container_image          = #add container image
  container_cpu            = 0
  container_memory         = 512
  container_port           = 3000
  host_port                = 3000
  log_group                = "/ecs/"
  log_region               = "us-east-1"
  log_stream_prefix        = "ecs"
}

ecs_cluster_properties = {
  container_insights = "disabled"
}

alb_properties = {
  internal = false
}


target_group_properties = {
  port     = 3000
  protocol = "HTTP"
  health_check = {
    healthy_threshold   = "2"
    interval            = "10"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "5"
    path                = "/api/health"
    unhealthy_threshold = "2"
  }
}

ecs_service_properties = [
  {
    launch_type          = "FARGATE"
    desired_count        = 1
    force_new_deployment = true
    assign_public_ip     = true
    container_name       = "dev"
    container_port       = 3000
    path_pattern         = "/xyz/*"
  },
  {
    launch_type          = "FARGATE"
    desired_count        = 1
    force_new_deployment = true
    assign_public_ip     = true
    container_name       = "mob"
    container_port       = 3000
    path_pattern         = "/abc/*"
  }
]

iam_policy_properties = {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}


main_securitygroup_ingress = [
  {
    description = "local server"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = #network cidr
  },
  
]

main_securitygroup_egress = [
  {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

main_load_balancer_sg_ingress = [
  {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Outside Traffic"
  }
]

main_load_balancer_sg_egress = [
  {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

main_container_sg_ingress = [
  {
    from_port = 3000
    to_port   = 3000
    protocol  = "tcp"
  }
]

main_container_sg_egress = [
  {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]


listeners = [
  {
    port     = 80,
    protocol = "HTTP"
  },
  {
    port     = 443,
    protocol = "HTTPS"
  }
]
