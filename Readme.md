# K8s-hetzner

This project contains infrastructure as code (terraform) and configuration (ansible)
to setup k8s cluster at hetzner

The project is seperated into two layers, that can be triggered independently:
- Infa: a terraform stack creating the cloud resources within the hetzner
        cloud.
- Ansible: an ansible stack installing kubernetes on top of the hetzner servers

## Prerequesites

- direnv (alternatively use other way to define variables in shell env)

## Local Environment variables

To load sensitive variables direnv is used. Copy `.envrc.skeleton` to `.envrc` and
fill in the values

Load variables to env:
```bash
direnv allow
```

## Setup infrastructure layer

Plan & provision infra

```bash
cd infra/
terraform plan
terraform apply
```

## Execute installation on top of infra

Execute ansible via

```bash
cd ansible/
ansible-playbook -i hosts main.yml
```