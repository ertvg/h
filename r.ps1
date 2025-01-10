# Spécifie l'URL du fichier audio sur GitHub
$url = "https://github.com/ertvg/h/blob/main/ALRM.wav"

# Spécifie le chemin de destination du fichier téléchargé
$destination = "C:\Temp\ALRM.wav"

# Télécharge le fichier
Invoke-WebRequest -Uri $url -OutFile $destination

Start-Process "C:\Program Files\VideoLAN\VLC\vlc.exe" -ArgumentList $destination --play-and-exit
