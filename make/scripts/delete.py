#!/bin/bash


import sys
import os


"""Script to deal with codebase deletion."""


def check_valid_deletion_input(input: str) -> bool:
    """Checks if user keyboard input is valid."""
    list_of_commands = ["delete", "cancel"]
    return input in list_of_commands


def main():
    print("Are you sure you want to delete the codebase?")
    response = input("You must type 'delete' to proceed or 'cancel' to exit: ").lower()
    validity = check_valid_deletion_input(response)
    if validity:
        if response == "cancel":
            print("\nOperation cancelled!\n")
            sys.exit()
        else:
            print("\nDeleting codebase.\n")
            os.system("sudo rm -rf ./src/")
            os.system("sudo rm -rf ./README.md")
            os.system("sudo rm -rf .gitignore")
            os.system("sudo rm -rf .git")
            sys.exit()
    else:
        print("\nInvalid input; operation cancelled.\n")
        sys.exit()


if __name__ == "__main__":
    main()
