# Téléchargement des fichiers depuis GitHub
$urlImage = "https://github.com/ertvg/h/blob/main/js.png"
$urlSon = "https://github.com/ertvg/h/blob/main/js.wav"

# Chemin de destination des fichiers téléchargés
$cheminImage = "C:\Temp\js.png"
$cheminSon = "C:\Temp\js.wav"

# Téléchargement de l'image
Invoke-WebRequest $urlImage -OutFile $cheminImage
# Téléchargement du son
Invoke-WebRequest $urlSon -OutFile $cheminSon

# Chargement des assemblys nécessaires
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Media

# Fonction pour vérifier le mouvement de la souris
function Check-MouseMovement {
    $lastX = 0
    $lastY = 0

    while ($true) {
        $currentPos = [System.Windows.Forms.Cursor]::Position
        if ($currentPos.X -ne $lastX -or $currentPos.Y -ne $lastY) {
            # Mouvement détecté, exécution des actions
            [System.Media.SystemSounds]::Beep.Play() # Son
            [System.Media.SoundPlayer]::new($cheminSon).PlaySync() # Son personnalisé
            [System.Diagnostics.Process]::Start($cheminImage) # Image
            break
        }
        $lastX = $currentPos.X
        $lastY = $currentPos.Y
        Start-Sleep -Milliseconds 100
    }
}

# Réglage du volume au maximum
[System.Media.SystemSounds]::Beep.Play()
[System.Media.SystemSounds]::Beep.Volume = 100

# Exécution de la fonction
Check-MouseMovement