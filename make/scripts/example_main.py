#!/bin/bash


"""Digital Maths Calculator Console."""


import math
from argparse import ArgumentParser
import sys
import random


def parse_args() -> ArgumentParser:
    """Parse command line arguments."""
    parser = ArgumentParser(description="Calculator main argument parser.")
    parser.add_argument("--verbose", default=1, type=int,
                        help="Sets verbosity level of console")
    return parser.parse_args()


class Input:
    """Class dealing with user typed input."""

    @staticmethod
    def check_type_number(user_input: str) -> bool:
        """Checks if string input represents a number."""
        try:
            is_number = isinstance(int(user_input), (int, float, complex))
            return is_number
        except ValueError:
            return False

    @staticmethod
    def check_valid_input(input: str) -> bool:
        """Checks if user keyboard input is valid."""
        list_of_commands = ["help", "quit", "exit", "random"]

        # Check if command to change calculation
        if input[0] == "#" and len(input) > 1:
            index_number = input[1:]
            if Input.check_type_number(index_number):
                return True
        elif input.lower() in list_of_commands:
            return True
        else:
            return False


class Calculator():
    """Calculator class, capable of performing various mathematical operations."""

    def __init__(self, input: str = None) -> None:
        self.input = input

    @staticmethod
    def print_main_menu() -> None:
        """Print main menu for console."""
        menu = (
            "\n"
            """\n######################"""
            """\n# CALCULATOR CONSOLE #"""
            """\n######################"""
            "\n"
            "\nPlease choose the type of operation you would like"
            "\nto perform by typing its index number:"
            "\n"
            "\n#1) Get circumference of circle by inputting a number for the circle radius."
            "\n#2) Get area of a circle by inputting radius."
            "\n"
        )
        print(menu)

    def print_help_menu() -> None:
        """Print help menu for console."""
        menu = (
            "\n"
            """\nTo switch to another operation, type '#<index number>'. Ex: '#1" will calculate circumference."""
            """\nTo perform a random operation, type 'random'."""
            """\nTo exit the program, simply press 'Ctrl+C' or type 'exit' or 'quit'."""
            """\nTo get help, input 'help' in the console. That will take you back to this menu."""
            "\n"
        )
        print(menu)

    @staticmethod
    def get_circle_circumference_from_radius(radius: int) -> float:
        """Get circumference of a circle by inputting radius."""
        if Input.check_type_number(radius):
            circumference = 2 * math.pi * int(radius)
            return circumference
        else:
            print("Error: Radius must be expressed as number.")
            return None

    @staticmethod
    def get_circle_area_from_radius(radius: int) -> float:
        """Get area of a circle by inputting radius."""
        if Input.check_type_number(radius):
            area = math.pi * (int(radius) ^ 2)
            return area
        else:
            print("Error: Area must be expressed as number.")
            return None

    def process_input(user_input: str):
        """Decide what to do with the provided input."""
        if user_input.lower() == "random":
            user_input = random.choice(["#1", "#2"])

        if user_input.lower() in ["quit", "exit"]:
            print("\nCalculator will now exit!\n")
            sys.exit()
        elif user_input.lower() == "help":
            Calculator.print_help_menu()
        elif user_input == "#1":
            radius = input("Radius: ")
            circumference = Calculator.get_circle_circumference_from_radius(
                radius)
            if circumference:
                print("Circumference: ", round(circumference, 3))
        elif user_input == "#2":
            radius = input("Radius: ")
            print(radius)
            area = Calculator.get_circle_area_from_radius(radius)
            if area:
                print("Area: ", round(area, 3))
        else:
            print("No such option available.")
            pass


if __name__ == "__main__":
    args = parse_args()

    if int(args.verbose) == 1:
        Calculator.print_main_menu()
        Calculator.print_help_menu()

    while True:
        calc = Calculator()
        user_input = input("Console: ")
        if Input.check_valid_input(user_input):
            Calculator.process_input(user_input)
            print()
        else:
            print("Wrong input. Type in help to check what is available.")
            print()
