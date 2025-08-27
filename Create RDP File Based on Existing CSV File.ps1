$csvData = Import-Csv -Path "C:\Temp\RDPList.csv"

#Define Variables
$user = $env:USERNAME
$columnNameToSearch = "SAMAccountName"

try{
#Look for row where login name exists
$foundRow = $csvData | Where-Object { $_.$columnNameToSearch -eq $user } -Verbose

#Assign server name to found workstation 
$server = $foundRow.ComputerName

$rdpPath = "C:\Users\$user\Desktop\$server.rdp"

#Create RDP file with set configuration

New-Item -ItemType file -Path $rdpPath -Force -Verbose -ErrorAction Stop
"full address:s:$server" | Out-File -FilePath $rdpPath -Encoding ASCII -Append
"username:s:$user" | Out-File -FilePath $rdpPath -Encoding ASCII -Append
"audiomode:i:2" | Out-File -FilePath $rdpPath -Encoding ASCII -Append
"redirectclipboard:i:1" | Out-File -FilePath $rdpPath -Encoding ASCII -Append
"use multimon:i:1" | Out-File -FilePath $rdpPath -Encoding ASCII -Append
}
catch{
Write-Output "Error occured: $($_.Exception.Message)"
exit 1
}

