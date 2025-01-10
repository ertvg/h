[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

function AfficherBoiteDialogue {
    $message = "Voulez-vous continuer ?"
    $titre = "Confirmation"
    $boutons = [System.Windows.Forms.MessageBoxButtons]::YesNo

    # Afficher la boîte de dialogue et stocker le résultat
    $resultat = [System.Windows.Forms.MessageBox]::Show($message, $titre, $boutons)

    # Actions en fonction du résultat
    switch ($resultat) {
        [System.Windows.Forms.DialogResult]::Yes {
            Write-Host "Vous avez cliqué sur Oui"
            # Ajoutez ici les actions à effectuer si l'utilisateur clique sur Oui
        }
        [System.Windows.Forms.DialogResult]::No {
            Write-Host "Vous avez cliqué sur Non"
            # Ajoutez ici les actions à effectuer si l'utilisateur clique sur Non
        }
    }
}

# Appeler la fonction pour afficher la boîte de dialogue
AfficherBoiteDialogue
