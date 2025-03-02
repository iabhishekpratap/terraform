This is the complete config to work with this module.

Usage

```
provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source = "./modules/vpc"
  vpc_config = {
    name       = "my-vpc"
    cidr_block = "10.0.0.0/16"


  }
  subnet_config = {
    public1 = {
      cidr_block        = "10.0.0.0/24"
      availability_zone = "ap-south-1a"
      public            = true
    }

    public2 = {
      cidr_block        = "10.0.2.0/24"
      availability_zone = "ap-south-1c"
      public            = true
    }

    private = {
      cidr_block        = "10.0.1.0/24"
      availability_zone = "ap-south-1b"
    }
  }

}

```
