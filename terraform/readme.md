#### Project folder for creating an EKS cluster on aws
- Pre-requisites
  ```
  create the bucket beforehand(manually): amit-tf-backend
  dynamodb_table is required, create beforehand(manually): tf-lock
  dynamodb_table should have key as LockID and type String
  ```
- just run below command under EKS folder
- `tf init`
- `tf plan`
- `tf apply`

- to update kubeconfig
  ```
  aws eks --region $(terraform output -raw region) update-kubeconfig \
    --name $(terraform output -raw cluster_name)
  ```
- resources-
    - main.tf is written from the reference-
    - https://developer.hashicorp.com/terraform/tutorials/kubernetes/eks
    - https://github.com/hashicorp/learn-terraform-provision-eks-cluster
    - https://github.com/terraform-aws-modules/terraform-aws-eks/tree/master/examples/complete
    - others-
    - https://www.techtarget.com/searchcloudcomputing/tutorial/How-to-deploy-an-EKS-cluster-using-Terraform
    - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster

#### whats get created.
- when you run:
  ```
  module eks{

  }
  ```
  - This gets created-
  - eks cluster
  - aws_cloudwatch_log_group, module.eks.aws_iam_openid_connect_provider.oidc_provider, module.eks.aws_iam_policy.cluster_encryption
  - aws_iam_role, module.eks.aws_iam_role_policy_attachment.cluster_encryption
  - module.eks.aws_security_group.cluster, module.eks.aws_security_group.node, module.eks.aws_security_group_rule.cluster
  - module.eks.module.kms.aws_kms_alias.this
  - elastic ip(check why it gets created)
  - auto-scaling group - Cluster Autoscaler utilizes Amazon EC2 Auto Scaling Groups to manage node groups
  - NAT Gateway(check why it gets created)
  - Internet Gateway(check why it gets created)
  - KMS key(check why it gets created)
  - cloudwatch log group
  - configmaps for certs and aws-auth

- inside eks module
  ```
   self_managed_node_groups {
     
   }
  ```
  - this creates a nodegroup
  - aws_autoscaling_group, aws_iam_instance_profile, module.eks.module.self_managed_node_group["one"].aws_iam_role.this[0]
  - module.eks.module.self_managed_node_group["one"].aws_iam_role_policy_attachment.this["arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"]
  - module.eks.module.self_managed_node_group["one"].aws_launch_template.


#### Steps
- provider
- create vpc
- security group
- create a role that has access to EKS
- once role is created, add two policies- 
    - The two policies allow you to properly access EC2 instances (where the worker nodes run) and EKS.
    - AmazonEKSClusterPolicy
    - AmazonEC2ContainerRegistryReadOnly-EKS
- create the EKS cluster.
- Set up an IAM role for the worker nodes
    - the policies that you attach will be for the EKS worker node policies.
    - AmazonEKSWorkerNodePolicy
    - AmazonEKS_CNI_Policy
    - EC2InstanceProfileForImageBuilderECRContainerBuilds
    - AmazonEC2ContainerRegistryReadOnly
- create the worker nodes - Self Managed Node Group

#### what I have currently-
- cluster_name: tele-test-eks
- role: eksctl-tele-test-eks-cluster-ServiceRole
- vpc: eksctl-tele-test-eks-cluster
- subnets: 6(3 connected to nat gateway and 3 connected internet gateway)
- cluster security group: eks-cluster-sg-tele-test-eks(in-All/out-All)
- additional security group- eksctl-tele-test-eks-cluster/ControlPlaneSecurityGroup(in-none/out-all)
- internet gateway- eksctl-tele-test-eks-cluster/InternetGateway
- NAT gateway- eksctl-tele-test-eks-cluster/NATGateway
