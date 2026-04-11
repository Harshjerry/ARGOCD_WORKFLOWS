# we need artifact storage to use artifacts in our  workflows


you can use AWS S3 or  minIO

# say u use minio 
 setup helm repo of minio and install the chart
 open dashboard of minio  by  port forward or using nodeport  
  in that  dashboard create bucket  that ur ARGO WORLFLOWS WILL USE 
 1. for argo workflow to  use this bucket
  $ kubectl create secret generic -n argo name --from-literal=access-key='value' --from-literal=secret-key=''
 2.  you wil et value of secret key and access key b check   secrets of  minio- by default


 3.  METHOD 1: in our  CONFIG MAP OF ARGO WORKFLOW CONTROLLER 
  ADD  THIS DATA BLOCKM IN THAT   config map UWING SECRET CERATEDD ABOVE


   METHOD 2 : CREATE NEW CONFIG MAP FOR ARTIFACT
   
