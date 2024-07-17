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


## Create S3 Bucket via AWS console & Set-up Static Website Hosting
- Login to the AWS account and search for `S3`
- Click on `Create bucket`
- Tag the S3 bucket with `UserUuid` `value of the user ID`
- Enable static website hosting under properties.
- Push files in the bucket i.e Created an index file in `public` folder.

    ```bash
    aws s3 ls #List s3 buckets

    #https://docs.aws.amazon.com/cli/latest/reference/s3/cp.html
    aws s3 cp public/index.html s3://bucketname/index.html #Copy a local file to S3
    ```
- Create a bucket policy under cloudfront.
    1. Go to `origin access` under security >> create a control setting
- Create a CloudFront distribution. Set `index.html` as the root file and attach the policy created earlier under `Origin access`
- Update the S3 bucket policy >> Edit bucket policy, Paste the copied policy.
- Use the link provided by cloudfront to access the website.

**Remember to disable all created resources to avoid any charges.**

## Root Module Structure

Our root module structure is as follows:

```
PROJECT_ROOT
│
├── main.tf                 # everything else.
├── variables.tf            # stores the structure of input variables
├── terraform.tfvars        # the data of variables we want to load into our terraform project
├── providers.tf            # defined required providers and their configuration
├── outputs.tf              # stores our outputs
└── README.md               # required for root modules
```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform and Input Variables

### Terraform Cloud Variables

In terraform cloud we can set two kind of variables:
- Enviroment Variables - those you would set in your bash terminal eg. AWS credentials
- Terraform Variables - those that you would normally set in your tfvars file

We can set Terraform Cloud variables to be sensitive so they are not shown visibliy in the UI.

### Loading Terraform Input Variables

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### var flag
We can use the `-var` flag to set an input variable or override a variable in the tfvars file eg. `terraform -var user_ud="my-user_id"`

### var-file flag

- To set lots of variables, it is more convenient to specify their values in a variable definitions file (with a filename ending in either `.tfvars` or `.tfvars.json`) and then specify that file on the command line with `-var-file:` eg. `terraform apply -var-file="testing.tfvars"
`

### terraform.tvfars

This is the default file to load in terraform variables in bulk and run: `terraform plan`

### auto.tfvars

- Terraform also automatically loads a number of variable definitions files if they are present:

    1. Files named exactly `terraform.tfvars` or `terraform.tfvars.json`.
    2. Any files with names ending in `.auto.tfvars` or `.auto.tfvars.json`.

### Order of terraform variables

- Terraform loads variables in the following order, with later sources taking precedence over earlier ones:

    - Environment variables
    - The `terraform.tfvars` file, if present.
    - The `terraform.tfvars.json` file, if present.
    - Any `*.auto.tfvars` or `*.auto.tfvars.json` files, processed in lexical order of their filenames.
    - Any `-var` and `-var-file` options on the command line, in the order they are provided. (This includes variables set by an HCP Terraform workspace.)

## Dealing With Configuration Drift
### What happens if we lose our state file?
If you lose your statefile, you most likley have to tear down all your cloud infrastructure manually.

You can use terraform import but it won't work for all cloud resources. You need to check the terraform providers documentation for which resources support import.

### Fix Missing Resources with Terraform Import
`terraform import aws_s3_bucket.bucket bucket-name`

[Terraform Import AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

### Fix Manual Configuration
If someone goes and delete or modifies cloud resource manually through ClickOps.

If we run Terraform plan is with attempt to put our infrstraucture back into the expected state fixing Configuration Drift

### Fix using Terraform Refresh
`terraform apply -refresh-only -auto-approve`

## Terraform Modules
### Terraform Module Structure
It is recommend to place modules in a `modules` directory when locally developing modules but you can name it whatever you like.

### Passing Input Variables
We can pass input variables to our module. The module has to declare the terraform variables in its own `variables.tf`

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```

### Modules Sources
Using the source we can import the module from various places eg:

- locally
- Github
- Terraform Registry

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
}
```

[Modules Sources](https://developer.hashicorp.com/terraform/language/modules/sources)

## Working with Files in Terraform
### Fileexists function
This is a built in terraform function to check the existance of a file.

`condition = fileexists(var.error_html_filepath)`

https://developer.hashicorp.com/terraform/language/functions/fileexists

### Filemd5
https://developer.hashicorp.com/terraform/language/functions/filemd5

### Path Variable
In terraform there is a special variable called `path` that allows us to reference local paths:

path.module = get the path for the current module
path.root = get the path for the root module
[Special Path Variable](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)

```
resource "aws_s3_object" "index_html" {
    bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "${path.root}/public/index.html"
}
```

## Terraform Locals

Locals allows us to define local variables.

It can be very useful when we need to  transform data into another format and have referenced a varaible.

```tf
locals {
  s3_origin_id = "MyS3Origin"
}
```
[Local Values](https://developer.hashicorp.com/terraform/language/values/locals)

## Terraform Data Sources

This allows use to source data from cloud resources.

This is useful when we want to reference cloud resources without importing them.

```tf
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```
[Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)

## Working with JSON

We use the `jsonencode` to create the json policy inline in the hcl.

```tf
jsonencode({"hello"="world"})
{"hello":"world"}
```

[jsonencode](https://developer.hashicorp.com/terraform/language/functions/jsonencode)

## Changing the Lifecycle of Resources

[Meta Arguments Lifcycle](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)


## Terraform Data

Plain data values such as Local Values and Input Variables don't have any side-effects to plan against and so they aren't valid in replace_triggered_by. You can use terraform_data's behavior of planning an action each time input changes to indirectly use a plain value to trigger replacement.

https://developer.hashicorp.com/terraform/language/resources/terraform-data