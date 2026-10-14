# Terraform Projects

Hands-on Terraform practice on AWS (region `us-west-1`), built step by step.
Each project builds on the previous one.

| # | Folder                           | What it demonstrates |
|---|--------|-------------------------|
| 1 | `project1-basic-ec2-keypair-sg`  | Provider setup, EC2 + Key Pair + Security Group (SSH), public IP output |
| 2 | `project2-variables-tfvars`      | Input variables, sensitive values, `terraform.tfvars`, `.gitignore` for secrets |
| 3 | `project3-remote-exec`           | `remote-exec` provisioner: installs Git + Ansible on a fresh server |
| 4 | `project4-for-each`              | `for_each` creates `web1`, `web2`, `web3`; outputs a map of public IPs |

## Key concepts
- **Data sources**: default VPC and latest Amazon Linux 2023 AMI (no hardcoded AMI IDs)
- **Variables and secrets**: access keys live in `terraform.tfvars` (git-ignored); only `terraform.tfvars.example` with placeholders is committed
- **Provisioners**: `connection` block + `remote-exec` over SSH
- **`for_each`**: one resource block, many named servers; add a server by adding a name
- **Outputs**: single values and a map built with a `for` expression

## Run any project
```bash
cd <project-folder>
cp terraform.tfvars.example terraform.tfvars   # then add your own keys
terraform init
terraform plan
terraform apply
terraform destroy                              # always clean up
```

Projects 2-4 expect an SSH key pair at `~/.ssh/terraform-key(.pub)`:
```bash
ssh-keygen -t rsa -b 4096 -f ~/.ssh/terraform-key -N ""
```

## Security notes
- Never commit `terraform.tfvars`, `*.tfstate` or `.terraform/` (see `.gitignore`)
- Use an IAM user with least privilege, and rotate keys if they are ever exposed
- Stack: Terraform, AWS (EC2, VPC, Security Groups, Key Pairs), Ansible, Git
