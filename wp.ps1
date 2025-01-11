# URL de l'image sur GitHub (changez ceci par l'URL de l'image de votre choix)
$imageUrl = "https://raw.githubusercontent.com/USERNAME/REPOSITORY/BRANCH/PATH/TO/IMAGE.jpg"

# Dossier temporaire pour télécharger l'image
$tempImagePath = "$env:TEMP\image.jpg"

# Téléchargement de l'image depuis GitHub
Invoke-WebRequest -Uri $imageUrl -OutFile $tempImagePath

# Vérifier si l'image a bien été téléchargée
if (Test-Path $tempImagePath) {
    Write-Host "Image téléchargée avec succès."

    # Fonction pour changer le fond d'écran
    function Set-Wallpaper {
        param([string]$wallpaperPath)

        # Appel à l'API Windows pour changer le fond d'écran
        Add-Type -TypeDefinition @"
        using System;
        using System.Runtime.InteropServices;
        public class Wallpaper {
            [DllImport("user32.dll", CharSet = CharSet.Auto)]
            public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
        }
"@

        $SPI_SETDESKWALLPAPER = 0x0014
        $SPIF_UPDATEINIFILE = 0x01
        $SPIF_SENDCHANGE = 0x02
        [Wallpaper]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $wallpaperPath, $SPIF_UPDATEINIFILE -bor $SPIF_SENDCHANGE)
    }

    # Changer le fond d'écran avec l'image téléchargée
    Set-Wallpaper -wallpaperPath $tempImagePath