locals {

admin_password = var.show_admin_password ? "${data.kubernetes_secret.admin_pass.data["password"]}" : "Set var.show_admin_password to true to see the admin pass!"
    
}

output default_admin_password {
    value = local.admin_password
    
}