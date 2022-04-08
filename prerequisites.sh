#!/bin/bash

echo "minikube delete -p tap-cluster"
minikube delete -p tap-cluster

echo
echo "minikube start --profile=tap-cluster --memory=8192 -    -cpus=8 --disk-size=80g --kubernetes-version=v1.22.0      --driver=hyperkit"
#minikube start --profile=tap-cluster --memory=8192 --cpus=8 --disk-size=80g --kubernetes-version=v1.22.0  --driver=hyperkit
minikube start --profile=tap-cluster --cpus='8' --memory='12g' --kubernetes-version='1.22.6' --driver=hyperkit

echo
source ./environment.sh

echo
echo "kubectl config use-context tap-cluster"
kubectl config use-context tap-cluster
