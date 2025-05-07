resource "aws_db_subnet_group" "this" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "primary" {
  identifier              = "${var.project_name}-db-primary"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = var.instance_class
  username                = var.db_username
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = var.security_group_ids
  allocated_storage       = 20
  skip_final_snapshot     = true
  multi_az                = true
  publicly_accessible     = false
  backup_retention_period = 7
  storage_encrypted       = true
  db_name                 = "${replace(var.project_name, "-", "")}db"  # Corrected here
  port                    = 3306
}


resource "aws_db_instance" "replica" {
  identifier             = "${var.project_name}-db-replica"
  replicate_source_db    = aws_db_instance.primary.arn
  instance_class         = var.instance_class
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = var.security_group_ids
  publicly_accessible    = false
}
