﻿Copy-Item 'C:\Users\*\AppData\Local\Google\Chrome\User Data\Default\History' -Destination C:\Users\Public\Documents\${env:COMPUTERNAME}_$(get-date -f yyyyMMddhh)_History
