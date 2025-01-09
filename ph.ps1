function Pause-Script{
Add-Type -AssemblyName System.Windows.Forms
$originalPOS = [System.Windows.Forms.Cursor]::Position.X
$o=New-Object -ComObject WScript.Shell

    while (1) {
        $pauseTime = 3
        if ([Windows.Forms.Cursor]::Position.X -ne $originalPOS){
            break
        }
        else {
            $o.SendKeys("{CAPSLOCK}");Start-Sleep -Seconds $pauseTime
        }
    }
}
# This turns the volume up to max level
$k=[Math]::Ceiling(100/2);$o=New-Object -ComObject WScript.Shell;for($i = 0;$i -lt $k;$i++){$o.SendKeys([char] 175)}

# Ouvrir une page internet spécifique et la mettre en plein écran
$url = "https://fr.pornhub.com/view_video.php?viewkey=676a98e029f49"
Start-Process -FilePath "chrome.exe" -ArgumentList $url

Add-Type -AssemblyName AutoItX3

$autoit = New-Object -ComObject AutoItX3.AutoItX3
$autoit.Send("{F11}")

# Attendre que Chrome se charge complètement
Start-Sleep -Seconds 2



