#!/usr/bin/env bash

# switch to the chapter's source:
cd ch08
# deploy the StatefulSet, Service, and a Secret for the Postgres
# password:
kubectl apply -f todo-list/db/
# check the StatefulSet:
kubectl get statefulset todo-db
# check the Pods:
kubectl get pods -l app=todo-db
# find the hostname of Pod 0:
kubectl exec pod/todo-db-0 -- hostname
# check the logs of Pod 1:
kubectl logs todo-db-1 --tail 1

# check the internal ID of Pod 0:
kubectl get pod todo-db-0 -o jsonpath='{.metadata.uid}'
# delete the Pod:
kubectl delete pod todo-db-0
# check Pods:
kubectl get pods -l app=todo-db
# check that the new Pod is a new Pod:
kubectl get pod todo-db-0 -o jsonpath='{.metadata.uid}'