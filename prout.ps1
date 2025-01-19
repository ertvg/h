function Set-Volume-Max {
    $o = New-Object -ComObject WScript.Shell
    for ($i = 0; $i -lt 100; $i++) {
        $o.SendKeys([char] 175) # Augmenter le volume
        Start-Sleep -Milliseconds 50 # Petit délai pour garantir que chaque appui est pris en compte
    }
}

# Mettre le volume au maximum
Set-Volume-Max

function Pause-Script {
    Add-Type -AssemblyName System.Windows.Forms

    # Récupérer la position initiale de la souris
    $originalPOS = [System.Windows.Forms.Cursor]::Position

    Write-Host "En attente d'un mouvement de la souris..."
    while ($true) {
        # Récupérer la position actuelle de la souris
        $currentPOS = [System.Windows.Forms.Cursor]::Position

        # Vérifier si la position de la souris a changé
        if ($currentPOS.X -ne $originalPOS.X -or $currentPOS.Y -ne $originalPOS.Y) {
            # Si la souris a bougé, sortir de la boucle
            Write-Host "Mouvement de souris détecté. Continuation du script."
            break
        }
        # Sinon attendre quelques secondes avant de vérifier à nouveau
        Start-Sleep -Seconds 1
    }
}

# Appeler la fonction pour attendre un mouvement de souris
Pause-Script

# Définir les URLs des fichiers sur GitHub
$soundUrl = "https://raw.githubusercontent.com/ertvg/h/blob/main/prout.wav"

# Définir les chemins de téléchargement locaux
$soundPath = "$env:TEMP\sound.wav"

# Télécharger le son
Write-Host "Téléchargement du son..."
Invoke-WebRequest -Uri $soundUrl -OutFile $soundPath

# Jouer le son via wmplayer.exe pour garantir la continuité après la fermeture de PowerShell
Write-Host "Lecture du son via Windows Media Player..."
Start-Process -FilePath "wmplayer.exe" -ArgumentList "$soundPath" -WindowStyle Hidden

