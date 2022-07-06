variable "csp" {
  description = "csp 코드"
  type = string
}

variable "env" {
  description = "배포 환경 이름"
  type = string
}

variable "owner" {
  description = "리소스 관리 주체 팀"
  type = string
}

variable "service_name" {
  description = "리소스에 의해 운영되는 서비스"
  type = string
}

variable "region" {
  description = "사용하는 리전"
  type = map(string)
  default = {
    AN2 = "ap-northeast-2"
  }
}

variable "region_code" {
  description = "사용하는 리전 code"
  type = string
  default = "AN2"
}

variable "azs" {
  description = "사용하는 가용영역"
  type = list(string)
  default = [
    "a",
    "c"
    ]
}

variable "tags" {
  description = "리소스 태그"
  type = map(string)
  default = {}
}

# Network
variable "vpc_cidr" {
  type = string
  description = "VPC CIDR"
}

variable "public_subnet_cidr_list" {
  type = list(string)
  description = "생성될 VPC의 public subnet cidr 목록"
}

variable "ap_subnet_cidr_list" {
  type = list(string)
  description = "생성될 VPC의 ap subnet cidr 목록"
}

variable "db_subnet_cidr_list" {
  type = list(string)
  description = "생성될 VPC의 db subnet cidr 목록"

}