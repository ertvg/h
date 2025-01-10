# Spécifie l'URL du fichier audio sur GitHub
$url = "https://github.com/ertvg/h/blob/main/ALRM.wav"

# Spécifie le chemin de destination du fichier téléchargé
$destination = "C:\Temp\ALRM.wav"

try {
    # Télécharge le fichier
    Invoke-WebRequest -Uri $url -OutFile $destination

    # Vérifie si le fichier a été téléchargé
    if (Test-Path $destination) {
        Write-Host "Le fichier a été téléchargé avec succès."
        # Ouvre le fichier avec le lecteur multimédia par défaut
        Start-Process $destination
    } else {
        Write-Host "Erreur lors du téléchargement du fichier."
    }
} catch {
    Write-Host "Une erreur s'est produite :" $_.Exception.Message
}
