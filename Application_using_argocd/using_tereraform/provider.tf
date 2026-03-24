terraform {
          required_providers {
          argocd = { 
            source = "argoproj-labs/argocd"
             version ="7.15.1" 
             } 
           } 
       } 


# Exposed ArgoCD API - authenticated using `username`/`password`
provider "argocd" {
  server_addr = "localhost:32073"  // argocd server  value  
  username    = var.username
  password    = var.password
  insecure    = true
}

