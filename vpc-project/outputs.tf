# outputs.tf file is used to define the output
#variables of the terraform script. These output variables can be used to display the output of the terraform script after the successful execution of the script. The output variables can be used to display the public IP of the instance, URL of the instance, etc. The output variables can be defined using the output block in the outputs.tf file. The output block contains the output variable name, description, and value of the output variable. The value of the output variable can be defined using the interpolation syntax. The output variables can be displayed using the terraform output command after the successful

output "instance_public_ip" {
    description = "value of public ip of nginx server"
    value = aws_instance.nginxserver.public_ip
}

output "instance_url" {
    description = "url of nginx server"
    value = "http://${aws_instance.nginxserver.public_ip}"
}






