module "ec2" {
    source              = "./modules/ec2"
    aws_region          = var.aws_region
    vpcid               = var.vpcid
    subnetid            = var.subnetid
    securitygroup_id    = module.securitygroup.teste_securitygroup_id
}

module "securitygroup" {
    source              = "./modules/securitygroup"
    aws_region          = var.aws_region
    vpcid              = var.vpcid
    subnetid            = var.subnetid
}

module "alb" {
    source      = "./modules/alb"
    aws_region  = var.aws_region
    vpcid       = var.vpcid
    securitygroup_id = module.securitygroup.teste_securitygroup_id
    subnetid    = var.subnetid
    subnetid_2  = var.subnetid_2
    instance_id = module.ec2.instance_id
}

module "rds" {
    source              = "./modules/rds"
    #aws_region          = var.aws_region
    #vpcid               = var.vpcid
    #subnetid            = var.subnetid
    #securitygroup_id    = module.securitygroup.teste_securitygroup_id
}
