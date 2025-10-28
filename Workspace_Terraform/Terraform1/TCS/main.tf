module "ec2" {
  source = "./modules/ec2"
}


module "S3" {
  source = "./modules/s3"
}
