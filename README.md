# Reset Root Password without downtime 

## Scope:
 You can use the script in order to reset the Root password on an ESXi that is connected to a vCenter. The ESXi is not part of any domain and you don't have enough resources in order to use vCenter host profile to reset the account.

## Requirements:
* Windows Server 2012 and above // Windows 10
* Powershell 5.1 and above
* PowerCLI either standalone or import the module in Powershell (Preferred)
* ESXi version 6.X
* ESXi must be part of a vCenter

## Running the script
Open Powershell or Powercli and run the script directly
```powershell
  PS> reset_root.ps1
```
It will ask you for the vCenter name. You can either put FQDN or IP and a pop up for vCenter credentials will appear. You can use any account that has "Administrator" rights on vCenter. It is not necessary to use the administrator@vsphere.local

![Alt text](/screenshots/screen0.jpg?raw=true "Run script")
 
As soon as the script logs to the vCenter it will prompt a Table with all the ESXis that are connected to it. You select the one you want and click ok

![Alt text](/screenshots/screen1.jpg?raw=true "Choose Host")

Final step is to provide the new password. The script will reset the root account with the one you provided

![Alt text](/screenshots/screen2.jpg?raw=true "Provide new password")


## Frequetly Asked Questions:
* Will be there downtime during this activity?
   > No there is no downtime. The script changes the password while the ESXi is in production

* Are there any steps to perform before running the script to the ESXi?
   > No. You dont have to set the host to maintenance mode or migrate all the vms to some other host before running the script.
   
* When the password is changed is there some impact to vCenter?
   > No. Host will still remain connected. There is no need to reconnect again the server because you change the root password.
 
 * Can I select multiple ESXi hosts?
   > No. At the moment it is only for a single change. If you want to reset the password to more ESXis you must run the script multiple times.
 
  
