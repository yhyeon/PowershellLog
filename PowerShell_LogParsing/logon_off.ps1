$events = get-winevent -FilterHashtable @{logname='security'; ID = 4624, 528, 540, 4648, 552, 4634, 538, 4647, 551, 4608, 512, 4625, 529, 530, 531, 532, 533, 534, 536, 537, 539} | foreach {$_.toxml()}
foreach ($logon in $events)
{$logon = $logon.split("<")
$eventid = $logon | select-string -pattern 'EventID'
$eventid = $eventid.line.split(">")[1]

if (($eventid -eq "4624") -or ($eventid -eq "528") -or ($eventid -eq "540"))
{
$log = '계정 로그온 성공'
$nul = "-"
$time = $logon | select-string -Pattern 'TimeCreated SystemTime'
$time = [datetime]($time.line.split("=").split("/>").split("'")[2])
$computer = $logon | select-string -pattern 'Computer'
$computer = $computer.line.split(">")[1]
$subjectsid = $logon | select-string -Pattern 'SubjectUserSid'
$subjectsid = $subjectsid.line.Split(">")[1]
$subjectuname = $logon | select-string -Pattern 'SubjectUserName'
$subjectuname = $subjectuname.line.Split(">")[1]
$subjectdname = $logon | select-string -Pattern 'SubjectDomainName'
$subjectdname = $subjectdname.Line.Split(">")[1]
$subjectlogonid = $logon | select-string -Pattern 'SubjectLogonId'
$subjectlogonid = $subjectlogonid.line.Split(">")[1]
$targetuname = $logon | select-string -Pattern 'TargetUserName'
$targetuname = $targetuname.line.Split(">")[1]
$targetdname = $logon | select-string -Pattern 'TargetDomainName'
$targetdname = $targetdname.line.Split(">")[1]
$log + " : " + $eventid + " : " + $time + " : " + $computer + " : " + $subjectsid + " : " + $subjectuname + " : " + $subjectdname + " : " + $subjectlogonid + " : " + $null + " : " + $targetuname + " : " + $targetdname + " : " + $null+ " : " + $null  | out-file C:\Users\Public\Documents\${env:COMPUTERNAME}_$(get-date -f yyyyMMddhh)_logonoff.txt -Append
}
elseif (($eventid -eq "4648") -or ($eventid -eq "552"))
{
$log = '명시적 자격 증명 로그온 시도'
$nul = "-"
$time = $logon | select-string -Pattern 'TimeCreated SystemTime'
$time = [datetime]($time.line.split("=").split("/>").split("'")[2])
$computer = $logon | select-string -pattern 'Computer'
$computer = $computer.line.split(">")[1]
$subjectsid = $logon | select-string -Pattern 'SubjectUserSid'
$subjectsid = $subjectsid.line.Split(">")[1]
$subjectuname = $logon | select-string -Pattern 'SubjectUserName'
$subjectuname = $subjectuname.line.Split(">")[1]
$subjectdname = $logon | select-string -Pattern 'SubjectDomainName'
$subjectdname = $subjectdname.Line.Split(">")[1]
$subjectlogonid = $logon | select-string -Pattern 'SubjectLogonId'
$subjectlogonid = $subjectlogonid.line.Split(">")[1]
$targetuname = $logon | select-string -Pattern 'TargetUserName'
$targetuname = $targetuname.line.Split(">")[1]
$targetdname = $logon | select-string -Pattern 'TargetDomainName'
$targetdname = $targetdname.line.Split(">")[1]
$log + " : " + $eventid + " : " + $time + " : " + $computer + " : " + $subjectsid + " : " + $subjectuname + " : " + $subjectdname + " : " + $subjectlogonid + " : " + $null + " : " + $targetuname + " : " + $targetdname + " : " + $null+ " : " + $null  | out-file C:\Users\Public\Documents\${env:COMPUTERNAME}_$(get-date -f yyyyMMddhh)_logonoff.txt -Append
}
elseif (($eventid -eq "4634") -or ($eventid -eq "538"))
{
$log = '계정 로그오프'
$nul = "-"
$time = $logon | select-string -Pattern 'TimeCreated SystemTime'
$time = [datetime]($time.line.split("=").split("/>").split("'")[2])
$computer = $logon | select-string -pattern 'Computer'
$computer = $computer.line.split(">")[1]
$targetsid = $logon | select-string -Pattern 'TargetUserSid'
$targetsid = $targetsid.line.Split(">")[1]
$targetuname = $logon | select-string -Pattern 'TargetUserName'
$targetuname = $targetuname.line.Split(">")[1]
$targetdname = $logon | select-string -Pattern 'TargetDomainName'
$targetdname = $targetdname.line.Split(">")[1]
$targetlogonid = $logon | select-string -Pattern 'TargetLogonId'
$targetlogonid = $targetlogonid.line.Split(">")[1]
$log + " : " + $eventid + " : " + $time + " : " + $computer + " : " + $null + " : " + $null + " : " + $null + " : " + $null + " : " + $targetsid + " : " + $targetuname + " : " + $targetdname + " : " + $targetlogonid+ " : " + $null  | out-file C:\Users\Public\Documents\${env:COMPUTERNAME}_$(get-date -f yyyyMMddhh)_logonoff.txt -Append
}
elseif (($eventid -eq "4647") -or ($eventid -eq "551"))
{
$log = '사용자 로그오프'
$nul = "-"
$time = $logon | select-string -Pattern 'TimeCreated SystemTime'
$time = [datetime]($time.line.split("=").split("/>").split("'")[2])
$computer = $logon | select-string -pattern 'Computer'
$computer = $computer.line.split(">")[1]
$targetsid = $logon | select-string -Pattern 'TargetUserSid'
$targetsid = $targetsid.line.Split(">")[1]
$targetuname = $logon | select-string -Pattern 'TargetUserName'
$targetuname = $targetuname.line.Split(">")[1]
$targetdname = $logon | select-string -Pattern 'TargetDomainName'
$targetdname = $targetdname.line.Split(">")[1]
$log + " : " + $eventid + " : " + $time + " : " + $computer + " : " + $null + " : " + $null + " : " + $null + " : " + $null + " : " + $targetsid + " : " + $targetuname + " : " + $targetdname + " : " + $null+ " : " + $null  | out-file C:\Users\Public\Documents\${env:COMPUTERNAME}_$(get-date -f yyyyMMddhh)_logonoff.txt -Append
}
elseif (($eventid -eq "4608") -or ($eventid -eq "512"))
{
$log = '윈도우 시작'
$nul = "-"
$time = $logon | select-string -Pattern 'TimeCreated SystemTime'
$time = [datetime]($time.line.split("=").split("/>").split("'")[2])
$computer = $logon | select-string -pattern 'Computer'
$computer = $computer.line.split(">")[1]
$targetsid = $logon | select-string -Pattern 'TargetUserSid'
$targetsid = $targetsid.line.Split(">")[1]
$targetuname = $logon | select-string -Pattern 'TargetUserName'
$targetuname = $targetuname.line.Split(">")[1]
$targetdname = $logon | select-string -Pattern 'TargetDomainName'
$targetdname = $targetdname.line.Split(">")[1]
$log + " : " + $eventid + " : " + $time + " : " + $computer + " : " + $null + " : " + $null + " : " + $null + " : " + $null + " : " + $null + " : " + $null + " : " + $null + " : " + $null+ " : " + $null  | out-file C:\Users\Public\Documents\${env:COMPUTERNAME}_$(get-date -f yyyyMMddhh)_logonoff.txt -Append
}
elseif (($eventid -eq "4625") -or ($eventid -eq "529") -or ($eventid -eq "530") -or ($eventid -eq "531") -or ($eventid -eq "532") -or ($eventid -eq "533") -or ($eventid -eq "534") -or ($eventid -eq "535") -or ($eventid -eq "536") -or ($eventid -eq "537") -or ($eventid -eq "539"))
{
$log = '로그온 실패'
$nul = "-"
$time = $logon | select-string -Pattern 'TimeCreated SystemTime'
$time = [datetime]($time.line.split("=").split("/>").split("'")[2])
$computer = $logon | select-string -pattern 'Computer'
$computer = $computer.line.split(">")[1]
$subjectsid = $logon | select-string -Pattern 'SubjectUserSid'
$subjectsid = $subjectsid.line.Split(">")[1]
$subjectuname = $logon | select-string -Pattern 'SubjectUserName'
$subjectuname = $subjectuname.line.Split(">")[1]
$subjectdname = $logon | select-string -Pattern 'SubjectDomainName'
$subjectdname = $subjectdname.Line.Split(">")[1]
$subjectlogonid = $logon | select-string -Pattern 'SubjectLogonId'
$subjectlogonid = $subjectlogonid.line.Split(">")[1]
$targetsid = $logon | select-string -Pattern 'TargetUserSid'
$targetsid = $targetsid.line.Split(">")[1]
$targetuname = $logon | select-string -Pattern 'TargetUserName'
$targetuname = $targetuname.line.Split(">")[1]
$targetdname = $logon | select-string -Pattern 'TargetDomainName'
$targetdname = $targetdname.line.Split(">")[1]
$failurestatus = $logon | select-string -Pattern 'FailureReason'
$failurestatus = $failurestatus.line.Split(">")[1]
if($failurestatus -eq '0XC000005E')
{
$failurecode = '로그온할 서버가 존재하지 않습니다'
$log + " : " + $eventid + " : " + $time + " : " + $computer + " : " + $subjectsid + " : " + $subjectuname + " : " + $subjectdname + " : " + $subjectlogonid + " : " + $targetsid + " : " + $targetuname + " : " + $targetdname + " : " + $null + " : " + $failuecode  | out-file C:\Users\Public\Documents\${env:COMPUTERNAME}_$(get-date -f yyyyMMddhh)_logonoff.txt -Append
}
elseif($failurestatus -eq '0xC0000064')
{
$failurecode = '사용자 이름이 존재하지 않습니다'
$log + " : " + $eventid + " : " + $time + " : " + $computer + " : " + $subjectsid + " : " + $subjectuname + " : " + $subjectdname + " : " + $subjectlogonid + " : " + $targetsid + " : " + $targetuname + " : " + $targetdname + " : " + $null + " : " + $failuecode  | out-file C:\Users\Public\Documents\${env:COMPUTERNAME}_$(get-date -f yyyyMMddhh)_logonoff.txt -Append
}
elseif($failurestatus -eq '0xC000006A')
{
$failurecode = '사용자 암호가 올바르지 않습니다'
$log + " : " + $eventid + " : " + $time + " : " + $computer + " : " + $subjectsid + " : " + $subjectuname + " : " + $subjectdname + " : " + $subjectlogonid + " : " + $targetsid + " : " + $targetuname + " : " + $targetdname + " : " + $null + " : " + $failuecode  | out-file C:\Users\Public\Documents\${env:COMPUTERNAME}_$(get-date -f yyyyMMddhh)_logonoff.txt -Append
}
elseif($failurestatus -eq '0XC000006D')
{
$failurecode = '사용자 이름이나 인증 정보가 잘못되었습니다'
$log + " : " + $eventid + " : " + $time + " : " + $computer + " : " + $subjectsid + " : " + $subjectuname + " : " + $subjectdname + " : " + $subjectlogonid + " : " + $targetsid + " : " + $targetuname + " : " + $targetdname + " : " + $null + " : " + $failuecode  | out-file C:\Users\Public\Documents\${env:COMPUTERNAME}_$(get-date -f yyyyMMddhh)_logonoff.txt -Append
}
elseif($failurestatus -eq '0XC000006E')
{
$failurecode = '사용자 이름이나 암호가 잘못되었습니다'
$log + " : " + $eventid + " : " + $time + " : " + $computer + " : " + $subjectsid + " : " + $subjectuname + " : " + $subjectdname + " : " + $subjectlogonid + " : " + $targetsid + " : " + $targetuname + " : " + $targetdname + " : " + $null + " : " + $failuecode  | out-file C:\Users\Public\Documents\${env:COMPUTERNAME}_$(get-date -f yyyyMMddhh)_logonoff.txt -Append
}
elseif($failurestatus -eq '0xC000006F')
{
$failurecode = '비인가된 시간에 로그온 시도하였습니다'
$log + " : " + $eventid + " : " + $time + " : " + $computer + " : " + $subjectsid + " : " + $subjectuname + " : " + $subjectdname + " : " + $subjectlogonid + " : " + $targetsid + " : " + $targetuname + " : " + $targetdname + " : " + $null + " : " + $failuecode  | out-file C:\Users\Public\Documents\${env:COMPUTERNAME}_$(get-date -f yyyyMMddhh)_logonoff.txt -Append
}
elseif($failurestatus -eq '0xC0000070')
{
$failurecode = '비인가된 워크스테이션에서 로그온 시도하였습니다'
$log + " : " + $eventid + " : " + $time + " : " + $computer + " : " + $subjectsid + " : " + $subjectuname + " : " + $subjectdname + " : " + $subjectlogonid + " : " + $targetsid + " : " + $targetuname + " : " + $targetdname + " : " + $null + " : " + $failuecode  | out-file C:\Users\Public\Documents\${env:COMPUTERNAME}_$(get-date -f yyyyMMddhh)_logonoff.txt -Append
}
elseif($failurestatus -eq '0xC0000071')
{
$failurecode = '만료된 암호로 로그온 시도하였습니다'
$log + " : " + $eventid + " : " + $time + " : " + $computer + " : " + $subjectsid + " : " + $subjectuname + " : " + $subjectdname + " : " + $subjectlogonid + " : " + $targetsid + " : " + $targetuname + " : " + $targetdname + " : " + $null + " : " + $failuecode  | out-file C:\Users\Public\Documents\${env:COMPUTERNAME}_$(get-date -f yyyyMMddhh)_logonoff.txt -Append
}
elseif($failurestatus -eq '0xC0000072')
{
$failurecode = '관리자가 비활성화한 계정으로 로그온 시도하였습니다'
$log + " : " + $eventid + " : " + $time + " : " + $computer + " : " + $subjectsid + " : " + $subjectuname + " : " + $subjectdname + " : " + $subjectlogonid + " : " + $targetsid + " : " + $targetuname + " : " + $targetdname + " : " + $null + " : " + $failuecode  | out-file C:\Users\Public\Documents\${env:COMPUTERNAME}_$(get-date -f yyyyMMddhh)_logonoff.txt -Append
}
elseif($failurestatus -eq '0xC00000DC')
{
$failurecode = 'SAM 서버에 문제가 있습니다'
$log + " : " + $eventid + " : " + $time + " : " + $computer + " : " + $subjectsid + " : " + $subjectuname + " : " + $subjectdname + " : " + $subjectlogonid + " : " + $targetsid + " : " + $targetuname + " : " + $targetdname + " : " + $null + " : " + $failuecode  | out-file C:\Users\Public\Documents\${env:COMPUTERNAME}_$(get-date -f yyyyMMddhh)_logonoff.txt -Append
}
elseif($failurestatus -eq '0xC0000133')
{
$failurecode = '도메인 컨트롤러와 컴퓨터 시간 차이가 너무 큽니다'
$log + " : " + $eventid + " : " + $time + " : " + $computer + " : " + $subjectsid + " : " + $subjectuname + " : " + $subjectdname + " : " + $subjectlogonid + " : " + $targetsid + " : " + $targetuname + " : " + $targetdname + " : " + $null + " : " + $failuecode  | out-file C:\Users\Public\Documents\${env:COMPUTERNAME}_$(get-date -f yyyyMMddhh)_logonoff.txt -Append
}
elseif($failurestatus -eq '0xC000015B')
{
$failurecode = '이 컴퓨터에 사용자가 요청한 로그온 권한이 부여되지 않았습니다'
$log + " : " + $eventid + " : " + $time + " : " + $computer + " : " + $subjectsid + " : " + $subjectuname + " : " + $subjectdname + " : " + $subjectlogonid + " : " + $targetsid + " : " + $targetuname + " : " + $targetdname + " : " + $null + " : " + $failuecode  | out-file C:\Users\Public\Documents\${env:COMPUTERNAME}_$(get-date -f yyyyMMddhh)_logonoff.txt -Append
}
elseif($failurestatus -eq '0xC000018C')
{
$failurecode = '기본 도메인과 신뢰할 수 있는 도메인 사이의 신뢰 관계가 깨졌습니다'
$log + " : " + $eventid + " : " + $time + " : " + $computer + " : " + $subjectsid + " : " + $subjectuname + " : " + $subjectdname + " : " + $subjectlogonid + " : " + $targetsid + " : " + $targetuname + " : " + $targetdname + " : " + $null + " : " + $failuecode  | out-file C:\Users\Public\Documents\${env:COMPUTERNAME}_$(get-date -f yyyyMMddhh)_logonoff.txt -Append
}
elseif($failurestatus -eq '0xC0000192')
{
$failurecode = 'Netlogon 서비스가 시작하지 않았습니다'
$log + " : " + $eventid + " : " + $time + " : " + $computer + " : " + $subjectsid + " : " + $subjectuname + " : " + $subjectdname + " : " + $subjectlogonid + " : " + $targetsid + " : " + $targetuname + " : " + $targetdname + " : " + $null + " : " + $failuecode  | out-file C:\Users\Public\Documents\${env:COMPUTERNAME}_$(get-date -f yyyyMMddhh)_logonoff.txt -Append
}
elseif($failurestatus -eq '0xC0000193')
{
$failurecode = '만료된 계정으로 로그온 시도하였습니다'
$log + " : " + $eventid + " : " + $time + " : " + $computer + " : " + $subjectsid + " : " + $subjectuname + " : " + $subjectdname + " : " + $subjectlogonid + " : " + $targetsid + " : " + $targetuname + " : " + $targetdname + " : " + $null + " : " + $failuecode  | out-file C:\Users\Public\Documents\${env:COMPUTERNAME}_$(get-date -f yyyyMMddhh)_logonoff.txt -Append
}
elseif($failurestatus -eq '0xC0000224')
{
$failurecode = '다음 로그온 시 암호를 변경해야 합니다'
$log + " : " + $eventid + " : " + $time + " : " + $computer + " : " + $subjectsid + " : " + $subjectuname + " : " + $subjectdname + " : " + $subjectlogonid + " : " + $targetsid + " : " + $targetuname + " : " + $targetdname + " : " + $null + " : " + $failuecode  | out-file C:\Users\Public\Documents\${env:COMPUTERNAME}_$(get-date -f yyyyMMddhh)_logonoff.txt -Append
}
elseif($failurestatus -eq '0xC0000225')
{
$failurecode = '윈도우 버그입니다'
$log + " : " + $eventid + " : " + $time + " : " + $computer + " : " + $subjectsid + " : " + $subjectuname + " : " + $subjectdname + " : " + $subjectlogonid + " : " + $targetsid + " : " + $targetuname + " : " + $targetdname + " : " + $null + " : " + $failuecode  | out-file C:\Users\Public\Documents\${env:COMPUTERNAME}_$(get-date -f yyyyMMddhh)_logonoff.txt -Append
}
elseif($failurestatus -eq '0xC0000234')
{
$failurecode = '사용자 계정이 잠긴 상태입니다'
$log + " : " + $eventid + " : " + $time + " : " + $computer + " : " + $subjectsid + " : " + $subjectuname + " : " + $subjectdname + " : " + $subjectlogonid + " : " + $targetsid + " : " + $targetuname + " : " + $targetdname + " : " + $null + " : " + $failuecode  | out-file C:\Users\Public\Documents\${env:COMPUTERNAME}_$(get-date -f yyyyMMddhh)_logonoff.txt -Append
}
elseif($failurestatus -eq '0xC00002EE')
{
$failurecode = '로그온 도중 에러가 발생했습니다'
$log + " : " + $eventid + " : " + $time + " : " + $computer + " : " + $subjectsid + " : " + $subjectuname + " : " + $subjectdname + " : " + $subjectlogonid + " : " + $targetsid + " : " + $targetuname + " : " + $targetdname + " : " + $null + " : " + $failuecode  | out-file C:\Users\Public\Documents\${env:COMPUTERNAME}_$(get-date -f yyyyMMddhh)_logonoff.txt -Append
}
elseif($failurestatus -eq '0xC0000413')
{
$failurecode = '로그온 시도한 컴퓨터가 인증 방화벽에 의해 보호받는 중이므로, 특정 계정은 해당 컴퓨터로 로그온할 수 없습니다'
$log + " : " + $eventid + " : " + $time + " : " + $computer + " : " + $subjectsid + " : " + $subjectuname + " : " + $subjectdname + " : " + $subjectlogonid + " : " + $targetsid + " : " + $targetuname + " : " + $targetdname + " : " + $null + " : " + $failuecode  | out-file C:\Users\Public\Documents\${env:COMPUTERNAME}_$(get-date -f yyyyMMddhh)_logonoff.txt -Append
}
}
}