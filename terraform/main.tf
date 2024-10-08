module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = ">=5.1.1"

  name = "education-vpc"

  cidr = "10.0.0.0/16"
  azs  = slice(data.aws_availability_zones.available.names, 0, 3)

  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    Name = "${var.cluster_name}-public"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"  //tags for LB type service
    "kubernetes.io/role/elb" = "1"  //tags for LB type service
  }

  private_subnet_tags = {
    Name = "${var.cluster_name}-private"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"  //tags for LB type service
    "kubernetes.io/role/internal-elb" = "1" //tags for LB type service
  }
  tags = {
    Name = var.cluster_name
  }
}


module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = ">=19.15.3"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  cluster_enabled_log_types = [] # disable logs

  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets
  cluster_endpoint_public_access = true

  # create_aws_auth_configmap = true
  # manage_aws_auth_configmap = true
  enable_cluster_creator_admin_permissions = true

  
  self_managed_node_groups = {
    # comment here
    one = {
      name          = "node-group-t2.medium"
      instance_type = var.instance_type
      min_size      = var.min_nodes
      desired_size  = var.desired_nodes
      max_size      = var.max_nodes
      iam_role_additional_policies = {
        AutoScalingFullAccess = "arn:aws:iam::aws:policy/AutoScalingFullAccess" //for cluster auto-scaler
      }
      tags = {
        "k8s.io/cluster-autoscaler/enabled"  = "true"  //for cluster auto-scaler
        "kubernetes.io/cluster/amit-cluster" = "owned" //for cluster auto-scaler
        "Environment" = "test"
      }
    } 
    # comment here
  }
}


// addons can be later added after cluster is created

module "irsa-ebs-csi" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = ">=4.7.0"

  create_role                   = true
  role_name                     = "AmazonEKSTFEBSCSIRole-${module.eks.cluster_name}"
  provider_url                  = module.eks.oidc_provider
  role_policy_arns              = [data.aws_iam_policy.ebs_csi_policy.arn]
  oidc_fully_qualified_subjects = ["system:serviceaccount:kube-system:ebs-csi-controller-sa"]
}

resource "aws_eks_addon" "ebs-csi" {
  cluster_name             = module.eks.cluster_name
  addon_name               = "aws-ebs-csi-driver"
  service_account_role_arn = module.irsa-ebs-csi.iam_role_arn
  tags = {
    "eks_addon" = "ebs-csi"
    "terraform" = "true"
  }
}




