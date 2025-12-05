# Blueprint Deployment Module

This module deploys **any Aria Automation or VCF Automation blueprint** using dynamic inputs passed from the parent Terraform configuration.

It abstracts away the boilerplate of:
- Selecting a project  
- Supplying a blueprint ID  
- Passing input maps  
- Collecting deployment outputs  

---

## 📦 Module Inputs

| Variable | Type | Description | Required |
|---------|------|-------------|----------|
| `project_id` | string | Aria/VCF project to deploy into | Yes |
| `blueprint_id` | string | The blueprint ID or name | Yes |
| `deployment_name` | string | Name of the deployment | Yes |
| `inputs` | map(any) | Key/value inputs for the blueprint | Yes |
| `description` | string | Optional description | No |
| `tags` | list(object) | Optional blueprint deployment tags | No |

### Example Usage

```hcl
module "deployments" {
  source   = "./virtualmachine"
  for_each = var.deployments

  project_name         = var.vcfa_project
  deployment_name      = each.value.deployment_name
  description          = each.value.description
  catalog_item_name    = each.value.catalog_item_name
  inputs               = each.value.inputs
}
```

---

## 📤 Outputs

| Output | Description |
|--------|------------|
| `id` | Deployment ID |
| `name` | Deployment name |
| `resources` | Full map of deployment resources |
| `primary_ips` | List of discovered primary IP addresses |
| `resource_properties` | Flattened key/value map of resource properties |

These can be consumed by:
- DNS automation
- CMDB inserts
- NSX policy modules
- Monitoring registration pipelines

---

## 🧠 Notes / Best Practices

### ✔️ Fully single-pass  
The module does **not** require cyclic re-plans.  
All dependent attributes are fetched after creation via `deployment.resources`.

### ✔️ Blueprint-agnostic  
Any combination of inputs can be passed as long as they match the blueprint's contract.

### ✔️ Ideal for multi-repo or chained pipelines  
This module makes it trivial to build:
- Repo A → deploy VM  
- Repo B → configure DNS / CMDB / Monitoring  
- Repo C → attach network policies  
…all consuming the outputs from this module.

---

## 🧪 Testing  
You can validate the module by running:

```bash
terraform plan -var-file="envs/example.tfvars"
```

Then deploy:

```bash
terraform apply -var-file="envs/example.tfvars"
```

---

## 📜 License  
MIT
