resource "helm_release" "prometheus" {
  name             = "prometheus"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  namespace        = "monitoring"
  create_namespace = true

  set {
    name  = "grafana.enabled"
    value = "false" # Disable Grafana since we'll deploy it separately
  }

  set {
    name  = "prometheus.service.type"
    value = "LoadBalancer" # Expose Prometheus via LoadBalancer
  }
}
