resource "helm_release" "grafana" {
  name             = "grafana"
  repository       = "https://grafana.github.io/helm-charts"
  chart            = "grafana"
  namespace        = "monitoring"
  create_namespace = true

  set {
    name  = "service.type"
    value = "LoadBalancer" # Expose Grafana via LoadBalancer
  }

  set {
    name  = "adminUser"
    value = "admin" # Default admin username
  }

  set {
    name  = "adminPassword"
    value = "admin" # Default admin password
  }

  set {
    name  = "persistence.enabled"
    value = "true" # Enable persistence for Grafana
  }
}
