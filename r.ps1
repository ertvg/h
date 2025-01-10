[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

function AfficherBoiteDialogue {
    $message = "Voulez-vous continuer ?"
    $titre = "Confirmation"
    $boutons = [System.Windows.Forms.MessageBoxButtons]::YesNo
    $resultat = [System.Windows.Forms.MessageBox]::Show($message, $titre, $boutons)

    if ($resultat -eq [System.Windows.Forms.DialogResult]::Yes) {
        Write-Host "Vous avez cliqué sur Oui"
    } else {
        Write-Host "Vous avez cliqué sur Non"
    }
}

AfficherBoiteDialogue
