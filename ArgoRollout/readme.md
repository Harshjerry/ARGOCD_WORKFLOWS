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
 
