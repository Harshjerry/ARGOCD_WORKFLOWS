# Helm application
resource "argocd_application" "helm" {
  metadata {
    name      = "helm-app"
    namespace = "argocd"
    labels = {
      test = "true"
    }
  }

  spec {
    destination {
      server    = "https://kubernetes.default.svc"
      namespace = "default"
    }
    source {
      repo_url        = "https://some.chart.repo.io"
      path    = "my-chart"
      target_revision = "main"
      helm {
        value_files = ["custom_values.yml"]
      }
    }
  }
}