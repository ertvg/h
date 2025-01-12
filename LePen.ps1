# Monter le volume au maximum
Add-Type -TypeDefinition @"
using System.Runtime.InteropServices;
public class Audio {
    [DllImport("user32.dll")]
    public static extern int SendMessageW(int hWnd, int Msg, int wParam, int lParam);
    public const int HWND_BROADCAST = 0xffff;
    public const int WM_APPCOMMAND = 0x319;
    public const int APPCOMMAND_VOLUME_MAX = 0xa0000;
}
"@
[Audio]::SendMessageW([Audio]::HWND_BROADCAST, [Audio]::WM_APPCOMMAND, 0, [Audio]::APPCOMMAND_VOLUME_MAX)

# Fonction pour détecter un mouvement de la souris
function WaitForMouseMovement {
    $initialMousePosition = [System.Windows.Forms.Cursor]::Position
    while ($true) {
        Start-Sleep -Milliseconds 100
        $currentMousePosition = [System.Windows.Forms.Cursor]::Position
        if ($currentMousePosition.X -ne $initialMousePosition.X -or $currentMousePosition.Y -ne $initialMousePosition.Y) {
            break
        }
    }
}

# Charger l'assemblée pour utiliser les fonctions Windows Forms
Add-Type -AssemblyName System.Windows.Forms

# Attendre un mouvement de souris
Write-Host "En attente d'un mouvement de la souris..."
WaitForMouseMovement
Write-Host "Mouvement de souris détecté."

$imageUrl = "https://raw.githubusercontent.com/ertvg/h/main/marine.jpg"
$soundUrl = "https://raw.githubusercontent.com/ertvg/h/main/blagues.wav"

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