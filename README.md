# VCF Lab Application Template

This repository is a **ready‑to‑use Terraform application template** for deploying VMware Cloud Foundation (VCF) Automation / Aria Automation (VCFA) blueprints or machine resources via IaC.  It is designed to be cloned as part of project on-boarding in the [vm-apps-private-cloud](https://github.com/sentania-labs/vm-apps-private-cloud).  The cloning process as part of the on-boarding will populate a number of secrets used as required variables.  Other variables are defined as a part of the larger [sentania-labs](https://github.com/sentania-labs/) org.

It includes:

- A Terraform project that uses your environment variables and tfvars to deploy into Aria/VCFA
- A GitHub Actions pipeline that runs on commit
- A **decommission workflow** for safely destroying all deployed infrastructure prior to repository removal
  - This workflow is a manual step that must be completed prior to decomissioning the project in the [vm-apps-private-cloud](https://github.com/sentania-labs/vm-apps-private-cloud) repo.

---

## 🚀 What This Template Does

This template enables you to:

✔️ Provision Aria / VCFA infrastructure (blueprint deployments, machines)  
✔️ Keep configurations in version control and run fully automated CI/CD  
✔️ Destroy existing infrastructure cleanly via a dedicated decommission workflow  
✔️ Support safe tear‑down before repo deletion

---

## 📁 Directory Layout

```
├── .github/
│   ├── workflows/
│   │   ├── deployment.yml
│   │   └── decommission.yml
├── envs/
│   └── lab.tfvars
├── backend.tf
├── deployments.tf
├── LICENSE
├── machines.tf
├── output-template.tpl
├── provider.tf
├── README.md
├── variables.tf
└── versionsoutputs.tf


```

---

## 🔧 Prerequisites

Before using this template:

1. **Aria / VCFA API credentials** (refresh token or equivalent)  
2. **GitHub Actions permissions** to run workflows and access Terraform state  
3. **Terraform 1.14+** installed locally or in your CI environment  
4. A configured **S3 backend** for Terraform state (see `backend.tf`)  

---

## 📌 Configure Your Terraform Variables

Copy the example vars file and edit it for your environment:

Edit `envs/lab.tfvars` with values like:

```hcl
deployments = {
  blueprintdeployment1 = {
    blueprint_name    = "Simple IAC Blueprint"
    deployment_name   = "Sample Deployment"
    description       = "Provisioned by TF"
    blueprint_version = "explicittags"
    inputs = {
      flavorSize   = "medium"
      diskCount    = 2
      diskSize     = 10
    }
  }
}
```

> The inputs block should match the blueprint parameters you intend to deploy.

---

## 📦 Run the Deployment

### Locally

```bash
terraform init -backend-config="key=vra/<project-slug>/terraform.tfstate"
terraform plan -var-file="envs/lab.tfvars"
terraform apply -var-file="envs/lab.tfvars"
```

### GitHub Actions (Auto‑Triggered)

On each commit to `main`, the **deployment.yml** workflow will:

- Initialize Terraform  
- Run `plan`  
- Run `apply`  
- Upload artifacts such as deployment output  

Ensure the following secrets or vars are configured in the repo or org:

| Name                        | Purpose |
|-----------------------------|---------|
| `VCFA_REFRESH_TOKEN`        | Aria / VCFA Auth |
| `AWS_ACCESS_KEY_ID`         | S3 Backend |
| `AWS_SECRET_ACCESS_KEY`     | S3 Backend |
| `VCFA_PROJECT_NAME`         | Project name |
| `VCFA_PROJECT_ID`           | Globally unique project ID |

---

## 🛠 Decommission Workflow

This template includes a **decommission workflow** designed to:

1. Destroy all deployed infrastructure  
2. Clean Terraform state  
3. Make the repository safe for deletion  

### Running the Workflow

Navigate to **Actions** → **Decommission Infrastructure** → **Run workflow**.

You'll be prompted to confirm destruction. After destroy completes:

- All VCFA deployments are removed  
- Terraform state is cleaned  
- Repo can be archived or deleted safely  

---

## 📌 State Backend Details

This template expects Terraform state in S3:

```hcl
terraform {
  backend "s3" {
    bucket         = "sentania-labs-terraform-state"
    key            = "vra/<project-key>/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
    use_lockfile   = true
  }
}
```

The `<project-key>` is generated dynamically in CI based on:

- Normalized project name  
- Shortened project ID  

---

## 📄 Outputs

There are no explicity outputs, however deployments.tf will generate a listing of deployed virtual machines and their IP address.  This demonstrates how to access VM information when using blueprints ensuring that information is known at plan time.

---

## 🛡️ Safety and Best Practices

- **Always run the decommission workflow before deleting the repo**  
- Never commit secrets — use GitHub Secrets  
- Maintain consistent naming conventions to avoid state mismatches  

---

## Questions?

Feel free to reach out to me at [scott.bowe@broadcom.com](mailto:scott.bowe@broadcom.com) or [scottb@sentania.net](scottb@sentania.net).  Alternatively, feel free to open an issue.

---

## 📄 License

MIT License
