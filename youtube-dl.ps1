# Download oldest first
#--playlist-reverse

# Name the files by their title, in data directory
#--o "./data/%(title)s.%(ext)s"

# Maintain a list of downloaded files, don't re-download
#--download-archive downloaded.txt 

# Don't overwrite files
#--no-overwrites

# Convert to audio only
#--extract-audio 

# As mp3
#--audio-format mp3 

# Best audio quality
#--audio-quality 0

# Prefer ffmpeg over avconv for running the postprocessors (default)
#--prefer-ffmpeg

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


$logDate = Get-Date -Format "yyyyMMdd"
$feedDate = Get-Date (Get-Date).AddMonths(-1) -Format "yyyyMMdd"
$path = "C:\\www\YTDL"

if(-not (Test-Path $path/data/log-$logDate.log)){
    New-Item "$path/data/log-$logDate.log" -Force
}

# Download and convert files
youtube-dl --playlist-reverse --o "$path/data/%(id)s.%(ext)s" --download-archive "$path/downloaded.txt" --no-overwrites --extract-audio --audio-format mp3 --audio-quality 0 --prefer-ffmpeg --write-description --write-info-json --write-thumbnail --dateafter $feedDate -a "$path/channels.txt" -v | Out-File "$path/data/log-$logDate.log" -Append

# Remove files older than 60 days
Get-ChildItem –Path "$path/data/" -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-60))} | Remove-Item | Out-File "$path/data/log-$logDate.log" -Append