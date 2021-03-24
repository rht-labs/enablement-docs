#/bin/bash
##
# Deploy slides in OCP
##

# Params
REGISTRY_SERVER=quay.io
REGISTRY_PROJECT=acidonpe
REGISTRY=$REGISTRY_SERVER/$REGISTRY_PROJECT
OCP_NS=do500
LAB_NAME=slides
VERSION=1.1.13

## Build and push image
podman build . -t $REGISTRY/$LAB_NAME:$VERSION 
podman login $REGISTRY_SERVER
podman push $REGISTRY/$LAB_NAME:$VERSION
podman tag $REGISTRY/$LAB_NAME:$VERSION $REGISTRY/$LAB_NAME:latest
podman push $REGISTRY/$LAB_NAME:latest

## Deploy in OCP
oc new-project $OCP_NS
oc new-app  --name=$LAB_NAME \
  --docker-image=$REGISTRY/$LAB_NAME:$VERSION \
  -n $OCP_NS -o yaml | oc apply -f - -n $OCP_NS

oc expose svc/$LAB_NAME -n $OCP_NS 

echo ""

oc get route $LAB_NAME -n $OCP_NS