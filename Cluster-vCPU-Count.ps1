$TotalNumvCPUs = 0
Foreach ($Cluster in (Get-Cluster |Sort Name)){
  $HostNumvCPUs = 0
  Write-Host ""ù
  Write-Host "------------------------------------"
  Write-Host "Cluster: $($Cluster.name)"
  Write-Host "------------------------------------"
    Foreach ($ESXHost in ($Cluster | Get-VMHost | Sort Name)){
    Write-Host ""ù
    Write-Host "------------------------------------"
    Write-Host " Host: $($ESXHost.name)"
    $RunningLimit = $null
    $RunningLimit = ($ESXHost |Get-VMHostAdvancedConfiguration).get_Item("Misc.RunningVCpuLimit")
    If ($RunningLimit -eq $null){
      $RunningLimit = 128
    }
    Write-Host " Misc.RunningVCpuLimit: $RunningLimit"
    Foreach ($VM in ($ESXHost |Get-VM)){
    $HostNumvCPUs += ($VM).NumCpu
    }
    Write-Host " Number of vCPU on host: $($HostNumvCPUs)"
    $TotalNumvCPUs += $HostNumvCPUs
    $HostNumvCPUs = 0
    Write-Host "------------------------------------"
}
Write-Host ""ù
Write-Host "------------------------------------"
Write-Host "Total Number of vCPU in $($Cluster.name): $TotalNumvCPUs"
Write-Host "------------------------------------"
Write-Host ""ù
$TotalNumvCPUs = 0
}
