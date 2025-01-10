[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

function AfficherBoiteDialogue($x, $y, $largeur, $hauteur, $titre = "Boîte de dialogue") {
    $form = New-Object System.Windows.Forms.Form
    $form.Text = $titre
    $form.Size = New-Object System.Drawing.Size($largeur, $hauteur)
    $form.StartPosition = "Manual"
    $form.Location = New-Object System.Drawing.Point($x, $y)
    $form.ShowDialog()
}

# Obtenir la résolution de l'écran principal
$screen = [System.Windows.Forms.Screen]::PrimaryScreen
$screenWidth = $screen.Bounds.Width
$screenHeight = $screen.Bounds.Height

# Afficher les boîtes de dialogue à différentes positions
AfficherBoiteDialogue (($screenWidth / 2) - 150, ($screenHeight / 2) - 50, 300, 100, "Boîte au centre")
AfficherBoiteDialogue 0, 0, 200, 100, "Boîte en haut à gauche"
AfficherBoiteDialogue ($screenWidth - 200), $screenHeight - 100, 250, 150, "Boîte en bas à droite"
