# Terraform AWS Deployment Project

**Work in Progress**: This project is actively being developed, with new modules and features being added regularly. Stay tuned for updates!

---

## About Me

**Umar Bukhari**  
AWS Sysops, AWS CCP, Terraform Associate, CompTIA A+ Certified Professional.  
My past experience includes MEAN Stack, PHP, JavaScript, WordPress, and basic Python automation.  

- **LinkedIn**: [https://www.linkedin.com/in/umar-bukhari-96203284/](https://www.linkedin.com/in/umar-bukhari-96203284/)  
- **Credly**: [https://www.credly.com/users/umar-bukhari.f28cd07d](https://www.credly.com/users/umar-bukhari.f28cd07d)  

I am available for work, contracts, and job opportunities. Feel free to reach out via LinkedIn!

---

## Project Overview

This project demonstrates a **production-ready infrastructure deployment** on AWS using **Terraform**. It follows a **modular, reusable, and dynamic approach** to provision and configure resources, showcasing best practices for CI/CD and infrastructure as code (IaC). Focus on Free Tier resources mostly or as low cost as possible. 

---

## Features

- **Terraform**: Infrastructure as Code (IaC) to provision AWS resources.
- **Modular Design**: Reusable Terraform modules for VPC, EC2, security groups, and more.
- **Dynamic Configuration**: Supports multiple environments (e.g., prod, dev, test) and regions.
- **CI/CD Integration**: GitHub Actions for automated validation, planning, and deployment.

---

## Prerequisites

Before using this project, ensure you have the following:

1. **AWS Account**: With IAM credentials (access key and secret key).
2. **Terraform**: Installed locally (if testing locally).
3. **GitHub Repository**: To host the project and enable CI/CD.
4. **Create a terrform.tfvars file**: add and update these variables project_name = "my-project", ami_id = "ami-01816d07b1128cd2d", db_password = "add pass here" 

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
├── README.md                       # Project documentation
└── .gitignore                      # Git ignore file
```

---

## How It Works

### 1. **Terraform**
- **Modules**: Reusable components for VPC, EC2, security groups, etc.
- **Dynamic Configuration**: Uses variables for regions, CIDR blocks, and environment-specific settings.
- **Outputs**: Exports resource IDs, IPs, and other details.

### 2. **CI/CD**
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

This project is licensed under the **Apache License**.

---

## Acknowledgments

- **Terraform**: For enabling infrastructure as code.
- **GitHub Actions**: For providing a robust CI/CD platform.

--- 

**Note**: This project is a work in progress, and new modules are being added regularly. Check back often for updates!