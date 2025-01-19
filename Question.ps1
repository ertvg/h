Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName Microsoft.VisualBasic

# Définir la position initiale de la souris
$initialMousePosition = [System.Windows.Forms.Cursor]::Position

# Définir la réponse correcte
$correctAnswer = "correct"

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
    $userInput = Show-InputBox -message "Veuillez entrer la bonne réponse :" -title "Vérification"
    if ($userInput -eq $correctAnswer) {
        [System.Windows.Forms.MessageBox]::Show("Réponse correcte !", "Succès", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
        break
    } else {
        [System.Windows.Forms.MessageBox]::Show("Réponse incorrecte. Réessayez !", "Erreur", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
    }
}
