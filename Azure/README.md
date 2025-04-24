# Azure Infrastructure Provisioning with Terraform

This project contains Terraform configurations for provisioning various Azure resources, including resource groups, virtual networks, load balancer, storage, and more.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Project Structure](#project-structure)
- [Usage](#usage)
- [Modules](#modules)
- [Variables](#variables)
- [Outputs](#outputs)
- [Contributing](#contributing)
- [License](#license)

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) v1.9.8+
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) for authentication
- [Terraform Backend]Please ensure that the blob container exists for storing the backend state. In this infrastructure, the backend has already been configured using a previously created storage account.

## Project Structure

Azure/
├── modules/
│ ├── compute/
│ ├── loadbalancer/
│ ├── network/
│ ├── rg/
│ ├── storage/
└─dev.tfvars
└─main.tf
└─README.md
└─variables.tf

## Usage

1. **Clone the repository:**

    ```sh
    git clone https://github.com/hamza-cs/terraform-challenge.git
    cd Azure/modules
    ```

2. **Initialize Terraform:**

    ```sh
    terraform init
    ```

3. **Review and modify variables:**

    Edit the `variables.tf` file to set the appropriate values for your environment.


4. **Plan the infrastructure:**

    ```sh
    terraform plan
    ```

5. **Apply the configuration:**

    ```sh
    terraform apply
    ```

## Modules

This project uses several custom modules to organize and manage different aspects of the infrastructure:

- **compute**: Manages Virtaul Machine scale set.
- **loadbalancer**: Manages Azure Load Balancer and its configurations.
- **network**: Manages virtual networks and subnets.
- **rg**: Manages Resource group.
- **storage**: Manages Storage accounts.

## Variables

The `variables.tf` file contains all the input variables used in the Terraform configurations. Here are some key variables:

- `region`: The Azure region where resources will be created.
- `environment`: The environment name (e.g., dev, prod).
- `project`: The project name.
- `resource_group_name`: The name of the resource group.
- `vmss`: The name of the Azure Virtual Machines scale set.

## Outputs

The `outputs.tf` file defines the outputs of the Terraform configuration, which can include resource IDs, names, and other important information.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any changes or improvements.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.