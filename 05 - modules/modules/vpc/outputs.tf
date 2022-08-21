output "vpc_id" {
  value = resource.aws_vpc.new-vpc.id
}

output "subnets_ids" {
  value = resource.aws_subnet.new-subnets[*].id
}
