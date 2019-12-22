#!/bin/bash

. vars.sh
TIMESTAMP=$(date +"%m-%d-%y-%T")
BACKUP_FILE_NAME="benny-wp-backup-$TIMESTAMP.tar.gz"

set -e

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

cd /root

# create backup
$BITNAMI_DIR/ctlscript.sh stop
tar -pczvf $BACKUP_FILE_NAME .
$BITNAMI_DIR/ctlscript.sh stop

# upload backup to S3
aws s3 cp $BACKUP_FILE_NAME s3://$BACKUP_S3_BUCKET

# clean up
rm $BACKUP_FILE_NAME