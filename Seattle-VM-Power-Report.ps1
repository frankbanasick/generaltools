$AllHosts = Get-Cluster -Name Seattle | Get-VMHost | Sort Name
 
Write-Host "$(Get-Date -uformat %H:%M:%S) - $($AllHosts.length) hosts acquired"

$Cluster_VMs_On=0
$Cluster_VMs_Off=0
$i = 0
 
ForEach ($VMHost in $AllHosts) {
    $i++
    Write-Host "$(Get-Date -uformat %H:%M:%S) - $($i) of $($AllHosts.length) - $($VMHost)"
    
    $host_VMs_On = (get-vmhost -name $VMHost | get-vm | where {$_.PowerState -eq "PoweredOn"}).count
    $Cluster_VMs_On += $Host_VMs_On
    $host_VMs_Off = (get-vmhost -name $VMHost | get-vm | where {$_.PowerState -eq "PoweredOff"}).count
    $Cluster_VMs_Off += $Host_VMs_Off
   
    Write-host "Virtual Objects - Powered On: $host_VMs_ON | Off: $host_VMs_Off" 
    Write-host ""
    Write-Host "Powered Off Objects:" 
    Get-VMhost -name $VMHost | get-vm | sort | where {$_.PowerState -eq "PoweredOff"}
    Write-host ""

    
}

Write-Host "Cluster Totals - Powered Off:" $Cluster_VMs_Off
Write-Host "Cluster Totals - Powered On :" $Cluster_VMs_On
