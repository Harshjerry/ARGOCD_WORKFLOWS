Why argorollout 
- Native kubernetes deployment object vs argo-rollouts
- limitation of deployment oject basic rolling updates is available , basic Health checks
     1. Only basic rolling update
     You can control:
     maxUnavailable
     maxSurge
     But no traffic control
     You cannot say: send 10% traffic to new version
     It’s instance-based rollout, not traffic-based rollout
     2. Recreate deployment strategy (delete  orev  before new)
     2. No integration with metrics/tools
        Cannot:
        Check Prometheus metrics
        Abort rollout automatically

- Argo-rollout have many features 
   . blue green , canary, automated rollback , automated promotion, service mesh integration

- use cases of  argorollout 
  - blue Green deployment : active and passive svc 
  - Canary Deployment : start giving small  traffic to new version and eventually all production traffic 
    
- Components of Argo-rollouts:
  - Controller 
  - rollout resource
  - ingress
  - Analysis template ( connect to your metric provider  and  decide deployment  future  on basis of metrics and threshold)
  - Metrics Providers 
 

PS C:\Users\hp\Desktop\argocd_advanced\ArgoRollout>      kubectl argo rollouts dashboard

time="2026-03-31T19:50:50+05:30" level=info msg="Argo Rollouts Dashboard is now available at http://localhost:3100/rollouts"



//if auto roloit is  not enabled u ave to do it manuall to make ur active servie  point to previre  or new version of ur  app

kubectl argo rollouts promote blue-green-deployment -n blue-green



# to  abort rollout  
kubectl argo rollout abort blue-green-deployment -n blue-green



#   strategy:
    blueGreen: 
      activeService: rollout-bluegreen-active
      previewService: rollout-bluegreen-preview
      autoPromotionEnabled: false
      # abortScaleDownDelaySeconds: 10
      # autoPromotionEnabled: false
      # scaleDownDelaySeconds: 60
      # previewReplicaCount: 2  #used to set number of replica fro preview service  , usuaully done  to test wiht less replicase, after promotion of rollout   replicas  wil be same a deifned in deloyment 
      # autoPromotionSeconds: 20