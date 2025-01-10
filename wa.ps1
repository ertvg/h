$imageUrl = "https://raw.githubusercontent.com/ertvg/h/main/yhbh.jpg"

# Créer un dossier temporaire pour stocker l'image
$tempFolder = "$env:USERPROFILE\Pictures\Wallpapers"
if (-not (Test-Path $tempFolder)) {
    New-Item -ItemType Directory -Path $tempFolder | Out-Null
}

# Chemin local où l'image sera sauvegardée
$imagePath = Join-Path $tempFolder "downloaded_wallpaper.jpg"

try {
    # Téléchargement de l'image
    Write-Output "Téléchargement de l'image..."
    Invoke-WebRequest -Uri $imageUrl -OutFile $imagePath
    
    if (-not (Test-Path $imagePath)) {
        throw "Échec du téléchargement de l'image"
    }

    # Fonction pour définir le fond d'écran
    Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    public class Wallpaper {
        [DllImport("user32.dll", CharSet = CharSet.Auto)]
        public static extern int SystemParametersInfo(
            int uAction,
            int uParam,
            string lpvParam,
            int fuWinIni);
    }
"@

    $SPI_SETDESKWALLPAPER = 0x0014
    $SPIF_UPDATEINIFILE = 0x01
    $SPIF_SENDCHANGE = 0x02

    # Conversion du chemin en chemin absolu
    $absolutePath = [System.IO.Path]::GetFullPath($imagePath)
    
    # Application du fond d'écran
    Write-Output "Application du fond d'écran..."
    $result = [Wallpaper]::SystemParametersInfo(
        $SPI_SETDESKWALLPAPER,
        0,
        $absolutePath,
        $SPIF_UPDATEINIFILE -bor $SPIF_SENDCHANGE
    )