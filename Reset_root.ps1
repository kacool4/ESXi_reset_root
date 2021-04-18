## Connect to vCenter
 $Server = Read-Host -Prompt 'Provide vCenter IP or FQDN '
 Write-Host " Connecting to "$Server
 Connect-VIServer $Server

## List of ESXi Hosts
   Write-Host "----------------------------"
   Write-Host "List of all ESXis in vCenter"
   Write-Host "----------------------------"
   Get-VMHost | Select -ExpandProperty Name
   Write-Host "----------------------------"
   Write-Host ""

##  Type the host you want to reset from GridView
##  $vmhost = Read-Host -Prompt 'Provide FQDN of the ESXi that you need to reset ROOT account '
    
##  Select the host you want to reset from GridView
     $vmhost = Get-VMHost | Select -ExpandProperty Name | Out-GridView -PassThru -Title "Select ESXi that you need to reset Root account"

## Request for new Passowrd
  $NewCredential = Get-Credential -UserName "root" -Message "Enter a NEW password for ROOT"
 
## Reset the password
  $esxcli = get-esxcli -vmhost $vmhost -v2 
  $esxcliargs = $esxcli.system.account.set.CreateArgs()
  $esxcliargs.id = $NewCredential.UserName 
  $esxcliargs.password = $NewCredential.GetNetworkCredential().Password
  $esxcliargs.passwordconfirmation = $NewCredential.GetNetworkCredential().Password
  Write-Host ("Resetting password for: " + $vmhost) 
  $esxcli.system.account.set.Invoke($esxcliargs) 

## Disconnect from vCenter.
  Disconnect-VIServer -Server * -Force -Confirm:$False
  Write-Host " Disconnecting from "$Server
