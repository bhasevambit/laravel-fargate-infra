#!/bin/zsh

# --- RDS DB Instance Deactivation ---
cd ./envs/prod/db/foobar
terraform apply -var="enable_rds=false" -auto-approve

sleep 2
cd ../../../..

# --- ElastiCache Deactivation ---
cd ./envs/prod/cache/foobar
terraform apply -var="enable_cache=false" -auto-approve

sleep 2
cd ../../../..

# --- Route53 Deactivation ---
cd ./envs/prod/routing/foobar_internal
terraform apply -var="enable_rds=false" -var="enable_cache=false" -auto-approve

sleep 2
cd ../../../..

# --- NAT Gateway Deactivation ---
cd ./envs/prod/network/main
terraform apply -var="enable_nat_gateway=false" -auto-approve

sleep 2
cd ../../../..

# --- ALB Deactivation ---
cd ./envs/prod/routing/mbit-cloud-system-test-for-self-studying_com
terraform apply -var="enable_alb=false" -auto-approve

sleep 2
cd ../../../..

# --- ECS Deactivation ---
cd ./envs/prod/app/foobar
./ECS_change_desiredCount_to_Zero.sh > /dev/null 

sleep 2
cd ../../../..
