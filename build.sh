#!/bin/bash

echo "----- Creating eureka server -----"
oc new-app https://github.com/Tavernoshca/LakesideMutual \
  --context-dir=eureka-server \
  --strategy=docker \
  --name=eureka-server \
  -l app=lakeside-mutual

echo "----- Creating spring boot admin -----"
oc new-app https://github.com/Tavernoshca/LakesideMutual \
  --context-dir=spring-boot-admin \
  --strategy=docker \
  --name=spring-boot-admin \
  -l app=lakeside-mutual \
  -e EUREKA_CLIENT_SERVICEURL_DEFAULTZONE=http://eureka-server:8761/eureka
  -e SPRING_PROFILES_ACTIVE=eureka

echo "----- Creating customer core -----"
oc new-app https://github.com/Tavernoshca/LakesideMutual \
  --context-dir=customer-core \
  --strategy=docker \
  --name=customer-core \
  -l app=lakeside-mutual \
  -e EUREKA_CLIENT_SERVICEURL_DEFAULTZONE=http://eureka-server:8761/eureka
  -e SPRING_PROFILES_ACTIVE=eureka

echo "----- Creating customer management backend -----"
oc new-app https://github.com/Tavernoshca/LakesideMutual \
  --context-dir=customer-management-backend \
  --strategy=docker \
  --name=customer-management-backend \
  -l app=lakeside-mutual \
  -e EUREKA_CLIENT_SERVICEURL_DEFAULTZONE=http://eureka-server:8761/eureka
  -e SPRING_PROFILES_ACTIVE=eureka

echo "----- Creating customer management frontend -----" 
oc new-app https://github.com/Tavernoshca/LakesideMutual \
  --context-dir=customer-management-frontend \
  --strategy=docker \
  --name=customer-management-frontend \
  -l app=lakeside-mutual \
  -e REACT_APP_CUSTOMER_MANAGEMENT_BACKEND=http://customer-management-backend:8100
