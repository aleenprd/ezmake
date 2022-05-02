#!/bin/bash

################
# INTRODUCTION #
################

# This is a boilerplate Makefile for setting up the basics of
# a standardized data science project developed in Python.
# This makefile can of course be extended or tampered with
# by the user. It provides an example on how to automate
# different processes and make your workflow easier, more
# standardized and customizable.


################
# DIRECTIORIES #
################

ROOT_DIR:=./
SRC_DIR:="$(ROOT_DIR)src"
VENV_DIR:="$(ROOT_DIR)venv"
VENV_BIN_DIR:="$(VENV_DIR)/bin"
MAKE_DIR:="$(ROOT_DIR)make"
MAKE_SCRIPTS_DIR:="$(MAKE_DIR)/scripts"
MAKE_UTILS_DIR:="$(MAKE_DIR)/utils"
REQUIREMENTS_DIR:="$(SRC_DIR)/requirements"
CONFIGS_DIR:="$(SRC_DIR)/configs"
DEPENDENCIES_DIR:="$(SRC_DIR)/dependencies"
DEVELOPMENT_FILES_DIR:="$(SRC_DIR)/development_files"
TESTS_DIR:="$(SRC_DIR)/tests"
TESTS_DATA_DIR:="$(TESTS_DIR)/data"
TESTS_FIXTURES_DIR:="$(TESTS_DIR)/fixtures"
STORAGE_DIR:="$(SRC_DIR)/storage"
DOCUMENTATION_DIR:="$(SRC_DIR)/documentation"


#########
# FILES #
#########

REQUIREMENTS_LOCAL:="$(REQUIREMENTS_DIR)/requirements.txt"
HELP_FILE:="$(MAKE_UTILS_DIR)/make_help_menu.txt"
MAIN_EXAMPLE_FILE:="$(MAKE_SCRIPTS_DIR)/example_main.py"
DELETE_FILE:="$(MAKE_SCRIPTS_DIR)/delete.py"
MAIN_FILE:="$(SRC_DIR)/main.py"
PYTHON_GITIGNORE_TEMPLATE:="$(MAKE_UTILS_DIR)/python_gitignore_template
EXAMPLE_CONFIG:="$(MAKE_UTILS_DIR)/example_config.yaml


#######################
# PYTHON AND PACKAGES #
#######################

PYTHON:="$(VENV_BIN_DIR)/python3"
PIP:="$(VENV_BIN_DIR)/pip"
FLAKE8:="$(VENV_BIN_DIR)/flake8"
AUTOPEP8:="$(VENV_BIN_DIR)/autopep8"
PYTEST:="$(VENV_BIN_DIR)/pytest"


########
# UDFs #
########

# Install the base packages needed for this Makefile
define install-python-packages
$(PIP) install pipreqs
$(PIP) install isort
$(PIP) install flake8
$(PIP) install autopep8
$(PIP) install pyclean
$(PIP) install pytest
endef

# Test if folders already present, else create
define build-dirs
@mkdir -p $(SRC_DIR)
@mkdir -p $(TESTS_DIR)
@mkdir -p $(TESTS_DATA_DIR)
@mkdir -p $(STORAGE_DIR)
@mkdir -p $(TESTS_FIXTURES_DIR)
@mkdir -p $(CONFIGS_DIR)
@mkdir -p $(DEPENDENCIES_DIR)
@mkdir -p $(DEVELOPMENT_FILES_DIR)
@mkdir -p $(REQUIREMENTS_DIR)
@mkdir -p $(DOCUMENTATION_DIR)
endef

# Test if files already present, else create
define build-files
@test -f $(ROOT_DIR)/README.md || touch $(ROOT_DIR)/README.md
@test -f $(ROOT_DIR)/.gitignore || cp $(PYTHON_GITIGNORE_TEMPLATE) $(ROOT_DIR)/.gitignore
@test -f $(MAIN_FILE) || echo "#!/bin/bash" > $(MAIN_FILE)
@test -f $(REQUIREMENTS_LOCAL) || touch $(REQUIREMENTS_LOCAL)
@test -f $(DEPENDENCIES_DIR)/__init__.py || touch $(DEPENDENCIES_DIR)/__init__.py
@test -f $(TESTS_FIXTURES_DIR)/__init__.py || touch $(TESTS_FIXTURES_DIR)/__init__.py
@test -f $(DOCUMENTATION_DIR)/Whitepaper.md || touch $(DOCUMENTATION_DIR)/Whitepaper.md
@test -f $(CONFIGS_DIR)/example_config.yaml || cp $(EXAMPLE_CONFIG) $(CONFIGS_DIR)/config.yaml
endef

######################
# COMMAND LINE TOOLS #
######################

help:
	@cat $(HELP_FILE)

build:
	# Build standardised codebase structure for data science project.
	@$(build-dirs)
	@$(build-files)

venv: build
	# Create a virtual environment and install default packages.
	@virtualenv $(VENV_DIR) -p python3
	@$(install-python-packages)
	@$(PIP) install -r $(REQUIREMENTS_LOCAL)

freeze:
	# Freeze the dependencies and update the local requirements file.
	@$(PIP) freeze > $(REQUIREMENTS_LOCAL)

check:  
	# Check code with linter and module import sorter.
	@$(FLAKE8) src
	@$(ISORT) -rc -c src

fix: check
	# Apply formatting to .py files and save.
	@$(AUTOPEP8) --in-place --aggressive --recursive src
	@$(ISORT) .

clean: venv
	# Cleans the directory of common clutter files and folders, deletes ./venv.
	@rm -rf .cache
	@rm -rf $(VENV_DIR)
	@pyclean src

delete: clean
	# Will run a Python script to delete everything except for ./make, Makefile.
	@$(PYTHON) $(DELETE_FILE)

example:
	# Example of custom application automation using make.
	@sudo $(PYTHON) $(MAIN_EXAMPLE_FILE) --verbose 1


# CUSTOM TOOLS/SCRIPTS #
########################
# Insert your custom tools and scripts here. Create custom variables and UDFs.
