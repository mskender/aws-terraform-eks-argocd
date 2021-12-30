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

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=3.38.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.argocd](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_secret.admin_pass](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/secret) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | Version of ArgoCD to install | `string` | `""` | no |
| <a name="input_cluster_issuer"></a> [cluster\_issuer](#input\_cluster\_issuer) | Name for default ACME cluster issuer. | `string` | `"le-prod"` | no |
| <a name="input_controller_replica_count"></a> [controller\_replica\_count](#input\_controller\_replica\_count) | How many ArgoCD controller replicas to spin up. | `number` | `1` | no |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Whether to create namespace if it doesn't exist. | `bool` | `true` | no |
| <a name="input_disable_ssl_redirect"></a> [disable\_ssl\_redirect](#input\_disable\_ssl\_redirect) | Whether to disable http -> https redirect. | `bool` | `false` | no |
| <a name="input_enable_grpc"></a> [enable\_grpc](#input\_enable\_grpc) | Create gRPC Ingress for ArgoCD | `bool` | `true` | no |
| <a name="input_enable_ingress"></a> [enable\_ingress](#input\_enable\_ingress) | Create Ingress for ArgoCD | `bool` | `true` | no |
| <a name="input_extra_hostnames"></a> [extra\_hostnames](#input\_extra\_hostnames) | Extra ArgoCD hostname to set on Ingress. | `list(string)` | `[]` | no |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | ArgoCD FQDN to set on Ingress as a hostname | `string` | `"argocd.example.com"` | no |
| <a name="input_ingress_class"></a> [ingress\_class](#input\_ingress\_class) | Ingress class label. Useful for targeting a specific ingress controller. | `string` | `"nginx"` | no |
| <a name="input_install_argocd"></a> [install\_argocd](#input\_install\_argocd) | Whether to install ArgoCD CI/CD solution for K8S | `bool` | `false` | no |
| <a name="input_log_level"></a> [log\_level](#input\_log\_level) | Server log level. | `string` | `"info"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | What namespace to create controller in. | `string` | `"argocd"` | no |
| <a name="input_repo_replica_count"></a> [repo\_replica\_count](#input\_repo\_replica\_count) | How many ArgoCD repository replicas to spin up. | `number` | `1` | no |
| <a name="input_server_autoscaling_configuration"></a> [server\_autoscaling\_configuration](#input\_server\_autoscaling\_configuration) | n/a | <pre>object({<br>        enabled = string<br>        minReplicas = string<br>        maxReplicas = string<br>        targetCPUUtilizationPercentage = string<br>        targetMemoryUtilizationPercentage =  string<br>    })</pre> | <pre>{<br>  "enabled": "false",<br>  "maxReplicas": "11",<br>  "minReplicas": "1",<br>  "targetCPUUtilizationPercentage": "50",<br>  "targetMemoryUtilizationPercentage": "50"<br>}</pre> | no |
| <a name="input_server_replica_count"></a> [server\_replica\_count](#input\_server\_replica\_count) | How many ArgoCD server replicas to spin up. | `number` | `1` | no |
| <a name="input_show_admin_password"></a> [show\_admin\_password](#input\_show\_admin\_password) | Whether to show default admin password in output. Even if set, you need to use terraform output -json because value is sensitive. | `bool` | `false` | no |
| <a name="input_use_selfsigned_cert"></a> [use\_selfsigned\_cert](#input\_use\_selfsigned\_cert) | Whether to use self-signed cert on Ingress for ArgoCD | `bool` | `false` | no |
| <a name="input_use_tls"></a> [use\_tls](#input\_use\_tls) | Whether to use TLS on Ingress for ArgoCD | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_default_admin_password"></a> [default\_admin\_password](#output\_default\_admin\_password) | n/a |
