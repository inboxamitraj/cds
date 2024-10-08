// oidc is not required because it is already created by EKS
  
/*resource "aws_iam_openid_connect_provider" "default" {
  url = module.eks.oidc_provider

  client_id_list = ["sts.amazonaws.com"]

  thumbprint_list = [""]
}
*/

/*
data "tls_certificate" "eks_cert" {
  url = module.eks.cluster_oidc_issuer_url
}
*/
/*
resource "aws_iam_openid_connect_provider" "eks_oidc" {
  url = module.eks.cluster_oidc_issuer_url

  client_id_list = ["sts.amazonaws.com"]

  thumbprint_list = [module.eks.cluster_tls_certificate_sha1_fingerprint]
}
*/