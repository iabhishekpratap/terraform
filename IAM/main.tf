terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

locals {
  user_data = yamldecode(file("./users.yaml")).users

  user_role_pairs = flatten([for user in local.user_data : [for role in user.roles : {
    username = user.username
    role     = role
  }]])
}


output "output" {
  value = local.user_role_pairs

}

# creating users
resource "aws_iam_user" "users" {
  for_each = toset(local.user_data[*].username)
  name     = each.value

}



# password creation
resource "aws_iam_user_login_profile" "profile" {
  for_each        = aws_iam_user.users
  user            = each.value.name
  password_length = 20

  # lifecycle block is used to ignore changes in the password_length, password_reset_required
  lifecycle {
    ignore_changes = [
      password_length,
      password_reset_required,
      pgp_key,
    ]
  }

}

# attaching policy to the user
resource "aws_iam_user_policy_attachment" "main" {
  for_each = {
    for pair in local.user_role_pairs :
    "${pair.username}-${pair.role}" => pair
  }

  user       = aws_iam_user.users[each.value.username].name
  policy_arn = "arn:aws:iam::aws:policy/${each.value.role}"


}


