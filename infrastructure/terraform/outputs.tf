# Media Mix Modeling Platform - Terraform Outputs

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = aws_subnet.private[*].id
}

output "ecs_cluster_id" {
  description = "ID of the ECS cluster"
  value       = aws_ecs_cluster.main.id
}

output "ecs_cluster_arn" {
  description = "ARN of the ECS cluster"
  value       = aws_ecs_cluster.main.arn
}

output "load_balancer_dns" {
  description = "DNS name of the load balancer"
  value       = aws_lb.main.dns_name
}

output "load_balancer_zone_id" {
  description = "Zone ID of the load balancer"
  value       = aws_lb.main.zone_id
}

output "data_bucket_name" {
  description = "Name of the S3 data bucket"
  value       = aws_s3_bucket.data.bucket
}

output "data_bucket_arn" {
  description = "ARN of the S3 data bucket"
  value       = aws_s3_bucket.data.arn
}

output "models_bucket_name" {
  description = "Name of the S3 models bucket"
  value       = aws_s3_bucket.models.bucket
}

output "models_bucket_arn" {
  description = "ARN of the S3 models bucket"
  value       = aws_s3_bucket.models.arn
}

output "mlflow_database_endpoint" {
  description = "Endpoint of the MLflow database"
  value       = var.environment == "production" ? aws_db_instance.mlflow[0].endpoint : "Not deployed in non-production"
  sensitive   = true
}

output "mlflow_database_port" {
  description = "Port of the MLflow database"
  value       = var.environment == "production" ? aws_db_instance.mlflow[0].port : null
}

output "api_security_group_id" {
  description = "ID of the API security group"
  value       = aws_security_group.api.id
}

output "rds_security_group_id" {
  description = "ID of the RDS security group"
  value       = aws_security_group.rds.id
}

output "sagemaker_role_arn" {
  description = "ARN of the SageMaker IAM role"
  value       = aws_iam_role.sagemaker.arn
}

output "ecs_task_role_arn" {
  description = "ARN of the ECS task IAM role"
  value       = aws_iam_role.ecs_task.arn
}

output "ecs_execution_role_arn" {
  description = "ARN of the ECS execution IAM role"
  value       = aws_iam_role.ecs_execution.arn
}

output "sagemaker_notebook_instance_name" {
  description = "Name of the SageMaker notebook instance"
  value       = var.enable_sagemaker_notebook ? aws_sagemaker_notebook_instance.main[0].name : "Not enabled"
}

output "cloudwatch_log_group_name" {
  description = "Name of the CloudWatch log group"
  value       = aws_cloudwatch_log_group.api.name
}

output "environment" {
  description = "Environment name"
  value       = var.environment
}

output "project_name" {
  description = "Project name"
  value       = var.project_name
}

output "aws_region" {
  description = "AWS region"
  value       = var.aws_region
}

# For use in CI/CD pipelines
output "deployment_info" {
  description = "Deployment information for CI/CD"
  value = {
    cluster_name     = aws_ecs_cluster.main.name
    service_name     = "${var.project_name}-api-service-${var.environment}"
    task_definition  = "${var.project_name}-api-${var.environment}"
    container_name   = "api"
    load_balancer    = aws_lb.main.dns_name
    data_bucket      = aws_s3_bucket.data.bucket
    models_bucket    = aws_s3_bucket.models.bucket
  }
}