SHELL := /bin/bash

build:
	python3.8 -m virtualenv src/venv; \
	source src/venv/bin/activate; \
	pip install -r src/requirements.txt -t dist/.; \
	cp src/main.py dist/; \
	cp src/Caveat-Regular.ttf dist/; \
	cd dist; \
	zip -r function.zip .;

deploy:
	terraform init terraform; \
	terraform apply -var-file=terraform/env.auto.tfvars terraform;


clean:
	rm -rf dist/*