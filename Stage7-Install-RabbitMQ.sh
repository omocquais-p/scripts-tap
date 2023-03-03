#!/bin/bash

echo "kapp -y deploy --app rmq-operator --file https://github.com/rabbitmq/cluster-operator/releases/latest/download/cluster-operator.yml"
kapp -y deploy --app rmq-operator --file https://github.com/rabbitmq/cluster-operator/releases/latest/download/cluster-operator.yml

echo "kubectl apply -f rabbitmq/rmq-reader-for-binding-and-claims.yaml"
kubectl apply -f rabbitmq/rmq-reader-for-binding-and-claims.yaml

echo "kubectl apply -f rabbitmq/rmq-class.yaml"
kubectl apply -f rabbitmq/rmq-class.yaml

echo "kubectl create namespace service-instances"
kubectl create namespace service-instances

echo "kubectl apply -f rabbitmq/rmq-1-service-instance.yaml"
kubectl apply -f rabbitmq/rmq-1-service-instance.yaml

echo "kubectl apply -f rabbitmq/rmq-claim-policy.yaml"
kubectl apply -f rabbitmq/rmq-claim-policy.yaml

echo "tanzu service class list"
tanzu service class list