# Get an Availability Zone
data "aws_availability_zones" "az" {
  state = "available"
}

module "alexis-eip" {
  source  = "../modules/eip"
  project = var.project
  stage   = var.stage
}

module "alexis-sg" {
  source  = "../modules/sg"
  project = var.project
  stage   = var.stage
}

module "alexis-ebs" {
  source  = "../modules/ebs"
  size    = var.ebs_size
  az      = data.aws_availability_zones.az.names[0]
  project = var.project
  stage   = var.stage
}

module "alexis-key" {
  source   = "../modules/key"
  key_file = var.key_file
  project  = var.project
  stage    = var.stage
}

module "alexis-ec2" {
  source        = "../modules/ec2"
  instance_type = var.instance_type
  size          = var.root_size
  sg            = module.alexis-sg
  eip           = module.alexis-eip
  ebs           = module.alexis-ebs
  key_file      = var.key_file
  az            = data.aws_availability_zones.az.names[0]
  project       = var.project
  stage         = var.stage
}
