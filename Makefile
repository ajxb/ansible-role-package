SHELL=/usr/bin/env bash

export ANSIBLE_FORCE_COLOR=0
export PY_COLORS=0

TEST_OPTIONS?=--all --parallel

.PHONY: all clean cleanlint cleantest init lint test update

all: clean init lint test

clean: cleanlint cleantest
	rm -fr pip-install.log
	rm -fr pip-upgrade.log
	rm -fr results
	rm -fr .venv

cleanlint:
	rm -fr results/lint

cleantest:
	rm -fr results/test
	rm -fr collections
	rm -fr roles

init:
	python3 -m venv .venv
	source .venv/bin/activate && pip install --upgrade pip &> pip-install.log
	source .venv/bin/activate && pip install -r requirements.txt &>> pip-install.log
	docker pull ajxb/fedora:latest

lint: cleanlint init
	mkdir -p results/lint
	source .venv/bin/activate && yamllint --format standard . &> results/lint/yamllint.md
	source .venv/bin/activate && ansible-lint --format md --nocolor &> >(grep -v "WARNING  Another version of" &> results/lint/ansible-lint.md)

test: cleantest init
	mkdir -p results/test
	source .venv/bin/activate && export SUFFIX=-$$$$ && molecule test $(TEST_OPTIONS) &> >(grep -v "WARNING  Another version of" &> results/test/molecule.log)

update: init
	source .venv/bin/activate && pip install pip-upgrader --upgrade &> pip-upgrade.log
	source .venv/bin/activate && pip-upgrade -p all
