[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

function AfficherBoiteDialogue {
    $message = "Es-tu là ?"
    $titre = "Confirmation"
    $boutons = [System.Windows.Forms.MessageBoxButtons]::YesNo

    $resultat = [System.Windows.Forms.MessageBox]::Show($message, $titre, $boutons)

    Write-Host "L'utilisateur a répondu : $resultat"

    switch ($resultat) {
        [System.Windows.Forms.DialogResult]::Yes {
            Write-Host "Affichage de la deuxième boîte de dialogue"
            [System.Windows.Forms.MessageBox]::Show("Super bonne nouvelle !")
        }
        [System.Windows.Forms.DialogResult]::No {
            Write-Host "Affichage de la deuxième boîte de dialogue"
            [System.Windows.Forms.MessageBox]::Show("Dommage...")
        }
    }
}

AfficherBoiteDialogue
