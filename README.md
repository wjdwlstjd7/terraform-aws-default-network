# AWS MSA Network 구성

## 주요 버전

**Terraform Version:** `1.1.7`

**aws provider:** `4.21.0`

## 주요 자원

- Main VPC 
- Default Nacl, Default Security Group
- Public Subnets, APP subnets, DB subnets, TGW attachment subnets
- Route tables
- Nat Gateway
- Internet Gateway

## Variables

| Variable | Meaning                           |
| :------- |:----------------------------------|
| `csp`| csp 코드                            |
| `account_name`| 사용하는 account 이름                   |
| `aws_default_region`| 사용하는 account default_region       |
| `aws_access_key`| 사용하는 aws_access_key               |
| `aws_secret_key`| 사용하는 aws_secret_key               |
| `env` | 배포 환경 이름                          |
| `owner` | 리소스 관리 주체 팀                       |
| `service_name` | 리소스에 의해 운영되는 서비스                  |
| `vpc_subnet` | VPC CIDR block to use for the VPC |
| `region` | 사용하는 리전                           |
| `region_code` | 사용하는 리전 code                      |
| `tags` | 리소스 태그                            |
| `vpc_cidr` | VPC cidr                          |
| `public_subnet_cidr_list`| 생성될 VPC의 public subnet cidr 목록    |
| `ap_subnet_cidr_list`| 생성될 VPC의 app subnet cidr 목록       |
| `db_subnet_cidr_list`| 생성될 VPC의 db subnet cidr 목록        |

## Outputs

| Outputs | Meaning |
| :------- | :----- |
| `vpc_cidr`| vpc cidr |
| `create_single_az` | single az 사용 여부 |
| `used_azs` | 리소스 관리 주체 팀 |
| `subnet_ids` | 사용 중인 az 영역 |
| `vpc_subnet` | 전체 subnet id 목록 |
| `public_subnet_cidr_list`| 생성될 VPC의 public subnet cidr 목록 |
| `ap_subnet_cidr_list`| 생성될 VPC의 ap subnet cidr 목록 |
| `db_subnet_cidr_list`| 생성될 VPC의 db subnet cidr 목록 |
| `attach_subnet_cidr_list`| 생성될 VPC의 attach subnet cidr 목록 |
| `private_route_table` | private route table 목록 |
| `public_route_table` | public route table 목록 |

## Usage

# Simple Example

* 모듈을 사용하는 방법의 예입니다.

```
module "default_network" {
  source = "wjdwlstjd7/default-network/aws"
  version = "1.0.1"

  # For network resources
  vpc_cidr = var.vpc_cidr
  ap_subnet_cidr_list = var.ap_subnet_cidr_list
  db_subnet_cidr_list = var.db_subnet_cidr_list
  public_subnet_cidr_list = var.public_subnet_cidr_list
  tgwa_subnet_cidr_list = var.tgwa_subnet_cidr_list
  azs = var.azs
}

```