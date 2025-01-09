$imagePath = "C:\Temp\lol.jpg" 
Invoke-WebRequest https://github.com/ertvg/h/blob/main/lol.jpg -OutFile $imagePath

Start-Process $imagePath -WindowStyle Maximized