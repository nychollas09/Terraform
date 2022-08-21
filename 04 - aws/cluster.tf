resource "aws_security_group" "sg" {
  vpc_id = resource.aws_vpc.new-vpc.id

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    prefix_list_ids = []
  }

  tags = {
    Name = "${var.prefix}-sg"
  }
}

resource "aws_iam_role" "cluster" {
  name               = "${var.prefix}-${var.cluster_name}-role"
  assume_role_policy = <<POLICY
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Principal": {
            "Service": "eks.amazonaws.com"
          },
          "Effect": "Allow"
        }
      ]
    }
  POLICY
}

resource "aws_iam_role_policy_attachment" "cluster-AmazonEKSVPCResourceController" {
  role       = resource.aws_iam_role.cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}

resource "aws_iam_role_policy_attachment" "cluster-AmazonEKSClusterPolicy" {
  role       = resource.aws_iam_role.cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_cloudwatch_log_group" "log" {
  name              = "/aws/eks/${var.prefix}-${var.cluster_name}/cluster"
  retention_in_days = var.logs_retention_days
}


resource "aws_eks_cluster" "cluster" {
  name     = "${var.prefix}-${var.cluster_name}"
  role_arn = resource.aws_iam_role.cluster.arn

  enabled_cluster_log_types = ["api", "audit"]

  vpc_config {
    subnet_ids         = resource.aws_subnet.new-subnets[*].id
    security_group_ids = [resource.aws_security_group.sg.id]
  }

  depends_on = [
    resource.aws_cloudwatch_log_group.log,
    resource.aws_iam_role_policy_attachment.cluster-AmazonEKSVPCResourceController,
    resource.aws_iam_role_policy_attachment.cluster-AmazonEKSClusterPolicy
  ]
}
