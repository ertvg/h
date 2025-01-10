[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

function AfficherBoiteDialogue($x, $y) {
    $form = New-Object System.Windows.Forms.Form
    $form.Text = "Boîte de dialogue"
    $form.Size = New-Object System.Drawing.Size(300, 100)
    $form.StartPosition = "Manual"
    $form.Location = New-Object System.Drawing.Point($x, $y)
    $form.ShowDialog()
}

# Obtenir la résolution de l'écran
$screen = [System.Windows.Forms.Screen]::PrimaryScreen
$screenWidth = $screen.Bounds.Width
$screenHeight = $screen.Bounds.Height

# Afficher les boîtes de dialogue aux positions souhaitées
AfficherBoiteDialogue (($screenWidth / 2) - 150, ($screenHeight / 2) - 50)  # Centre de l'écran
AfficherBoiteDialogue 0, 0                                                    # Haut gauche
AfficherBoiteDialogue ($screenWidth - 300), $screenHeight - 100              # Bas droit
AfficherBoiteDialogue 0, 0                                                    # Haut droit (encore une fois pour l'exemple)
