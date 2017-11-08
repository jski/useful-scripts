# Download latest release from Github
$downloadPageUri = 'https://github.com/docker/compose/releases/latest'

# Go to site and identify file, then get it
$content = Invoke-WebRequest -UseBasicParsing -Uri $downloadPageUri
$newest64BitDownloadUri = -join('https://github.com', ($content.links | Where-Object { $_.href -like '*Windows-x86_64.exe' }).href)
$LocalDockerDir = "$($env:ProgramFiles)\docker";
(new-object System.Net.WebClient).DownloadFile($newest64BitDownloadUri, "$LocalDockerDir\docker-compose.exe");