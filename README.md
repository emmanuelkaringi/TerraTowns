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
