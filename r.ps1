[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

function CreateDialog($x, $y) {
    $form = New-Object System.Windows.Forms.Form
    $form.StartPosition = "Manual"
    $form.Location = New-Object System.Drawing.Point($x, $y)
    $form.Size = New-Object System.Drawing.Size(200, 100)
    $form.Text = "Boîte de dialogue"

    # Afficher la boîte de dialogue en premier plan et attendre sa fermeture
    $form.Show()
    $form.BringToFront()  # Assure que la fenêtre est au premier plan
    [System.Windows.Forms.Application]::DoEvents()
    [System.Threading.Thread]::Sleep(500)  # Pause pour laisser le temps à l'OS de traiter les événements

    # Boucle d'attente pour la fermeture de la fenêtre
    while ($form.Visible) {
        [System.Threading.Thread]::Sleep(100)
    }
}

# Obtenir la résolution de l'écran
$screen = [System.Windows.Forms.Screen]::PrimaryScreen
$screenWidth = $screen.Bounds.Width
$screenHeight = $screen.Bounds.Height

# Nombre de boîtes de dialogue
$nbDialogues = 10

# Calculer la taille et l'espacement entre les boîtes
$dialogWidth = 200
$dialogHeight = 100
$spacing = 50

# Créer les boîtes de dialogue
for ($i = 0; $i -lt $nbDialogues; $i++) {
    $x = ($i % 5) * ($dialogWidth + $spacing)
    $y = ($i / 5) * ($dialogHeight + $spacing)

    CreateDialog $x $y
}
