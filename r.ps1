[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

function CreateDialog {
    $form = New-Object System.Windows.Forms.Form
    $form.Text = "Boîte de dialogue"
    $form.Size = New-Object System.Drawing.Size(300, 200)
    $form.StartPosition = "CenterScreen"  # Centre la fenêtre sur l'écran

    # ... (reste du code)

    try
    {
        $form.ShowDialog()
    }
    catch
    {
        Write-Host "Une erreur s'est produite :" $_.Exception.Message
    }
    [System.Threading.Thread]::Sleep(1000)  # Pause de 1 seconde entre chaque fenêtre
}

# Afficher 5 boîtes de dialogue (réduire pour tester)
for ($i = 1; $i -le 5; $i++) {
    CreateDialog
}
