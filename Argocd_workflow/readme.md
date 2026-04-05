Workflows is used in automation and CI-CD .
Install argoworflow using helm chart and use values.yaml specified  to override  authentication
by default argo-workflow have insufficient privileges 
therefore  give it privileges using role binding 

## {$ kubectl create rolebinding default-admin --clusterrole=admin --serviceaccount=argo:default -n argo}
 
 here argo  is namespace where we installed our chart 


Workflow is defined in  
# workflow.spec:

 - list of template
 - an entrypoint

types of templates
 6 different templates
 - template definitions:
   - container
   - script
   - resource
   - suspend
 - template invocators //used to invoke executions
   - steps
   - dag (define ur tasks as  graph of dependency)

 Q what is entrypoint?
 # entrypoint: steps-template 
 # it is like a main function, it is the first template to be executed when the workflow starts



after defining your workflow  in templates.yaml
 $ argo submit  templates.yml -n argo