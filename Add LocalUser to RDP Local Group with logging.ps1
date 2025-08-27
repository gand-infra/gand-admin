$user = Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object -ExpandProperty UserName

$computer = Get-WmiObject Win32_ComputerSystem | Select-Object -ExpandProperty Name

$logPath = "C:\Temp\RDPPermissionLog.txt"

$timestamp = Get-Date -Format "yyyy-MM-dd HH-mm-ss"

try { 
Add-LocalGroupMember -Name "Remote Desktop Users" -Member "$user" -ErrorAction Stop
Write-Output "[$timestamp] $user added to Remote Desktop Users Local Group on $computer." | Tee-Object -FilePath $logPath -Append
Write-Output "Message saved to log as of $timestamp."
}
catch {
Write-Output "[$timestamp] Error occured on [$computer]: $($_.Exception.Message)" | Tee-Object -FilePath $logPath -Append
Write-Output "Message saved to log as of $timestamp."
}
