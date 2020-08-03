terraform {
    backend "s3" {
        bucket = "abaltra-tfstates"
        key = "so-aesthetic/terraform.tfstate"
        region = "us-east-1"
        profile = "abaltra"
    }
}