#!/bin/bash

# deploy the Pi app:
kubectl apply -f pi/web/
# check the ReplicaSet:
kubectl get rs -l app=pi-web
# scale up to more replicas:
kubectl apply -f pi/web/update/web-replicas-3.yaml
# check the RS:
kubectl get rs -l app=pi-web
# deploy a changed Pod spec with enhanced logging:
kubectl apply -f pi/web/update/web-logging-level.yaml
# check ReplicaSets again:
kubectl get rs -l app=pi-web


# we need to scale the Pi app fast:
kubectl scale --replicas=4 deploy/pi-web
# check which ReplicaSet makes the change:
kubectl get rs -l app=pi-web
# now we can revert back to the original logging level:
kubectl apply -f pi/web/update/web-replicas-3.yaml
# but that will undo the scale we set manually:
kubectl get rs -l app=pi-web
# check the Pods:
kubectl get pods -l app=pi-web

# list ReplicaSets with labels:
kubectl get rs -l app=pi-web --show-labels
# list Pods with labels:
kubectl get po -l app=pi-web --show-labels


# deploy the proxy resources:
kubectl apply -f pi/proxy/

# get the URL to the proxied app:
kubectl get svc whoami-web -o jsonpath='http://{.status.loadBalancer.ingress[0].*}:8080/?dp=10000'
# browse to the app, and try a few different values for 'dp' in the URL


# deploy the updated spec:
kubectl apply -f pi/proxy/update/nginx-hostPath.yaml
# check the Pods—the new spec adds a third replica:
kubectl get po -l app=pi-proxy
# browse back to the Pi app, and refresh it a few times
# check the proxy logs:
kubectl logs -l app=pi-proxy --tail 1





# remove all the controllers and Services:
kubectl delete all -l kiamol=ch06