#!/srv/yt/yt.sh

#This script downloads YouTube videos. Inside of /srv/yt/downloads/ ,a folder is created with the title of the video.
#The video is then downloaded into that folder.

TITLE=$(youtube-dl --skip-download --get-title --no-warnings "$1" | sed 2d)

mkdir /srv/yt/downloads/"$TITLE"

youtube-dl -o "/srv/yt/downloads/$TITLE/%(title)s.%(ext)s" "$1" >> /dev/null

mkdir /srv/yt/downloads/"$TITLE"/description

cd /srv/yt/downloads/"$TITLE"/description

youtube-dl --get-description "$1" >> description

echo "Video $1 was downloaded."

echo "File path : /srv/yt/downloads/$TITLE $TITLE.mp4"
