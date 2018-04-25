# Download latest release from Github
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$downloadPageUri = 'https://github.com/git-for-windows/git/releases/latest'

# Go to site and identify file, then get it
$content = Invoke-WebRequest -UseBasicParsing -Uri $downloadPageUri
$newest64BitDownloadUri = -join('https://github.com', ($content.links | Where-Object { $_.href -like '*-64-bit.exe' }).href)
$LocalTempDir = $env:TEMP;
$GitInstaller = "InstallGit.exe";
(new-object System.Net.WebClient).DownloadFile($newest64BitDownloadUri, "$LocalTempDir\$GitInstaller");
Start-Process "$($LocalTempDir)\$($GitInstaller)" -Wait -ArgumentList "/VERYSILENT"
$Process2Monitor = 'InstallGit'
Do { $ProcessesFound = Get-Process | ?{$Process2Monitor -contains $_.Name} | Select-Object -ExpandProperty Name; If ($ProcessesFound) { "Still running: $($ProcessesFound -join ', ')" | Write-Host; Start-Sleep -Seconds 2 } else { rm "$LocalTempDir\$GitInstaller" -ErrorAction SilentlyContinue -Verbose } } Until (!$ProcessesFound)