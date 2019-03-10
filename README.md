# youtube-dl-podcast
Scrape audio from youtube and serve as a podcast.
This uses [youtube-dl](https://github.com/rg3/youtube-dl) to the hard work.  The result is then served as a podcast.

## Setup
A subdirectory caled **data** needs to be created with write permission for the user that will run the shell script.

The following files coordinate the downloading of audio
* **youtube-dl.sh**
This needs to be scheduled to run with cron every 24hrs.
Line 44 of this file will need to be changed to your path.
Initially 1 month of files will be downloaded - this can be changed on line 43.
Files will be kept for 60 days - this can be changed on line 50

* **channels.txt**
List the youtube channels to download here, one per line.
* **downloaded.txt**
This is used to track what has already been downloaded.

## Usage
Simply point your podcast client at the location this is hosted at.

## Contributing
I knocked this together *very* quickly for my own needs.  I welcome improvements via pull requests.
