/*
bucket name is Required, create the bucket beforehand(manually)
key is required.
region is required
dynamodb_table is required, create beforehand(manually)
dynamodb_table should have key as LockID and type String
*/

terraform {
  backend "s3" {
    bucket         = "amit-tf-backend" 
    key            = "eks/eks.tfstate"       
    region         = "ap-southeast-1"        
    dynamodb_table = "tf-lock"
  }
}
