provider “aws” {
    aws_access_key_id = "xxxxxxxxxxxxxxxxx"
    aws_secret_access_key = "yyyyyyyyyyyyyyyyyyyyyyyyyyyy"
    region = “eu-central-1”
}

resource "aws_instance" "my_ubuntu" {
    ami = “ami..”
    instance_type = “t3.micro”
}

${terraform.workspace}

#Terraform для простой сети VРС с одной открытой подсетью.
# диапазон адресов VPC в виде переменной
variable "vpc_cidr" {
    default = "IP/16"
}

# Диапазон адресов для публичной подсети
variable "public_subnet_cidr " {
    default = "IP/24"
}

# Сеть VPC
resource "aws_vpc" "default" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
}

# Интернет-шлюз для соединения VPC с Интернетом
resource "aws_internet_gateway" "default " {
    vpc_id "${aws_vpc.default.id} "
}

# Публичная подсеть
resource " aws_subnet " "public-us-west-2a" {
    vpc_id = " ${aws_vpc.default.id} "
    cidr_block = "${var.public_subnet_cidr} "
    availablity_zone = "us-west-2a"
    # Таблица маршрутизации для публичной подсети
    resource "aws_route_table" "public-us-west-2a” {
    vpc_id = "${aws_vpc.default.id}"
    route {
        cidr_block "О.О.О.О/О"
        gateway_id "${aws_internet_gateway.default.id} "
	}
}

# Связывание таблицы маршрутизации с публичной подсетью
resource "aws_route_table_assiciation" "public-us-west-2-a"
subnet_id = " ${aws_subnet.public-us-west-2a.id}"
route_table_id = "${aws_route_table.public-us-west-2a.id}
}
terraform apply # Terraform create сеть VPC

Terraform  анализирует current dir, находит tf-файлы, обрабатывает каждый из них, создает план выполнения, а затем делает вызовы API в соответствующем порядке. 
env vars 
