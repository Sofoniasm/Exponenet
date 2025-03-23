resource "helm_release" "jaeger" {
  name             = "jaeger"
  repository       = "https://jaegertracing.github.io/helm-charts"
  chart            = "jaeger"
  namespace        = "observability"
  create_namespace = true

  set {
    name  = "provisionDataStore.cassandra"
    value = "false"
  }

  set {
    name  = "storage.type"
    value = "memory"
  }

  set {
    name  = "query.service.type"
    value = "LoadBalancer"
  }
}
