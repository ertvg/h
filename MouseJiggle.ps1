while ($true) {
    # Génère un délai aléatoire entre 10 et 240 secondes
    $r = Get-Random -Minimum 5 -Maximum 25
    Start-Sleep -Seconds $r

    # Charge l'assembly Windows Forms si nécessaire
    Add-Type -AssemblyName System.Windows.Forms

    # Déplace le curseur aléatoirement 9999 fois
    foreach ($i in 1..9999) {
        $x = Get-Random -Minimum 10 -Maximum 1910
        $y = Get-Random -Minimum 10 -Maximum 1070
        [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($x, $y)
    }
}
