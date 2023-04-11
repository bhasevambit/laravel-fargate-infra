#!/bin/zsh

# --- RDS DB Instance Activation ---
cd ./envs/prod/db/foobar
terraform apply -var="enable_rds=true" -auto-approve

sleep 2
cd ../../../..

# --- ElastiCache Activation ---
cd ./envs/prod/cache/foobar
terraform apply -var="enable_cache=true" -auto-approve

sleep 2
cd ../../../..

# --- Route53 Activation ---
cd ./envs/prod/routing/foobar_internal
terraform apply -var="enable_rds=true" -var="enable_cache=true" -auto-approve

sleep 2
cd ../../../..

# --- NAT Gateway Activation ---
cd ./envs/prod/network/main
terraform apply -var="enable_nat_gateway=true" -auto-approve

sleep 2
cd ../../../..

# --- ALB Activation ---
cd ./envs/prod/routing/mbit-cloud-system-test-for-self-studying_com
terraform apply -var="enable_alb=true" -auto-approve

sleep 2
cd ../../../..

# --- ECS Activation ---
cd ./envs/prod/app/foobar
./ECS_change_desiredCount_to_One.sh > /dev/null 

sleep 2
cd ../../../..

# --- RDS DB Master Password Change---
sleep 10

. ./secret_shell_variables.config
aws rds modify-db-instance --db-instance-identifier "example-prod-foobar" --master-user-password ${master_user_password}
