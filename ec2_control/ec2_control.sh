#!/bin/bash

# Function to check if AWS CLI is configured
check_aws_configuration() {
  if ! aws sts get-caller-identity &>/dev/null; then
    echo "Error: AWS CLI is not configured. Please run 'aws configure' to set it up."
    exit 1
  fi
}

# Function to require the user's password
require_password() {
  echo -n "Enter your password: "
  read -s password
  echo

  if ! echo "$password" | sudo -S echo "Password verified" &>/dev/null; then
    echo "Error: Incorrect password. Exiting."
    exit 1
  fi
}

# Function to handle EC2 instance actions
ec2_action() {
  local action=$1
  local instance_id=$2

  echo "Performing $action on instance $instance_id..."
  aws ec2 "$action"-instances --instance-ids "$instance_id" &>/dev/null

  if [ $? -eq 0 ]; then
    echo "Instance $action successfully."
  else
    echo "Error: Failed to $action instance $instance_id."
  fi
}

# Function to list all EC2 instances
list_instances() {
  echo "Fetching the list of EC2 instances..."
  aws ec2 describe-instances --query "Reservations[*].Instances[*].[InstanceId,State.Name,InstanceType,PublicIpAddress]" --output table
}

# Main script logic
if [ $# -lt 1 ]; then
  echo "Usage: $0 <action> [<instance_id>]"
  echo "Actions: start, stop, reboot, terminate, list"
  exit 1
fi

action=$1
instance_id=$2

require_password
check_aws_configuration

case $action in
  start|stop|reboot|terminate)
    if [ -z "$instance_id" ]; then
      echo "Error: Instance ID is required for action $action."
      exit 1
    fi
    ec2_action "$action" "$instance_id"
    ;;
  list)
    list_instances
    ;;
  *)
    echo "Invalid action: $action. Valid actions are: start, stop, reboot, terminate, list."
    exit 1
    ;;
esac
