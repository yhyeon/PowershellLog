$ErrorActionPreference = 'silentlycontinue'

$sw = [System.Diagnostics.Stopwatch]::startnew()

<#
if (!(Get-Module -name PowerForensics))
{
Install-Module -Name PowerForensics -Force
}
#>

$IP = (Get-NetIPConfiguration | Where-Object { $_.IPv4DefaultGateway -ne $null -and $_.netadapter.status -ne "Disconnected"}).ipv4address.ipaddress
$MAC = (Get-NetAdapter | where-object -FilterScript {$_.HardwareInterface -eq "True" -and $_.Status -ne "Disconnected"} | Where-Object {$_.InterfaceDescription -notmatch "TEST"}).MacAddress
$sn = (Get-WMIObject win32_physicalmedia | Where-Object {$_.tag -match "PHYSICALDRIVE0"} | select SerialNumber).SerialNumber
if ($sn -ne $null)
{
if ($sn -match " ")
{
$sn = $sn.split(" ")[-1]
}
else
{
$sn = $sn
}
}
elseif ($sn -eq $null)
{
$sn = (Get-WMIObject win32_physicalmedia | Where-Object {$_.tag -match "PHYSICALDRIVE1"} | select SerialNumber).SerialNumber
if ($sn -match " ")
{
$sn = $sn.split(" ")[-1]
}
else
{
$sn = $sn
}
}


Import-Module PowerForensics

get-date -Format yyyy-MM-dd-HH-mm-ss | out-file C:\ProgramData\soalog\ustart.txt -Encoding utf8

if (!(Test-Path -Path 'C:\ProgramData\soalog\utime.txt'))
{
$uj = (Get-ForensicUsnJrnl -VolumeName C:)
$ujs = $uj | select volumepath, recordnumber, filesequencenumber, parentfilerecordnumber, parentfilesequencenumber, usn, timestamp, reason, filename, fileattributes
$count = $uj.Count

for($i = 0; $i -lt $count; $i++)
{
$timestamp = $ujs[$i].timestamp | Get-Date -Format yyyy-MM-ddTHH:mm:ss+09:00
$sn + ":::;" + $env:userdomain+ ":::;" + $env:COMPUTERNAME + ":::;" + $IP + ":::;" + $MAC + ":::;" + $env:username + ":::;" + ([string]($ujs[$i].VolumePath)).Replace("\\.","") + ":::;" + [string]($ujs[$i].RecordNumber)  + ":::;" + [string]($ujs[$i].FileSequenceNumber) + ":::;" + [string]($ujs[$i].ParentFileRecordNumber) + ":::;" + [string]($ujs[$i].ParentFileSequenceNumber) + ":::;" + [string]($ujs[$i].Usn) + ":::;" + $timestamp + ":::;" + [string]($ujs[$i].Reason) + ":::;" + [string]($ujs[$i].FileName) + ":::;" + [string]($ujs[$i].FileAttributes) + ":::;" | select -Unique | Out-File C:\ProgramData\soalog\${sn}_$(get-date -f yyyyMMddHHmm)_usnjrnl.txt -Append -Encoding utf8
$i.Dispose()
$sn.Dispose()
$IP.Dispose()
$MAC.Dispose()
$timestamp.Dispose()
}
}

else
{

$start = Get-Content C:\ProgramData\soalog\utime.txt
$start = $start.Replace("-",",").Split(",")
$sy = $start[0]
$sm = $start[1]
$sd = $start[2]
$sh = $start[3]
$smi = $start[4]
$ss = $start[5]
$start = New-Object datetime($sy,$sm,$sd,$sh,$smi,$ss)

$uj = Get-ForensicUsnJrnl -VolumeName C: | ? {($_.TimeStamp -gt $start)}
$ujs = $uj | select volumepath, recordnumber, filesequencenumber, parentfilerecordnumber, parentfilesequencenumber, usn, timestamp, reason, filename, fileattributes
$count = $uj.Count

for($i = 0; $i -lt $count; $i++)
{
$timestamp = $ujs[$i].timestamp | Get-Date -Format yyyy-MM-ddTHH:mm:ss+09:00
$sn + ":::;" + $env:userdomain+ ":::;" + $env:COMPUTERNAME + ":::;" + $IP + ":::;" + $MAC + ":::;" + $env:username + ":::;" + ([string]($ujs[$i].VolumePath)).Replace("\\.","") + ":::;" + [string]($ujs[$i].RecordNumber)  + ":::;" + [string]($ujs[$i].FileSequenceNumber) + ":::;" + [string]($ujs[$i].ParentFileRecordNumber) + ":::;" + [string]($ujs[$i].ParentFileSequenceNumber) + ":::;" + [string]($ujs[$i].Usn) + ":::;" + $timestamp + ":::;" + [string]($ujs[$i].Reason) + ":::;" + [string]($ujs[$i].FileName) + ":::;" + [string]($ujs[$i].FileAttributes) + ":::;" | select -Unique | Where-Object {$_ -notin $compare} | Out-File C:\ProgramData\soalog\${sn}_$(get-date -f yyyyMMddHHmm)_usnjrnl.txt -Append -Encoding utf8
$i.Dispose()
$sn.Dispose()
$IP.Dispose()
$MAC.Dispose()
$timestamp.Dispose()
}
}

$count.Dispose()
$ujs.Dispose()
$uj.Dispose()


Import-Module bitstransfer
$enc = Get-Content C:\Windows\soa\enp.txt | ConvertTo-SecureString # specify the directory where the encrypted password file is located
$user = "Administrator" # server ID
$cred = New-Object System.Management.Automation.PSCredential($user,$enc)
$src = "C:\ProgramData\soalog\*_usnjrnl.txt"
Get-ChildItem -path $src |
foreach {
$dst = "http://cdisc.co.kr:1024/soa/upload/$($_.name)" # server directory with write permissions
$job = Start-BitsTransfer -source $($_.FullName) -Destination $dst -Credential $cred -TransferType Upload -Asynchronous
while (($job.jobstate -eq "Transferring") -or ($job.jobstate -eq "Connecting")) `
{sleep 20;}
if ($job.JobState -eq "Transferred")
{
Remove-Item $($_.FullName)
$today = get-date -Format yyyy-MM-dd
$startdate = (Get-Content C:\ProgramData\soalog\mstart.txt).Split("-")[0,1,2] -join "-"
if ($startdate -eq $today)
{
Get-Content -Path "C:\ProgramData\soalog\mstart.txt" | out-file C:\ProgramData\soalog\mtime.txt -encoding utf8
}
}

Switch($job.jobstate)
{
"Transferred" {Complete-BitsTransfer -BitsJob $job}
#"TransientError" {Resume-BitsTransfer -BitsJob $job}
#"Error" {Resume-BitsTransfer -BitsJob $job}
}
$dst.Dispose()
$job.Dispose()
}
$enc.Dispose()
$user.Dispose()
$cred.Dispose()
$src.Dispose()

$sw.stop()
$sw.Elapsed.tostring('dd\.hh\"mm\:ss\.fff')
