# Monter le volume au maximum (approche plus robuste)
[System.Media.SystemSounds.Beep].Play()
$audio = New-Object -ComObject "WMPlayer.OCX"
$audio.settings.volume = 100

# Ouvrir une page internet spécifique et la mettre en plein écran
$url = "https://www.exemple.com"
Start-Process -FilePath "chrome.exe" -ArgumentList $url

# Mettre la fenêtre en plein écran (utilisation d'AutoIt avec vérification du titre)
Add-Type -AssemblyName AutoItX3
$autoit = New-Object -ComObject AutoItX3.AutoItX3

# Attendre que Chrome se charge complètement
Start-Sleep -Seconds 2

# Trouver la fenêtre de Chrome et la mettre en plein écran
$title = "Chrome"  # Remplacez par le titre exact de votre fenêtre Chrome
$hwnd = $autoit.WinWaitActive($title)
if ($hwnd) {
    $autoit.WinActivate($hwnd)
    $autoit.Send("{F11}")
} else {
    Write-Warning "Impossible de trouver la fenêtre Chrome."
}
