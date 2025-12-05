# simpleIaC
A streamlined Terraform-based framework for deploying **any Aria Automation / VCF Automation blueprint** using a single-pass plan and a clean variable-driven model.

This repository provides:
- A top-level Terraform deployment that accepts environment-specific inputs.
- A reusable module capable of deploying **any** blueprint by passing inputs dynamically from a `.tfvars` file.
- Optional output exports for downstream integrations (DNS, CMDB, monitoring, etc.).

The design avoids circular dependencies and multi-pass planning by decoupling blueprint resource creation from consumer processes.

---

## 🚀 Features

### ✔️ Single-pass Terraform deployment
The module has been refactored so that:
- All blueprint inputs come from your `.tfvars` file.
- Outputs from the deployment are exported without requiring a secondary plan or refresh.

### ✔️ Generic blueprint module
Feed it:
- The blueprint ID or name  
- Input map  
- Project / region target  
- Optional metadata and tagging  

The module handles the rest.

### ✔️ Clean separation of concerns
This repo focuses on **provisioning only**.  
Any post-provision actions (DNS, CMDB, NSX security, etc.) can be consumed from the outputs.

---

## 📁 Repository Structure

```
simpleIaC/
├── main.tf
├── providers.tf
├── variables.tf
├── outputs.tf
├── envs/
│   ├── lab.tfvars
│   └── example.tfvars
└── modules/
    └── blueprint-deploy/
        ├── main.tf
        ├── variables.tf
        ├── outputs.tf
```

---

## 🧩 Using This Repository

### 1. Clone the repo
```bash
git clone https://github.com/sentania-labs/simpleIaC
cd simpleIaC
```

### 2. Copy an env file
```bash
cp envs/example.tfvars envs/my-env.tfvars
```

### 3. Edit your TF vars
Specify:
- `project_id`
- `blueprint_id`
- `deployment_name`
- `inputs = { ... }`

Example:
```hcl
project_id      = "12345"
blueprint_id    = "bp-abcdef"
deployment_name = "my-vm"
inputs = {
  cpu_count = 4
  mem_gb    = 16
  hostname  = "example"
}
```

### 4. Initialize Terraform
```bash
terraform init
```

### 5. Plan and Apply
```bash
terraform plan -var-file="envs/my-env.tfvars"
terraform apply -var-file="envs/my-env.tfvars"
```

---

## 📤 Outputs

The deployment exports:
- Deployment ID  
- Deployment name  
- Resource map (each VM / disk / nic)  
- IP address details  
- Custom property results (if enabled)

These can be consumed by downstream repos or pipelines.

---

## 🧱 Module Reference

See `Readme.md` for documentation of the reusable blueprint module.

---

## 🤝 Contributing

Feel free to open PRs if you'd like to contribute enhancements such as:
- More flexible input validation
- Event-driven follow-up integrations
- Example downstream modules

---

## 📜 License

MIT — use freely in your lab, enterprise, or demos.
