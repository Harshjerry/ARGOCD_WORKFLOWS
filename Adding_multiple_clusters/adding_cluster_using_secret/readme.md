1. first create serviceaccount in new cluster
2. give  clusterrole of cluster-admin to  this service account in new cluster  using clusterreoleBinding
3. kubectl create token sa-name  //create token for service account
4. use this token in  secret manifest and   apply that secret in argocd env 