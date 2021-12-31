locals {
    chart_values = templatefile("${path.module}/templates/argocd-values.tpl",
    {
        controller_replica_count = var.controller_replica_count
        server_replica_count = var.server_replica_count
        repo_replica_count = var.repo_replica_count
        server_autoscaling_conf = yamlencode(var.server_autoscaling_configuration)
        hostname = var.hostname
        enable_ingress = var.enable_ingress
        use_selfsigned_cert = var.use_selfsigned_cert
        extra_hostnames = join(",",var.extra_hostnames)
        ingress_class = var.ingress_class
        cluster_issuer = var.cluster_issuer
        disable_ssl_redirect = var.disable_ssl_redirect
        log_level = var.log_level
        use_tls = var.use_tls
        enable_grpc = var.enable_grpc
    })
}

resource "helm_release" "argocd" {
#https://github.com/argoproj/argo-helm/
count = var.install_argocd ? 1 : 0
name = "argocd"
repository = "https://argoproj.github.io/argo-helm"
chart = "argo-cd"
version = var.chart_version
namespace = var.namespace
create_namespace = var.create_namespace
cleanup_on_fail = true

values = [ 
    local.chart_values
    ]

}

