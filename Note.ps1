$folderPath = "$HOME\Desktop"
$numberOfFiles = 150
$content = "   TROLL   " * 10000

# Créer le dossier si nécessaire
New-Item -ItemType Directory -Path $folderPath -Force

# Créer les fichiers et ajouter le contenu
for ($i = 1; $i -le $numberOfFiles; $i++) {
    $filePath = Join-Path $folderPath ("TROLL $i.txt")
    New-Item -ItemType File -Path $filePath -Force | Set-Content -Value $content
}