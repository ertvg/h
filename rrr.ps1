[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

function AfficherBoiteDialogue {
    $message = "Es-tu là ?"
    $titre = "Confirmation"
    $boutons = [System.Windows.Forms.MessageBoxButtons]::YesNo

    $resultat = [System.Windows.Forms.MessageBox]::Show($message, $titre, $boutons)

    switch ($resultat) {
        [System.Windows.Forms.DialogResult]::Yes {
            [System.Windows.Forms.MessageBox]::Show("Super bonne nouvelle !")
        }
        [System.Windows.Forms.DialogResult]::No {
            [System.Windows.Forms.MessageBox]::Show("Dommage...")
        }
    }
}

AfficherBoiteDialogue