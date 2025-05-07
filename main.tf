provider "aws" {
  region = var.regions[0]  # us-east-1
}

# Fetch AZs for us-east-1
module "data_az" {
  source = "./modules/data_az"
  region = var.regions[0]  # us-east-1
}

# Create a single VPC in us-east-1
module "vpc" {
  source = "./modules/vpc"

  region              = var.regions[0]  # us-east-1
  vpc_cidr            = "10.0.0.0/16"
  vpc_name            = "${var.project_name}-vpc"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zones  = module.data_az.availability_zones  # Pass AZs here
}

# Create a security group
module "sg" {
  source = "./modules/sg"

  vpc_id   = module.vpc.vpc_id
  name     = "${var.project_name}-sg"
  addrule  = ["ssh", "http", "egress_all"]  # Add predefined rules here
  custom_rules = [
    {
      type        = "ingress"
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  tags = {
    Project = var.project_name
  }
}

# Create IAM resources
module "iam" {
  source       = "./modules/iam"
  project_name = var.project_name
  tags         = var.tags
  users = [
    { name = "alice", group = "admins", existing = false },
    { name = "bob", group = "developers", existing = false }
  ]
}

# Add the ELB module
module "elb" {
  source = "./modules/elb"

  name               = "${var.project_name}-elb"
  vpc_id             = module.vpc.vpc_id
  subnets            = module.vpc.public_subnet_ids
  security_group_id  = module.sg.security_group_id
  instance_ports     = [80]  # Default port for EC2 instances (can add more if needed)
  health_check_path  = "/"
}

# Cerate a key pair for SSH access
module "ssh_key" {
  source      = "./modules/ssh_key"
  project_name = var.project_name
}


# Create an Auto Scaling Group (ASG) with a Launch Template
module "autoscale" {
  source = "./modules/asg"
  
  project_name         = var.project_name
  ami_id               = var.ami_id
  instance_type        = var.instance_type
  key_name             = module.ssh_key.key_name  # Use the generated key name
  iam_instance_profile = module.iam.instance_profile_name
  security_group_id    = module.sg.security_group_id
  user_data            = <<-EOF
                        #!/bin/bash
                        yum update -y
                        yum install -y httpd
                        systemctl start httpd
                        systemctl enable httpd
                        echo "<h1>Hello from AutoScaling EC2!</h1>" > /var/www/html/index.html
                        EOF
  subnet_ids           = module.vpc.public_subnet_ids
  elb_target_group_arn = module.elb.target_group_arn
  tags                 = var.tags
  min_size             = 2
  max_size             = 4
  desired_capacity     = 2
}

# Create a multi AZ RDS instance with a read replica
module "rds" {
  source             = "./modules/rds"
  project_name       = var.project_name
  subnet_ids         = module.vpc.private_subnet_ids
  security_group_ids = [module.sg.security_group_id]
  db_username        = "${replace(var.project_name, "-", "")}admin"
  instance_class     = "db.t3.micro"
  db_password        = var.db_password
}


