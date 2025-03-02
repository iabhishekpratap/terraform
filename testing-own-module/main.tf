provider "aws" {
  region = "ap-south-1"
}

module "vpcmodule-absk" {
  source  = "iabhishekpratap/vpcmodule-absk/aws"
  version = "1.0.0"
  # insert the 2 required variables here

  vpc_config = {
    name       = "my-vpc"
    cidr_block = "10.0.0.0/16"
  }

  subnet_config = {
    public = {
      cidr_block        = "10.0.0.0/24"
      availability_zone = "ap-south-1a"
      public            = true
    }

    private = {
      cidr_block        = "10.0.1.0/24"
      availability_zone = "ap-south-1b"
    }
  }

}
