#!/bin/bash

echo "delete pods..."
oc delete pods --all

echo "delete services..."
oc delete services spring-boot-admin
oc delete services eureka-server
oc delete services customer-core
oc delete services customer-management-backend
oc delete services customer-management-frontend

echo "delete deploymentconfigs..."
oc delete deploymentconfigs --all

echo "delete imagestreams..."
oc delete imagestreams --all

echo "delete buildconfig..."
oc delete buildconfig --all
