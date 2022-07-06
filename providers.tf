provider "aws" { 
  region = "ap-northeast-2" ## 리전 설정
  version = ">= 3.21.0"       ## 버전
  shared_credentials_file = "~/.aws/credentials" ## key 설정
  profile = "histapp-dev"   ## 설정된 키 profile
}

terraform {
  required_version = ">= 1.1.7" ## terraform 작성 할 버전
}