S3 Terraform Module
Overview
This folder contains a reusable Terraform module to provision Amazon S3 buckets as part of the infrastructure for my dataset generator app. S3 is used to securely store and serve generated datasets, static frontend files, and any additional resources created by the app.

Why S3?
Amazon S3 is a scalable object storage service ideal for:

Storing large generated datasets and making them available for secure download

Hosting static frontend assets (HTML, CSS, JS) for a web app interface

Enabling data sharing between serverless components (like AWS Lambda functions)

In this project, I use S3 for both:

Storing datasets generated on-demand by Lambda

Serving the app’s HTML frontend to users

Why Terraform?
Terraform allows me to define cloud infrastructure as code, making deployments:

Consistent: The same config can be reused and versioned across environments.

Automated: Buckets, policies, and settings are provisioned and managed automatically.

Auditable: All changes are tracked, making cloud resource management safer.

Module Structure
bash
Copy
Edit
s3/
├── main.tf         # S3 bucket resource definitions
├── variables.tf    # Configurable parameters (e.g. bucket names, tags)
├── outputs.tf      # Output values for integration with other modules
├── README.md       # This documentation file
How It Works
Bucket Creation: The module provisions one or more S3 buckets as defined in variables.tf.

Example buckets: dataset-generator-files, dataset-generator-html-app

Configuration: You can specify settings like bucket name, versioning, encryption, and tags via module variables.

Outputs: Bucket ARNs and names are output for use in other Terraform modules (e.g., Lambda, API Gateway).

How to Use
Set module variables:
Customize bucket names, tags, and options in variables.tf or when you call the module in your root Terraform config.

Integrate with your main Terraform workflow:
Reference the S3 module from your main main.tf:

hcl
Copy
Edit
module "s3" {
  source = "./s3"
  bucket_name = "dataset-generator-files"
  # ...other variables
}
Deploy:
Run terraform init, terraform plan, and terraform apply to provision resources in your AWS account.

Security & Best Practices
No secrets or sensitive info are included in this repo.

Bucket policies and permissions should be customized for your use case.

Always use IAM roles and policies with least privilege.

Notes
This module is designed for educational and portfolio/demo use.
