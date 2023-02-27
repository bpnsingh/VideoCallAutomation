## Whatsapp Video Call Automation

# Overview

This is a custom Robot framework-based framework that can be used to automate any application, with WhatsApp video call as an example. The main focus of the project is to provide a solution for typical test automation challenges.

# Requirements

To run the project, you must have Python, ADB, and Appium set up on your machine. Please refer to the requirements.txt file for project-specific dependencies.

# Installation

To install the dependencies, run the following command in your terminal:
pip install -r requirements.txt

# Usage

To run the automation tests, use the following command:

robot -d <output directory> -v setup:<file name with device details> -v runner:<file name with project repo, app package, etc.> <test directory>


# Here's an example command:

robot -d Report/ -L debug -v setup:bipin_env -v runner:whatsappRunner Features/Whatsapp_VideoCall.robot

# Contributing

Feel free to fork and use the project.

# License

This project is not licensed.

# Contact Information

For any questions or issues, please contact bipin.csit.etc@gmail.com or visit my LinkedIn profile at https://www.linkedin.com/in/bipinsengar/.


