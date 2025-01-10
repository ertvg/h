[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

function CreateDialog {
    $form = New-Object System.Windows.Forms.Form
    $form.Text = "Boîte de dialogue"
    $form.Size = New-Object System.Drawing.Size(300, 200)
    $form.StartPosition = "CenterScreen"  # Centre la fenêtre sur l'écran

    # Bouton pour fermer la fenêtre
    $closeButton = New-Object System.Windows.Forms.Button
    $closeButton.Text = "Fermer"
    $closeButton.Location = New-Object System.Drawing.Point(100, 150)
    $closeButton.Add_Click({$form.Close()})
    $form.Controls.Add($closeButton)

    $form.ShowDialog()
}

# Afficher 10 boîtes de dialogue
for ($i = 1; $i -le 10; $i++) {
    CreateDialog
}
