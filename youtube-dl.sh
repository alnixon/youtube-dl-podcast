#!/bin/bash

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

logDate=$(date +%Y%m%d)
feedDate=$(date +%Y%m%d -d "-1 month")
configpath="/var/www/YTDL"
datapath="/var/www/YTDL/data"

# Update yt-dlp
yt-dlp --update >> "$datapath/log-$logDate.log"

# Download and convert files with progress bar for monitoring
yt-dlp --playlist-end 30 --output "$datapath/%(id)s.%(ext)s" --download-archive "$configpath/downloaded.txt" --no-overwrites -f 'bestaudio[ext=m4a]' --write-description --write-info-json --write-thumbnail --dateafter $feedDate -a "$configpath/channels.txt" -v >> "$datapath/log-$logDate.log"

# Remove files older than 60 days
find $datapath/ -mtime +60 -type f -delete >> "$datapath/log-$logDate.log"
