$webhookUri = 'https://discord.com/api/webhooks/958107434407325736/3uXh3fMMeVPWCTh1ykC4uhr9oTlTp8h4cFm6paiu3N9MRoE-d3vJglVMWCAvIEZkowAO'

$Body = @{
    # embeds
#   'username' = 'Nomad'
#   'content' = 'https://memory-alpha.fandom.com/wiki/Nomad'

    # text
#   'content' = 'hello world'

    # files content
    # 'content' = Get-Content file.txt 

}
Invoke-RestMethod -Uri $webhookUri -Method 'post' -Body $Body