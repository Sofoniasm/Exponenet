module "rke2" {
  source = "./../.."

  # must be true for single server cluster or
  # only on the first run for high-availability cluster 
  bootstrap           = true
  name                = "multi-server"
  ssh_authorized_keys = ["~/.ssh/id_rsa.pub"]
  floating_pool       = "ext-floating1"
  # should be restricted to a secure bastion
  rules_ssh_cidr = ["0.0.0.0/0"]
  rules_k8s_cidr = ["0.0.0.0/0"]
  # auto load manifest from a folder (https://docs.rke2.io/advanced#auto-deploying-manifests)
  manifests_folder = "./manifests"

  # Three control plane nodes
  servers = [
    {
      name             = "server-a"
      flavor_name      = "a2-ram4-disk0"
      image_name       = "Ubuntu 22.04 LTS Jammy Jellyfish"
      image_uuid       = "8ca95333-e5c3-4d9b-90bc-f261ca434114"
      system_user      = "ubuntu"
      boot_volume_size = 6
      rke2_version     = "v1.30.3+rke2r1"
      rke2_volume_size = 8
      rke2_config      = <<EOF
# Custom RKE2 configuration
EOF
    },
    {
      name             = "server-b"
      flavor_name      = "a2-ram4-disk0"
      image_name       = "Ubuntu 22.04 LTS Jammy Jellyfish"
      image_uuid       = "8ca95333-e5c3-4d9b-90bc-f261ca434114"
      system_user      = "ubuntu"
      boot_volume_size = 6
      rke2_version     = "v1.30.3+rke2r1"
      rke2_volume_size = 8
      rke2_config      = <<EOF
# Custom RKE2 configuration
EOF
    },
    {
      name             = "server-c"
      flavor_name      = "a2-ram4-disk0"
      image_name       = "Ubuntu 22.04 LTS Jammy Jellyfish"
      image_uuid       = "8ca95333-e5c3-4d9b-90bc-f261ca434114"
      system_user      = "ubuntu"
      boot_volume_size = 6
      rke2_version     = "v1.30.3+rke2r1"
      rke2_volume_size = 8
      rke2_config      = <<EOF
# Custom RKE2 configuration
EOF
    }
  ]

  # Four worker nodes
  agents = [
    {
      name             = "pool"
      nodes_count      = 4 # Adjusted for four worker nodes
      flavor_name      = "a1-ram2-disk0"
      image_name       = "Ubuntu 22.04 LTS Jammy Jellyfish"
      image_uuid       = "8ca95333-e5c3-4d9b-90bc-f261ca434114"
      system_user      = "ubuntu"
      boot_volume_size = 6
      rke2_version     = "v1.30.3+rke2r1"
      rke2_volume_size = 8
    }
  ]

  backup_schedule  = "0 6 1 * *" # once a month
  backup_retention = 20

  kube_apiserver_resources = {
    requests = {
      cpu    = "75m"
      memory = "128M"
    }
  }

  kube_scheduler_resources = {
    requests = {
      cpu    = "75m"
      memory = "128M"
    }
  }

  kube_controller_manager_resources = {
    requests = {
      cpu    = "75m"
      memory = "128M"
    }
  }

  etcd_resources = {
    requests = {
      cpu    = "75m"
      memory = "128M"
    }
  }

  ff_autoremove_agent = "30s"
  ff_write_kubeconfig = true
  ff_native_backup    = true
  ff_wait_ready       = true

  identity_endpoint     = "https://api.pub1.infomaniak.cloud/identity"
  object_store_endpoint = "s3.pub1.infomaniak.cloud"
}

output "cluster" {
  value     = module.rke2
  sensitive = true
}

variable "project" {
  type = string
}

variable "username" {
  type = string
}

variable "password" {
  type = string
}

provider "openstack" {
  tenant_name = var.project
  user_name   = var.username
  password    = var.password
  auth_url    = "https://api.pub1.infomaniak.cloud/identity"
  region      = "dc3-a"
}

terraform {
  required_version = ">= 0.14.0"

  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 2.1.0"
    }
  }
}
