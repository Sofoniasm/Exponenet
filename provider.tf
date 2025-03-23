provider "kubernetes" {
  config_path = "/mnt/c/Users/user/Desktop/infomaniak/terraform-openstack-rke2/examples/single-server/multi-server.rke2.yaml"
}

provider "helm" {
  kubernetes {
    config_path = "/mnt/c/Users/user/Desktop/infomaniak/terraform-openstack-rke2/examples/single-server/multi-server.rke2.yaml"
  }
}
