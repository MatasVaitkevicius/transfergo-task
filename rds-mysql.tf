resource "aws_security_group" "rds_sg" {
  name        = "rds_mysql_security_group"
  description = "Security group for RDS MySQL instance to allow access from an application instance"

  # Allow inbound MySQL traffic from the specific application IP
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.1/32"] # Only allow access from this IP address
  }

  # Allow inbound MySQL traffic from the specific security group
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = ["sg-02ce123456e7893c7"] # Only allow access from instances in this security group
  }

  # Outbound rule to allow all traffic out
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }

  tags = {
    Name = "rds_mysql_security_group"
  }
}

# Attach SG to your RDS instance:
# resource "aws_db_instance" "mydb" {
#   vpc_security_group_ids = [aws_security_group.rds_sg.id]
#}
