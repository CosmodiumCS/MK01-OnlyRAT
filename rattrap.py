#!/usr/bin/python
# find onlyrat devices on the network
# created by : cosmo

# imports
import os
import sys

def get_configuration(config):
    configuration = {}

    with open(config, 'r') as f:
        read_lines = f.readlines()
    
    configuration["IPADDRESS"] = read_lines[0].strip()
    configuration["PASSWORD"] = read_lines[1].strip()
    configuration["WORKINGDIRECTORY"] = read_lines[2].strip()
    configuration["STARTUPDIRECTORY"] = read_lines[3].strip()

    return configuration

# varaibles
config_file = sys.argv[1]
configuration = get_configuration(config_file)
address = '192.168.1.'
password = configuration.get("PASSWORD")

# search for device
for i in range(1, 256):
    ip = f'{address}{i}'
    print(f'[*] Trying {ip}')
    os.system(f'sshpass -p \"{password}\" ssh -o ConnectTimeout=3 onlyrat@{ip}')
