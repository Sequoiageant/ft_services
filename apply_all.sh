#!/bin/bash

# List of the services, comment the ones you don't want to run
services=('nginx' 'influxdb' 'telegraf'	'grafana' 'ftps' \
	'wordpress' 'mysql' 'phpmyadmin' 'ingress' 'volumes')

# Images source directory
srcs='./srcs'

# User
if [ -z "${USER}" ]
then
  user="admin"
else
  user=$USER
fi

# Passwords wherever it is needed
password='pw'

# Collect minikube ip
minikube_ip=`minikube ip`

mv $srcs/config_map.yaml.bak $srcs/config_map.yaml
sed -i.bak "s/{{USER}}/$user/g; \
			s/{{MINIKUBE_IP}}/$minikube_ip/g; \
			s/{{PW}}/`echo $password | base64`/g" $srcs/config_map.yaml

kubectl apply -f ./srcs/config_map.yaml

# kubectl apply -f ./srcs/volumes.yaml

# Build images and deploy all services
for service in "${services[@]}"
do
	# Build Docker images
	# docker build -t ${service}_img $srcs/$service
	# Deployment
	kubectl apply -f $srcs/$service.yaml
done