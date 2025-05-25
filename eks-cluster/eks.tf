module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.36"

  cluster_name    = local.name

  # Optional
  cluster_endpoint_public_access = true

  # Optional: Adds the current caller identity as an administrator via cluster access entry
  enable_cluster_creator_admin_permissions = true

  cluster_compute_config = {
    enabled    = true
    node_pools = ["general-purpose"]
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.intra_subnets

   eks_managed_node_group_defaults = {

    cluster_addons = {
         vpc-cni = {
            most-recent = true
         }

         kube-proxy = {
            most-recent = true
         }

         coredns = {
            most-recent = true
         }
    }
    instance_types = ["t2.medium"]
    attach_cluster_primary_serurity_group = true
  }

   eks_managed_node_groups = {
    cluster-ng = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      instance_types = ["t2.medium"]

      min_size     = 2
      max_size     = 10
      desired_size = 2

      capactity_type = "SPOT"
    }
  }

  tags = {
    Environment = local.env
    Terraform   = "true"
  }
}
