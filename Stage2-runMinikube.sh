#!/bin/bash

# Stage 2: Run minikube

minikube start --profile=tap-cluster --cpus='8' --memory='12g' --kubernetes-version='1.22.6' --driver=hyperkit
minikube -p tap-cluster ip

# minikube -p tap-cluster tunnel