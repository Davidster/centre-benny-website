#!/bin/bash

set -e

cd "$(dirname "$0")"

. vars.sh
BACKUP_FILE_NAME="benny-wp-backup-$(date +"%y-%m-%d-%H-%M-%S-%Z").tar.gz"

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

echo "|- FULL WORDPRESS BACKUP STARTED -|"
echo "Backup name: $BACKUP_FILE_NAME"

# create backup
$BITNAMI_DIR/ctlscript.sh stop
tar -pczf "$BACKUP_FILE_NAME" $BITNAMI_DIR
$BITNAMI_DIR/ctlscript.sh start

# upload backup to S3
aws s3 cp "$BACKUP_FILE_NAME" s3://$BACKUP_S3_BUCKET --no-progress

# clean up
rm "$BACKUP_FILE_NAME"

echo "|- FULL WORDPRESS BACKUP COMPLETE -|"
echo "End time: $(date +"%y-%m-%d-%H-%M-%S-%Z")"