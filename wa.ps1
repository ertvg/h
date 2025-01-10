$imageUrl = "https://raw.githubusercontent.com/ertvg/h/main/yhbh.jpg"

# Créer un dossier temporaire pour stocker l'image
$tempFolder = "$env:USERPROFILE\Pictures\Wallpapers"
New-Item -ItemType Directory -Force -Path $tempFolder | Out-Null

# Chemin local où l'image sera sauvegardée
$imagePath = Join-Path $tempFolder "downloaded_wallpaper.jpg"

try {
    # Téléchargement de l'image avec plus de détails
    Write-Output "Téléchargement de l'image depuis $imageUrl"
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $webClient = New-Object System.Net.WebClient
    $webClient.DownloadFile($imageUrl, $imagePath)
    
    if (Test-Path $imagePath) {
        Write-Output "Image téléchargée avec succès dans: $imagePath"
    } else {
        throw "L'image n'a pas été téléchargée correctement"
    }

    # Définition du fond d'écran avec une méthode alternative
    Write-Output "Configuration du fond d'écran..."
    $setwallpapersrc = @"
    using System.Runtime.InteropServices;
    public class Wallpaper {
        [DllImport("user32.dll", CharSet = CharSet.Auto)]
        public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
    }
"@
    
    Add-Type -TypeDefinition $setwallpapersrc
    
    $SPI_SETDESKWALLPAPER = 0x0014
    $UPDATE_INI_FILE = 0x01
    $SEND_CHANGE = 0x02
    
    $result = [Wallpaper]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $imagePath, ($UPDATE_INI_FILE -bor $SEND_CHANGE))
    
    if ($result) {
        Write-Output "Le fond d'écran a été changé avec succès!"
    } else {
        throw "Échec du changement de fond d'écran. Code de retour: $result"
    }

} catch {
    Write-Error "Une erreur est survenue :`n$($_.Exception.Message)"
    Write-Error "Stack Trace :`n$($_.Exception.StackTrace)"
}
