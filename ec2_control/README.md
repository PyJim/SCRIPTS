# EC2 Instance Management Script

This is a Bash script to manage AWS EC2 instances using the AWS CLI. The script allows you to perform actions such as starting, stopping, rebooting, or terminating an EC2 instance by providing the desired action and instance ID as arguments.

---

## Features
- **AWS CLI Configuration Check**: Ensures the AWS CLI is configured before performing any operations.
- **Password Verification**: Prompts for your system password to ensure authorized use of the script.
- **EC2 Instance Actions**: Supports `start`, `stop`, `reboot`, `terminate`, and `list` actions for EC2 instances.
- **Error Handling**: Provides clear error messages in case of invalid inputs, incorrect configuration, or failed operations.

---

## Prerequisites
1. **AWS CLI Installed**: Ensure the AWS CLI is installed on your system. [Install AWS CLI](https://aws.amazon.com/cli/).
2. **AWS CLI Configured**: Run `aws configure` to set up your AWS credentials and default region.
3. **Sudo Privileges**: The script requires sudo access for password verification.

---

## Usage

### Syntax
```bash
./ec2_control.sh <action> <instance_id>
```

### Arguments
1. `<action>`: The desired action to perform on the EC2 instance. Valid options are:
   - `start`
   - `stop`
   - `reboot`
   - `terminate`
   - `list`
2. `<instance_id>`: The ID of the EC2 instance (e.g., `i-0abcdef1234567890`).

### Example
Start an EC2 instance:
```bash
./ec2_control.sh start i-0abcdef1234567890
```

Stop an EC2 instance:
```bash
./ec2_control.sh stop i-0abcdef1234567890
```

List all EC2 instances:
```bash
./ec2_control.sh list
```
---

## Script Workflow
1. **Password Prompt**: Prompts for your system password to verify sudo access.
2. **AWS CLI Check**: Confirms the AWS CLI is configured and authenticated.
3. **Action Execution**: Executes the specified action on the given EC2 instance.
4. **Feedback**: Displays success or error messages based on the outcome of the operation.

---

## Error Handling
- **Invalid Usage**: If incorrect arguments are provided, the script displays the usage instructions.
- **AWS CLI Not Configured**: If the AWS CLI is not configured, the script exits with an error message.
- **Action Failure**: If the AWS CLI command fails (e.g., due to invalid instance ID or insufficient permissions), the script reports the error.

---

## Notes
- Ensure you have the necessary permissions in your AWS account to perform actions on EC2 instances.
- Use caution when performing destructive actions such as `terminate`.

---

## License
This script is open source and free to use. Modify it as needed for your use case. Contributions and suggestions are welcome!