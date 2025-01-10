[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

$form = New-Object System.Windows.Forms.Form
$form.Text = "Ma boîte de dialogue"
$form.StartPosition = "Manual"
$form.Location = New-Object System.Drawing.Point(0, 0)
$form.Size = New-Object System.Drawing.Size(300, 200)

$label = New-Object System.Windows.Forms.Label
$label.Text = "Ce texte s'affiche dans la boîte de dialogue"
$label.AutoSize = $true
$label.Location = New-Object System.Drawing.Point(10, 10)
$form.Controls.Add($label)

$form.ShowDialog()