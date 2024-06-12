# TerraTowns

## Project Description
TerraTowns is a community website that acts as a hub to discover and connect terraformers to each other's self-hosted personal websites in the style of Geocities of 2023.

Terraformers will write the infrastructure as Code (IaC) to launch their Terra House.
A Terra House is a simple Content Management System (CMS) that will allow you to author your own personal website and connect it to the TerraTowns network.

Terraformers need to choose a theme or topic of interest and build their page around existing community hubs. 

Are you a Taylor Swift fan? Create a fan page in Melomaniac Mansion
Are you big into BBQ? Create a Brisket guide in the Cooker Cove

## [Semantic Versioning](https://semver.org/)
Given a version number **MAJOR.MINOR.PATCH**, increment the:

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

e.g. `1.0.1`

Additional labels for pre-release and build metadata are available as extensions to the - MAJOR.MINOR.PATCH format.


## Refactor Terraform CLI
Initially, the Terraform CLI couldn't install automatically on Gitpod without the user having to click `Enter` for installation to complete. The gpg keys with the previous commands were depreciated.

**Solution** - Created a bash file in the `bin` folder called `install_terraform_cli.sh` whereby I pasted the installation commands from the [official teraform site](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli).

### Resources
1. **How To Check OS Version in Linux**

    `lsb_release -a` or `cat /etc/os-release`

2. **Refactoring into Bash Scripts**

    ChatGPT recommended this format for bash: `#!/usr/bin/env bash` for portability for different OS distributions.
    
    will search the user's PATH for the bash executable
    
    https://en.wikipedia.org/wiki/Shebang_(Unix)

3. **Execution Considerations**
    
    When executing the bash script we can use the ./ shorthand notiation to execute the bash script.

    eg. `./bin/install_terraform_cli`

    If we are using a script in .gitpod.yml we need to point the script to a program to interpert it.

    eg. `source ./bin/install_terraform_cli`

4. **Linux Permissions Considerations**
    
    In order to make our bash scripts executable we need to change linux permission for the fix to be exetuable at the user mode.

    `chmod u+x ./bin/install_terraform_cli`

    alternatively:

    `chmod 744 ./bin/install_terraform_cli`
    
    https://en.wikipedia.org/wiki/Chmod

5. **Github Lifecycle (Before, Init, Command)**
    
    We need to be careful when using the Init because it will not rerun if we restart an existing workspace.

    https://www.gitpod.io/docs/configure/workspaces/tasks

## Working with Environment Variables (ENV)
- List all enverionment variables - `env`
- To view or filter ENV variables - `env | grep GITPOD`
- To print out a specific environment variable - `echo $NAME_OF_VARIABLE`
- To set an environment varible:
    1. Within a bash script - `VARIBLE_NAME='content'`
    2. In the terminal - `export VARIBLE_NAME='content'`
- To set an environment variable temporarily when running a command - `HELLO='world' ./bin/print_message`
- To unset an environment variable - `unset VARIABLE_NAME`
- Scoping of Env Vars - When you open up new bash terminals in VSCode it will not be aware of env vars that you have set in another window.
    If you want to Env Vars to persist across all future bash terminals that are open you need to set env vars in your bash profile. eg. `.bash_profile`
- Persisting Env Vars in Gitpod - We can persist env vars into gitpod by storing them in Gitpod Secrets Storage.

    `gp env HELLO='world'`

    All future workspaces launched will set the env vars for all bash terminals opened in those workspaces.

    You can also set env vars in the .gitpod.yml but this can only contain non-senstive env vars.

## AWS CLI Installation
I wrote a bash script to install AWS CLI that can be found at `/bin/install_aws_cli.sh`.

[AWS CLI install and update instructions](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

[Environment variables to configure the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

### Setup AWS Env Vars
- On local machine, run: `aws configure`
- In a cloud environment like Gitpod, **set env vars**.

Example:
```sh
gp env AWS_ACCESS_KEY_ID='AKI*******'
gp env AWS_SECRET_ACCESS_KEY='wJal****************'
gp env AWS_DEFAULT_REGION='us-****'
```
- Check if AWS credentials are configured correctly: `aws sts get-caller-identity`

## Terraform Basics

### Terraform Registry

- Terraform sources their providers and modules from the Terraform registry which located at [registry](https://registry.terraform.io/).

- **Providers** is an interface to APIs that will allow you to create resources in terraform. Can be found **[here](https://registry.terraform.io/browse/providers)**.
- **Modules** are a way to make large amount of terraform code modular, portable and sharable. Can be found **[here](https://registry.terraform.io/browse/modules)**.

### Terraform Console
- A list of all the Terrform commands can be seen by typing `terraform`

**Terraform Init**

- At the start of a new terraform project run `terraform init` to download the binaries for the terraform providers that will be used in this project.

**Terraform Plan**

- `terraform plan` will generate out a changeset, about the state of the infrastructure and what will be changed.

- The changeset can be outputed ie. "plan" to be passed to an apply, but often you can just ignore outputting.

**Terraform Apply**

- `terraform apply` will run a plan and pass the changeset to be execute by terraform. Apply should prompt yes or no.

- If you want to automatically approve an apply you can provide the auto approve flag eg. `terraform apply --auto-approve`

**Terraform Destroy**

- `teraform destroy` will destroy resources.

- You can also use the auto approve flag to skip the approve prompt eg. `terraform destroy --auto-approve`

**Terraform Lock Files**

- `.terraform.lock.hcl` contains the locked versioning for the providers or modulues that should be used with this project.

- The Terraform Lock File should be committed to your Version Control System (VSC) eg. Github

**Terraform State Files**

- `.terraform.tfstate` contain information about the current state of your infrastructure.

- This file should not be commited to your VCS. Since it can contain sensentive data.

- If you lose this file, you lose knowning the state of your infrastructure.

- `.terraform.tfstate.backup` is the previous state file state.

**Terraform Directory**

- `.terraform` directory contains binaries of terraform providers, should not be committed to your VCS.

## [Working with Terraform Cloud](https://www.terraform.io/)
- You have to create an organization if using Terraform Cloud for the first time.
- Create a new project.
- Create a new workspace under the created project. choose CLI-Driven Workflow.

## Issues with Terraform Cloud Login and Gitpod Workspace

When attempting to run `terraform login` it will launch bash a wiswig view to generate a token. However it does not work expected in Gitpod VsCode in the browser.

The workaround is manually generate a token in Terraform Cloud

https://app.terraform.io/app/settings/tokens?source=terraform-login

Then create open the file manually here:
```bash
touch /home/gitpod/.terraform.d/credentials.tfrc.json
open /home/gitpod/.terraform.d/credentials.tfrc.json
```

Provide the following code (replace your token in the file):
```json
{
  "credentials": {
    "app.terraform.io": {
      "token": "YOUR-TERRAFORM-CLOUD-TOKEN"
    }
  }
}
```

### Automate Terraform login
- Created a script file to automate the Terraform login in Gitpod. The file is located at `bin/generate_tfrc_credentials.sh`
- Generate a token via the link provided earlier.
- Create an env var to store the token `gp env TERRAFORM_CLOUD_TOKEN='token here'`
- Terraform login works without issues on the local machine.

## Set up Alias for Terraform
The goal here is to shorten `terraform` to `tf` when running the `terraform` command in the terminal.
- Created a bash script to set the Alias at `bin/set_tf_alias.sh`