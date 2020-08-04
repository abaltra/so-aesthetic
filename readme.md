# So Aesthetic

Simple script that will get a random image, slap a random quote on top and share it on twitter. Runs daily as a lambda triggered by a Cloudwatch rule in AWS. All terraformed.

## How to use

First of all you'll need Twitter API creds to put in your `terraform/env.auto.tfvars` file. The required vars are:

```shell
TWITTER_CONSUMER_KEY = "pls"
TWITTER_CONSUMER_SECRET = "add"
TWITTER_ACCESS_TOKEN = "your"
TWITTER_ACCESS_TOKEN_SECRET = "creds"
```

There's a simple to use Makefile with 4 instructions. Super creative name for all of them.

```shell
make build
make deploy
make clean

make all #runs all instructions
```

## Why tho

Was bored, and wanted to play with pillow's image manipulation tools. Also Terraform is pretty cool.

## License

Copy and re-copy, feel free to do whatever you want with this code.
