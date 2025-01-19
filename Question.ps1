# Charger les bibliothèques nécessaires
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName Microsoft.VisualBasic

# Définir la position initiale de la souris
$initialMousePosition = [System.Windows.Forms.Cursor]::Position

# Définir la réponse correcte
$correctAnswer = "Azraël"

# Fonction pour afficher une boîte de saisie utilisateur
function Show-InputBox {
    param (
        [string]$message,
        [string]$title
    )
    return [Microsoft.VisualBasic.Interaction]::InputBox($message, $title, "")
}

# Fonction pour attendre un mouvement de souris
function WaitForMouseMovement {
    Write-Host "Le script attend un mouvement de souris..."
    while ($true) {
        $currentMousePosition = [System.Windows.Forms.Cursor]::Position
        if ($currentMousePosition.X -ne $initialMousePosition.X -or $currentMousePosition.Y -ne $initialMousePosition.Y) {
            Write-Host "Mouvement détecté !"
            return
        }
        Start-Sleep -Milliseconds 100
    }
}

# Attendre un mouvement de souris
WaitForMouseMovement

# Boucle pour demander la bonne réponse
while ($true) {
    $userInput = Show-InputBox -message "Comment se nomme le chat de Gargamel dans les Schtroumphs ?" -title "Question pour un champion"
    if ($userInput -eq $correctAnswer) {
        [System.Windows.Forms.MessageBox]::Show("Reponse correcte !", "Succes", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
        break
    } else {
        [System.Windows.Forms.MessageBox]::Show("Reponse incorrecte. Reessayez !", "Erreur", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
    }
}
