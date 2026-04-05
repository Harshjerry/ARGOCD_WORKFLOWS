Canary:
- RollingUpdate:
    maxSurge:
    maxUnavailable:
- SetWeight
- traffic-management/traffic-routing


1. rolling update   maxSurge is what extra pod we will vae other than  our original replicas 
                     maxUnavailable is how many   old replicase  we can let go 

                     e:g  5 replicas  old verison inititally
                     maxSurge =2 and maxUnavailable =2
  At any time  total replicas=(5+2surge)=7;                   then   initially 
                            (5-2)  3 replicas of OLD VERSION
                            AND (7-3)= 4 replicae of NEW VERSION

2. SetWeight   we  go in steps 
             percentage is  given  examle 5 relicas
              if setweight 20   ,  new version replicas= 20% of 5   is 1 replica
              if setwright 30   , new version  replicas=30% of 5  is 1.5 === 2 replicase
               and  similary  for  old verison    willbe  70% of 5 ==== 4 replicase

3.              
 in  traffic management routing 
    we have two services  canary-service  and  stable service
    initially   our app points to stable service