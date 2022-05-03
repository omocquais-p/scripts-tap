#!/bin/bash

# Stage 2: Run minikube

echo "minikube start --profile=tap-cluster --cpus='8' --memory='12g' --kubernetes-version='1.23.0' --driver=hyperkit"
minikube start --profile=tap-cluster --cpus='8' --memory='12g' --kubernetes-version='1.23.0' --driver=hyperkit

echo "minikube -p tap-cluster ip"
minikube -p tap-cluster ip

# minikube -p tap-cluster tunnel