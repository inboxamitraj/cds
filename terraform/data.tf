data "aws_availability_zones" "available" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}


# https://aws.amazon.com/blogs/containers/amazon-ebs-csi-driver-is-now-generally-available-in-amazon-eks-add-ons/ 
data "aws_iam_policy" "ebs_csi_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

/*
data "aws_lb" "kic_nlb" {
  name = "a8766bd02556a46b0957e35a3b1d580f"  # Replace with the actual kong_ingress_controller_nlb NLB name
}

data "aws_route53_zone" "aayan" {
  name = "aayan.link"   # Replace with the actual hosted zone name
}
*/
