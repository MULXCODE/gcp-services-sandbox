# Copyright 2020 Google LLC
#
# This software is provided as-is, without warranty or representation for any
# use or purpose. Your use of it is subject to your agreement with Google.

.DEFAULT_GOAL := help
MAKEFILE_LIST=Makefile
BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
HASH := $(shell git rev-parse --short HEAD)
TERRAFORM_VERSION=0.12.23
TERRAGRUNT_VERSION=v0.23.2
JQ_VERSION=1.6
UNAME_S := $(shell uname -s | tr A-Z a-z)
SUDO := $(shell which sudo) ## Slight of hand, if not there then don't use it

## Tested against Mac OS 10.15 and golang:alpine

.PHONY: os
os: ## check os version
	@ echo ${UNAME_S}

.PHONY: help
help: ## help
	@ grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: all
all: install symlinks lint verify_boilerplate ## run through all automated quality checks
	@ printf "\n🚀  All systems go!\n"

.PHONY: install
install: install_homebrew install_jq install_terraform install_terragrunt install_shfmt  ## install any tools needed to develop cleanly on this repo (Mac-centric)

.PHONY: install_jq
install_jq: install_homebrew # installs jq on mac
	@ if [[ "$$(jq --version 2> /dev/null | head -n1 | awk -F- '{print $$2}')" = "${JQ_VERSION}" ]]; then \
		echo "✔︎ jq ${JQ_VERSION} already installed"; \
	else \
		if [[ ${UNAME_S} = "darwin" ]]; then \
			brew install jq; \
		elif [[ ${UNAME_S} = "linux" ]]; then \
			cd `mktemp -d` && \
			wget https://github.com/stedolan/jq/releases/download/jq-${JQ_VERSION}/jq-linux64 && \
			${SUDO} mv jq-linux64 /usr/local/bin/jq && \
			${SUDO} chmod +x /usr/local/bin/jq; \
		else \
			echo "OS not supported"; \
			exit -1; \
		fi; \
		echo "✔︎ jq successfully installed"; \
	fi


.PHONY: install_homebrew
install_homebrew: # installs homebrew on either mac
	-@ if [[ `uname -a | grep Darwin -q` ]]; then \
		[[ `brew -v` ]] && \
		( echo "✔︎ brew already installed" ) && exit 0 || \
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" && \
		echo "✔︎ brew installed"; \
		fi

.PHONY: lint
lint: terraform_fmt terragrunt_fmt shfmt ## Lint all terraform and shell code

.PHONY: verify_boilerplate
verify_boilerplate: ## ensure all files have the Google no-warranty headers
	@ scripts/verify_boilerplate/verify_boilerplate.py --rootdir . && \
		echo "✔︎ Google headers verified to be in place"

.PHONY: symlinks
symlinks: ## create symlinks
	@ if scripts/make_symlinks.sh ; then \
			echo "✔︎ Symlinks verified to be in place"; \
		else \
			echo "☠ Symlinks changed during this run. Try again" ; \
			exit 1; \
		fi

.PHONY: install_terraform
install_terraform: ## install terraform
	@ if [[ "$$(terraform version 2> /dev/null | head -n1 | awk '{print $$2}' | tr -d 'v')" = "${TERRAFORM_VERSION}" ]]; then \
		echo "✔︎ terraform ${TERRAFORM_VERSION} already installed"; \
	else \
		cd `mktemp -d` && \
		wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_${UNAME_S}_amd64.zip && \
		unzip terraform_${TERRAFORM_VERSION}_${UNAME_S}_amd64.zip && \
		${SUDO} mv terraform /usr/local/bin/terraform && \
		rm -f terraform_${TERRAFORM_VERSION}_${UNAME_S}_amd64.zip && \
		${SUDO} chmod +x /usr/local/bin/terraform; \
		echo "✔︎ terraform successfully installed"; \
	fi

.PHONY: install_terragrunt
install_terragrunt: ## install terragrunt
	@ if [[ "$$(terragrunt --version 2> /dev/null | head -n1 | awk '{print $$3}')" = "${TERRAGRUNT_VERSION}" ]]; then \
		echo "✔︎ terragrunt ${TERRAGRUNT_VERSION} already installed"; \
	else \
		cd `mktemp -d` && \
		wget https://github.com/gruntwork-io/terragrunt/releases/download/${TERRAGRUNT_VERSION}/terragrunt_${UNAME_S}_amd64 && \
		${SUDO} mv terragrunt_${UNAME_S}_amd64 /usr/local/bin/terragrunt && \
		${SUDO} chmod +x /usr/local/bin/terragrunt; \
		echo "✔︎ terragrunt successfully installed"; \
	fi

.PHONY: install_shfmt
install_shfmt: ## install shfmt, shell format checker
	@ command -v shfmt >/dev/null 2>&1 && \
		( echo "✔︎ shfmt `shfmt --version` already installed" ) || \
		( cd `mktemp -d` && \
			go mod init tmp && \
			go get mvdan.cc/sh/cmd/shfmt && \
			echo "✔︎ shfmt `shfmt --version` successfully installed" \
		)

.PHONY: shfmt
shfmt: ## shfmt check
	@ find . -type f -name "*.sh" -not -path "*/.terragrunt-cache/*"  -not -path ".*/terraform/*" -exec shfmt -w -d -s -i 2 {} \; && \
		echo "✔︎ shell scripts have been formatted"

.PHONY: terraform_fmt
terraform_fmt: ## terraform fmt
	@ terraform fmt -recursive terraform/ && \
		echo "✔︎ terraform code has been formatted"

.PHONY: terragrunt_fmt
terragrunt_fmt: ## terragrunt fmt with surpressed output
	@ terragrunt hclfmt > /dev/null 2>&1 && \
		echo "✔︎ terragrunt code has been formatted"

.PHONY: shfmt_dryrun
shfmt_dryrun: ## dryrun shfmt
	@ find . -type f -name "*.sh" -exec echo shfmt -w -d -s -i 2 {} \; && \
		echo "✔︎ the shell scripts above would have been formatted"

.PHONY: terraform_fmt_dryrun
terraform_fmt_dryrun: ## dryrun terraform fmt
	@ terraform fmt -check -recursive terraform/ || true && \
		echo "✔︎ the files in the directories above would have been formatted"

.PHONY: terragrunt_fmt_dryrun
terragrunt_fmt_dryrun: ## dryrun terragrunt fmt
	@ terragrunt hclfmt --terragrunt-check 2>&1 |awk '/Invalid/ {print $$4}' && \
		echo "✔︎ the files in the directories above would have been formatted"
