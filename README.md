Here’s a professional and detailed `README.md` for your project:

---

# Terraform + Ansible AWS Deployment Project

This project demonstrates a **production-ready infrastructure deployment** on AWS using **Terraform** and **Ansible**. It follows a **modular, reusable, and dynamic approach** to provision and configure resources, showcasing best practices for CI/CD, infrastructure as code (IaC), and configuration management.

---

## Features

- **Terraform**: Infrastructure as Code (IaC) to provision AWS resources.
- **Ansible**: Configuration management to set up and configure EC2 instances.
- **Modular Design**: Reusable Terraform modules for VPC, EC2, security groups, and more.
- **Dynamic Configuration**: Supports multiple environments (e.g., prod, dev, test) and regions.
- **CI/CD Integration**: GitHub Actions for automated validation, planning, and deployment.

---

## Prerequisites

Before using this project, ensure you have the following:

1. **AWS Account**: With IAM credentials (access key and secret key).
2. **Terraform**: Installed locally (if testing locally).
3. **Ansible**: Installed locally (if testing locally).
4. **GitHub Repository**: To host the project and enable CI/CD.

---

## Project Structure

```
.
├── .github/workflows/              # GitHub Actions CI/CD workflows
│   └── terraform.yml               # Terraform CI/CD pipeline
├── modules/                        # Reusable Terraform modules
│   ├── vpc/                        # VPC module
│   ├── ec2/                        # EC2 module
│   ├── sg/                         # Security group module
│   └── data_az/                    # Availability zones data module
├── main.tf                         # Root Terraform configuration
├── variables.tf                    # Root variables
├── outputs.tf                      # Root outputs
├── ansible/                        # Ansible playbooks and roles
│   ├── playbook.yml                # Main playbook for EC2 configuration
│   └── roles/                      # Ansible roles (if any)
├── README.md                       # Project documentation
└── .gitignore                      # Git ignore file
```

---

## How It Works

### 1. **Terraform**
- **Modules**: Reusable components for VPC, EC2, security groups, etc.
- **Dynamic Configuration**: Uses variables for regions, CIDR blocks, and environment-specific settings.
- **Outputs**: Exports resource IDs, IPs, and other details for use in Ansible.

### 2. **Ansible**
- **Playbooks**: Configures EC2 instances after Terraform provisioning.
- **Dynamic Inventory**: Uses Terraform outputs to dynamically target EC2 instances.

### 3. **CI/CD**
- **GitHub Actions**: Automates Terraform validation, planning, and deployment.
- **Pipeline Stages**:
  - `validate`: Checks Terraform configuration.
  - `plan`: Generates an execution plan.
  - `apply`: Provisions infrastructure (only on `main` branch).

---

## Getting Started

### 1. **Clone the Repository**
```bash
git clone https://github.com/umarbkh/terraform-cicd.git
cd terraform-cicd
```

### 2. **Set Up AWS Credentials**
Add your AWS credentials as secrets in GitHub:
1. Go to your repository > Settings > Secrets and variables > Actions.
2. Add these secrets:
   - `AWS_ACCESS_KEY_ID`: Your AWS access key.
   - `AWS_SECRET_ACCESS_KEY`: Your AWS secret key.

### 3. **Run the Pipeline**
Push to the `main` branch to trigger the CI/CD pipeline:
```bash
git add .
git commit -m "Initial commit"
git push origin main
```

### 4. **Monitor the Pipeline**
- Go to GitHub > Actions to view the pipeline status.
- Check the logs for details.

---

## Customization

### 1. **Environments**
To deploy to different environments (e.g., prod, dev, test):
- Update the `variables.tf` file with environment-specific values.
- Use Terraform workspaces or separate root configurations.

### 2. **Regions**
To deploy to different regions:
- Update the `region` variable in `variables.tf`.
- Ensure the AMI IDs and availability zones are valid for the selected region.

### 3. **Ansible Playbooks**
Modify the `ansible/playbook.yml` file to customize EC2 configuration.

---

## Example Outputs

After a successful deployment, Terraform will output:
- **Instance ID**: ID of the provisioned EC2 instance.
- **Public IP**: Public IP address of the EC2 instance.

Example:
```hcl
instance_id = "i-0abcd1234efgh5678"
public_ip   = "54.123.45.67"
```

---

## Contributing

Contributions are welcome! Please follow these steps:
1. Fork the repository.
2. Create a new branch (`git checkout -b feature/your-feature`).
3. Commit your changes (`git commit -m 'Add some feature'`).
4. Push to the branch (`git push origin feature/your-feature`).
5. Open a pull request.

---

## License

This project is licensed under the Apache License. 

---

## Acknowledgments

- **Terraform**: For enabling infrastructure as code.
- **Ansible**: For simplifying configuration management.
- **GitHub Actions**: For providing a robust CI/CD platform.

---
