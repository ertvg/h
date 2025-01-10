# Spécifier le chemin de l'image sur GitHub
$urlImage = "https://github.com/ertvg/h/blob/main/yhbh.jpg"
$fichierLocal = "nouveauFondEcran.jpg"

# Télécharger l'image
Invoke-WebRequest -Uri $urlImage -OutFile $fichierLocal

# Définir le chemin vers le répertoire contenant l'image téléchargée
$cheminImage = Get-Location

# Obtenir une collection de tous les écrans
$screens = Get-WmiObject Win32_DesktopMonitor

# Pour chaque écran, définir l'image comme fond d'écran
foreach ($screen in $screens) {
    try {
        # Utiliser la méthode SetWallpaper pour définir le fond d'écran
        $screen.SetWallpaper("$cheminImage\$fichierLocal")
    } catch {
        Write-Warning "Erreur lors de la définition du fond d'écran pour l'écran $($screen.DeviceID): $($_.Exception.Message)"
    }
}
