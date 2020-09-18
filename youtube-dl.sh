#!/bin/bash

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

logDate=$(date +%Y%m%d)
feedDate=$(date +%Y%m%d -d "-1 month")
path="/var/www/YTDL"

# Update youtube-dl
youtube-dl -U

# Download and convert files
youtube-dl --playlist-reverse --o "$path/data/%(id)s.%(ext)s" --download-archive "$path/downloaded.txt" --no-overwrites --extract-audio --audio-format mp3 --audio-quality 0 --prefer-ffmpeg --write-description --write-info-json --write-thumbnail --dateafter $feedDate -a "$path/channels.txt" -v >> "$path/data/log-$logDate.log"

# Remove files older than 60 days
find $path/data/ -mtime +60 -type f -delete >> "$path/data/log-$logDate.log"



