#!/bin/bash
#Website Backup Script
MEDIA='/run/media/gmack/9016-4EF8'
GIT_PROJECT='grantmacken/gmack.nz'
mkdir -p $MEDIA/$GIT_PROJECT
PROJECTS='/home/gmack/projects'
PROJECT=$PROJECTS/$GIT_PROJECT/
#Todays date in ISO-8601 format:
DAY0=$(date -I)
#Yesterdays date in ISO-8601 format:
DAY1=$(date -I -d "1 day ago")
#The target directory:
TARGET="$MEDIA/$GIT_PROJECT/$DAY0"
#The link destination directory:
LINK="$MEDIA/$GIT_PROJECT/$DAY1"
#The rsync options:
OPTIONS="-avh --cvs-exclude --delete --link-dest=$LINK"
#Execute the backup
rsync --archive  --quiet --cvs-exclude --delete --filter=":- .gitignore" --link-dest=$LINK $PROJECT $TARGET
