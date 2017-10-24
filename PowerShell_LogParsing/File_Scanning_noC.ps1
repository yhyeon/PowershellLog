$drive = ((Get-PSDrive -PSProvider FileSystem | Where-Object name -ne "C" | select root).root).count
do {
if (((Get-PSDrive -PSProvider FileSystem | Where-Object name -ne "C" | select root).root).count -ne $drive)
{
$ErrorActionPreference = 'silentlycontinue'
$IP = (Get-NetIPConfiguration | Where-Object { $_.IPv4DefaultGateway -ne $null -and $_.netadapter.status -ne "Disconnected"}).ipv4address.ipaddress
$MAC = (Get-NetAdapter | where-object -FilterScript {$_.HardwareInterface -eq "True" -and $_.Status -ne "Disconnected"}).MacAddress
$aroot = (get-psdrive -PSProvider FileSystem |Where-Object name -ne "C" | select root).root
foreach ($root in $aroot)
{
foreach ($file in (Get-ChildItem $root -file -recurse))
{
$rootd = ($file.directoryname.Split(":"))[0]
$cdatetime = ($file | select CreationTime).CreationTime
$cdatetime = get-date $cdatetime -format yyyy-MM-dd@HH:mm:ss
$cdate = $cdatetime.split("@")[0]
$ctime = $cdatetime.split("@")[1]
$adatetime = ($file | select LastAccessTime).LastAccessTime
$adatetime = get-date $adatetime -format yyyy-MM-dd@HH:mm:ss
$adate = $cdatetime.split("@")[0]
$atime = $cdatetime.split("@")[1]
$mdatetime = ($file | select LastWriteTime).LastWriteTime
$mdatetime = get-date $mdatetime -format yyyy-MM-dd@HH:mm:ss
$mdate = $mdatetime.split("@")[0]
$mtime = $mdatetime.split("@")[1]
$env:userdomain + ":::;" + $env:COMPUTERNAME + ":::;" + $IP + ":::;" + $MAC + ":::;" + $env:username + ":::;" +  $cdate + ":::;" + $ctime + “ :“ + $adate + ":::;" + $atime + “ :“ + $mdate + “ :“ + $mtime + “ :“ + "{0:N2}" -f ($file.length/1kb) + ":::;" + $rootd + ":::;" + $file.directoryname + ":::;" + $file.name + ":::;" + $file.basename + ":::;" + $file.extension + ":::;" + $file.attributes | Out-File C:\Users\Public\Documents\${MAC}_$(get-date -f yyyyMMddHH)_localfiles_noC.txt -Append -Encoding utf8
}
}
$drive = ((Get-PSDrive -PSProvider FileSystem | Where-Object name -ne "C" | select root).root).count
}
sleep 1
}

While ($true)
