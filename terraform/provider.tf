provider "aws" {
  region  = "us-east-1"
  profile = "abaltra"
  version = "3.0"
}

variable "application_name" {
    default = "so-aesthetic"
}

variable "region" {
    default = "us-east-1"
}