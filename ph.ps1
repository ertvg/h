# Monter le volume au maximum
[System.Media.SystemSounds.Beep].Play() # Simule un bip sonore pour s'assurer que le son fonctionne
$null = New-Object -ComObject "WMPlayer.OCX"
$player.settings.volume = 100

# Ouvrir une page internet spécifique et la mettre en plein écran
$url = "https://fr.pornhub.com/view_video.php?viewkey=676a98e029f49" # Remplacez par l'URL souhaitée
Start-Process -FilePath "chrome.exe" -ArgumentList $url

# Mettre la fenêtre en plein écran (Cette partie peut varier selon le navigateur)
# Pour Chrome, vous pouvez utiliser un raccourci clavier via AutoIt
Add-Type -AssemblyName AutoItX3
$autoit = New-Object -ComObject AutoItX3.AutoItX3
$autoit.WinActivate("Chrome")
$autoit.Send("{F11}") # Appuie sur F11 pour passer en plein écran