resource "helm_release" "otel_demo" {
  name             = "otel-demo"
  repository       = "https://open-telemetry.github.io/opentelemetry-helm-charts"
  chart            = "opentelemetry-demo"
  namespace        = "observability"
  create_namespace = true

  values = [
    <<-EOT
    # Add your configuration here
    # Example:
    # service:
    #   type: ClusterIP
    #   port: 8080
    EOT
  ]
}
