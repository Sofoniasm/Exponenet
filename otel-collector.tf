resource "helm_release" "otel_collector" {
  name             = "otel-collector"
  repository       = "https://open-telemetry.github.io/opentelemetry-helm-charts"
  chart            = "opentelemetry-collector"
  namespace        = "observability"
  create_namespace = true

  set {
    name  = "mode"
    value = "deployment"
  }

  set {
    name  = "image.repository"
    value = "otel/opentelemetry-collector-contrib"
  }

  values = [
    <<-EOT
    config:
      receivers:
        otlp:
          protocols:
            grpc: {}
            http: {}

      processors:
        batch: {}

      exporters:
        logging: {}
        jaeger:
          endpoint: "jaeger-collector.observability.svc.cluster.local:14250"

      service:
        pipelines:
          traces:
            receivers: [otlp]
            processors: [batch]
            exporters: [jaeger, logging]
    EOT
  ]
}
