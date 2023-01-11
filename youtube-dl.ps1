# Download only the most recent 30
#--playlist-end 30

# Name the files by their title, in data directory
#--output "./data/%(title)s.%(ext)s"

# Maintain a list of downloaded files, don't re-download
#--download-archive downloaded.txt

# Don't overwrite files
#--no-overwrites

# Format best audio quality
#-f 'bestaudio[ext=m4a]'

# Write video description to a .description file
#--write-description

# Write video metadata to a .info.json file
#--write-info-json

# Write thumbnail image to disk
#--write-thumbnail

# Download only videos uploaded on or after this date (i.e. inclusive) YYYYMMDD
#--dateafter  20190304

# Read list of channels from file
#-a channels.txt

# Add verbose info to the log
#-v

$logDate = Get-Date -Format "yyyyMMdd"
$feedDate = Get-Date (Get-Date).AddMonths(-1) -Format "yyyyMMdd"
$configpath = "C:\\www\YTDL"
$datapath = "C:\\www\YTDL\data"

if(-not (Test-Path $datapath/log-$logDate.log)){
    New-Item "$datapath/log-$logDate.log" -Force
}

# Update youtube-dl
yt-dlp --update | Out-File "$datapath/log-$logDate.log" -Append

# Download and convert files
yt-dlp --playlist-end 30 --output "$datapath/%(id)s.%(ext)s" --download-archive "$configpath/downloaded.txt" --no-overwrites -f 'bestaudio[ext=m4a]' --write-description --write-info-json --write-thumbnail --dateafter $feedDate -a "$configpath/channels.txt" -v | Out-File "$datapath/log-$logDate.log" -Append

# Remove files older than 60 days
Get-ChildItem –Path "$datapath/" -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-60))} | Remove-Item | Out-File "$datapath/log-$logDate.log" -Append
