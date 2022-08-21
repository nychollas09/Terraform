module "new-vpc" {
  source = "./modules/vpc"
  prefix = var.prefix
}

module "eks" {
  source              = "./modules/eks"
  prefix              = var.prefix
  vpc_id              = module.new-vpc.vpc_id
  cluster_name        = var.cluster_name
  logs_retention_days = var.logs_retention_days
  subnets_ids         = module.new-vpc.subnets_ids
  node_desired_size   = var.node_desired_size
  node_max_size       = var.node_max_size
  node_min_size       = var.node_min_size
}
