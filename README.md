
# MAKE BOILERPLATE

Welcome to the help menu of the make automation tool! 
Here you will find help in regards to the functionalities
embedded within the Makefile and make folder boilerplate.

### TOOLS/SCRIPTS

Running 'make <command_name>'from within a Linux terminal will enable 
you to automake tasks related to setting up, deploying and maintaining
the codebase. For windows machines, you need to install make. Find out more
about this @http://gnuwin32.sourceforge.net/packages/make.htm. You must first
of all run 'make venv' in order for make to know which Python interpreter
and tools like PIP to work with. You should also activate the virtual 
environment by running 'source venv/bin/activate'. 

You can always come back to this menu by typing 'make help' or simply 'make'. 
For make's true help menu, use '--help'.

    @help:    bring forth this menu. 
    @build:   build will create a standardised directory structure. 
    @venv:    create a Python virtual environment and install all dependencies.
    @freeze:  will write local dependencies to file.
    @check:   check all Python files Flake8 linter and Isort.
    @fix:     will run the Autopep8 formatter and Isort on all Python files.
    @clean:   cleanup the codebase of temporary or unwanted files.
    @delete:  Caution! Erase the whole project leaving only make and Makefile. 
    @test:    TODO: run a suite of tests in verbose mode.
    @example: run the example application mathematical calculator console.

### HOW TO SETUP

Besides needing make and Python installed on your machine, you should also clone
the repository or copy these files into your desired location to immediately start
setting up a project from stratch, with all the tools you need to develop.

### FUTURE WORK

- Automate usage of Pytest using example.
- Think about including functionality related to Docker.
- Find out how to add options to the make commands for more control.