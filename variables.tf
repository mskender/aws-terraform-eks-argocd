variable install_argocd {
    type = bool
    default = false
    description = "Whether to install ArgoCD CI/CD solution for K8S"
}

variable hostname {
    type=string
    default = "argocd.example.com"
    description = "ArgoCD FQDN to set on Ingress as a hostname"
}

variable extra_hostnames {
    type=list(string)
    default = []
    description = "Extra ArgoCD hostname to set on Ingress."
}
variable chart_version {
    type = string
    default = ""
    description = "Version of ArgoCD to install"
}

variable create_namespace {
    type = bool
    default = true
    description = "Whether to create namespace if it doesn't exist."
}

variable namespace {
    default = "argocd"
    description = "What namespace to create controller in."
    type = string
}

variable controller_replica_count {
    type = number
    description = "How many ArgoCD controller replicas to spin up."
    default = 1
}


variable server_replica_count {
    type = number
    description = "How many ArgoCD server replicas to spin up."
    default = 1
}

variable repo_replica_count {
    type = number
    description = "How many ArgoCD repository replicas to spin up."
    default = 1
}

variable server_autoscaling_configuration {
    type = object({
        enabled = string
        minReplicas = string
        maxReplicas = string
        targetCPUUtilizationPercentage = string
        targetMemoryUtilizationPercentage =  string
    })
    default = {
        enabled = "false"
        minReplicas = "1"
        maxReplicas = "11"
        targetCPUUtilizationPercentage = "50"
        targetMemoryUtilizationPercentage =  "50"
    }
}

variable enable_ingress {
    default = true
    description = "Create Ingress for ArgoCD"
    type = bool
}
variable enable_grpc {
    default = true
    description = "Create gRPC Ingress for ArgoCD"
    type = bool
}

variable use_tls {
    default = true
    description = "Whether to use TLS on Ingress for ArgoCD"
    type = bool
}
variable use_selfsigned_cert {
    default = false
    description = "Whether to use self-signed cert on Ingress for ArgoCD"
    type = bool
}

variable disable_ssl_redirect {
    default = false
    description = "Whether to disable http -> https redirect."
    type = bool
}

variable ingress_class {
    type = string
    default = "nginx"
    description = "Ingress class label. Useful for targeting a specific ingress controller."
}

variable cluster_issuer {
    type = string
    description = "Name for default ACME cluster issuer."
    default = "le-prod"
}

variable log_level {
    type = string
    default = "info"
    description = "Server log level."
}

variable show_admin_password {
    type = bool
    default = false
    description = "Whether to show default admin password in output. Even if set, you need to use terraform output -json because value is sensitive."
}