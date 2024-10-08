// https://repost.aws/knowledge-center/eks-set-up-externaldns

module "iam_eks_role" {
  source    = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  role_name = "external-dns"

  role_policy_arns = {
    policy = aws_iam_policy.external_dns_policy.arn
  }

  oidc_providers = {
    one = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:external-dns"]
    }
  }
}