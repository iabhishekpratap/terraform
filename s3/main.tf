
#Terraform Block
terraform {

    required_providers {
    aws = {

        source = "hashicorp/aws"
        version = "5.86.1"
    }

    random = {
        source = "hashicorp/random"
        version = "3.6.3"
        }
    }

}

#Provider Block
provider "aws" {
    region = "ap-south-1"
}



#Resource Block
resource "aws_s3_bucket" "fors3bucket" {
    bucket = "my-demo-bucket-9977"
    tags = {
        Name = "My bucket"
    }
}

resource "aws_s3_object" "bucketdata" {
    bucket = aws_s3_bucket.fors3bucket.bucket
    source = "./myfile.txt"
    key = "test.txt"

}

resource "random_id" "rand_id" {
    byte_length = 8

}

output "name" {
    value = random_id.rand_id.hex
}
