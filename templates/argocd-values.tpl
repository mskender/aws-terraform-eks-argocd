controller:
    replicas: ${controller_replica_count}
server:
    replicas: ${server_replica_count}

%{ if !use_selfsigned_cert && use_tls}
    certificate:
        enabled: true
        domain: ${hostname}
        issuer:
            kind: ClusterIssuer
            name: ${cluster_issuer}
        additionalHosts: [ 
            ${extra_hostnames}
        ]
        secretName: argocd-secret
%{ endif }
    ingress:
        enabled: ${enable_ingress}
        selfSigned: ${use_selfsigned_cert}
        hosts: [ 
            ${hostname}
            ${extra_hostnames}
        ]
        ingressClassName: "nginx"
        annotations:
            cert-manager.io/cluster-issuer: "${cluster_issuer}"
            nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
            nginx.ingress.kubernetes.io/ssl-passthrough: "true"
            nginx.ingress.kubernetes.io/backend-protocol: "HTTPS"
        tls:
            - hosts:
                - ${hostname}
              secretName: argocd-secret #this is shared TLS and MUST be set to this value.
    ingressGrpc:
        enabled: false
repoServer:
    replicas: ${repo_replica_count}