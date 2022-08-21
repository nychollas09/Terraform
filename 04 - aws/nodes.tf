resource "aws_iam_role" "node" {
  name               = "${var.prefix}-${var.cluster_name}-node-role"
  assume_role_policy = <<POLICY
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Principal": {
            "Service": "ec2.amazonaws.com"
          },
          "Effect": "Allow"
        }
      ]
    }
  POLICY
}

resource "aws_iam_role_policy_attachment" "node-AmazonEKSWorkerNodePolicy" {
  role       = resource.aws_iam_role.node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "node-AmazonEKS_CNI_Policy" {
  role       = resource.aws_iam_role.node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "node-AmazonEC2ContainerRegistryReadOnly" {
  role       = resource.aws_iam_role.node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_eks_node_group" "node-1" {
  cluster_name    = resource.aws_eks_cluster.cluster.name
  node_group_name = "node-1"
  node_role_arn   = resource.aws_iam_role.node.arn
  subnet_ids      = resource.aws_subnet.new-subnets[*].id
  instance_types  = ["t2.micro"]

  scaling_config {
    desired_size = var.node_desired_size
    max_size     = var.node_max_size
    min_size     = var.node_min_size
  }

  depends_on = [
    resource.aws_iam_role_policy_attachment.node-AmazonEKSWorkerNodePolicy,
    resource.aws_iam_role_policy_attachment.node-AmazonEKS_CNI_Policy,
    resource.aws_iam_role_policy_attachment.node-AmazonEC2ContainerRegistryReadOnly
  ]
}
