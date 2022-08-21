variable "vpc_id" {
  type = string
}

variable "prefix" {
  type        = string
  description = "Prefix of created Resources"
}

variable "cluster_name" {
  type        = string
  description = "Name of EKS Cluster"
}

variable "logs_retention_days" {
  type        = number
  description = "Retention days for CloudWatch Logs"
}

variable "subnets_ids" {
  type        = list(string)
  description = "Subnet IDs for EKS Cluster"
}

variable "node_desired_size" {
  type        = number
  description = "Desired size of EKS Node Group"
}

variable "node_max_size" {
  type        = number
  description = "Maximum size of EKS Node Group"
}

variable "node_min_size" {
  type        = number
  description = "Minimum size of EKS Node Group"
}
