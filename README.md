# GitLab-CE

This repo contains everything necessary to run a minimal GitLab-CE installation locally
or on DigitalOcean.

Requirements:
- Docker with compose
- DO account
- Terraform
- Ansible

## Management

### Secrets

> WARNING: This part is mandatory!

There are some secrets necessary for deploying this service, so to actually run it you need
to either decrypt mine, or generate new ones. To do the second thing, drop `git-crypt` from
the repo and generate new secrets. Keep in mind that GitLab is really strict with passwords.

```bash
rm .gitattributes # this removes git-crypt configuration
read -s > ./secrets/gitlab-root-password # gitlab admin password
read -s > ./secrets/gitlab-user-password # gitlab test user password
ssh-keygen -t ed25519 -f ./infra/key/id_ed25519 # vps ssh key
```

Notice that the secrets will be stored unencrypted, so don't forget to either set up `git-crypt`,
add them to `.gitignore`, etc.

### GitLab

The most important part of the configuration process is registering a runner.
You can quickly do that using Terraform file provided in `./gitlab`. First,
accquire a personal access token and run `terraform`. When configuring a remote instance
the process can be completed with this script:

```bash
# this variable is needed for terraform to run correctly
export GITLAB_BASE_URL="$(terraform -chdir=../infra output -raw ip)"
terraform apply
# register the runner
ssh "root@$GITLAB_BASE_URL" \
  -i ../infra/key/id_ed25519 \
  docker exec gitlab-runner \
  gitlab-runner register  \
  --non-interactive \
  --url "http://gitlab/" \
  --token "$(terraform output -raw runner_token)" \
  --executor "shell" \
  --description "runner"
```

> Notice that the last command is not idempotent and will create a new runner instance every time.

Process is simillar without Terraform.

## Local

To try this out locally just run `compose` from `./gitlab`.

```bash
cd gitlab
docker compose up
```

All relevant state is stored in `./gitlab/state`.

## DigitalOcean

Get your DigitalOcean token, and run `terraform` from `./infra`.

```bash
cd infra
terraform init
terraform apply
```

After that you are pretty much set. GitLab takes couple minutes to spin up, so be patient.
To get container logs, `ssh` into your machine and run `compose`.

```bash
ssh "root@$(terraform output -raw ip)" -i ./keys/id_ed25519
cd /srv/gitlab/gitlab # this is where everything related to GitLab is stored
docker compose up
```
