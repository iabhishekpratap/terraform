# This file is used to define the required providers for the Terraform configuration.

terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "5.86.1"
        }
    }
}