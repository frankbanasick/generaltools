$Report =@()
$ExportFilePath = "C:\Output-VM-OS-Disk.csv"
$VMs = (Get-Cluster -Name "Seattle" | Get-VM | Sort)
ForEach ($VM in $VMs) {
 $VMInfo = {} | Select VMName,DNSName,OS,IPAddress,Disks
 $VMInfo.VMName = $vm.name
 $VMInfo.DNSName = $vm.Guest.Hostname
 $VMInfo.OS = $vm.Guest.OSFullName
 $VMInfo.IPAddress = $vm.Guest.IPAddress[0]
 $VMInfo.Disks = (@($vm.Guest.Disks.CapacityGB) -join ';')
 $Report += $VMInfo
}
$Report = $Report 

IF ($Report -ne "") {
 $Report | Export-Csv $ExportFilePath -NoTypeInformation
 }
