# EKS Simple ArgoCD module 

WARNING: Still in progress, so bound to change often! Do not use this in production (yet)!


## Description

This is a simple module for creating a basic/root ArgoCD module from commmunity Helm chart.

## Examples


```
module "argocd" {
    install_argocd = true
    source = "github.com/mskender/aws-terraform-eks-argocd"

    hostname = "argocd.example.com"
    enable_ingress = true
    enable_grpc = true
    use_tls = true
    ingress_class = "nginx"
    cluster_issuer = "letsencrypt-prod"
    show_admin_password = true

    providers = {
        helm = helm.eks
        kubernetes = kubernetes.eks
    }
}

# Will fetch ArgoCD default admin password.
# value marked sensitive, so run terraform output -json to get it.
output argocd_admin_pass {
    value = "Default admin pass is: ${module.argocd.default_admin_password}"
    sensitive = true
}
```



