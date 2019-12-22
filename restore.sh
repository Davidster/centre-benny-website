#!/bin/bash

. vars.sh

set -e

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

if [ $# -eq 0 ]; then
    echo "No arguments provided"
    echo "Usage: $0 BACKUP_S3_OBJECT_NAME"
    exit 1
fi

BACKUP_FILE_NAME=$1

cd /root

# download backup from S3
aws s3 cp s3://$BACKUP_S3_BUCKET/$BACKUP_FILE_NAME .

# perform restore
$BITNAMI_DIR/ctlscript.sh stop
rm -rf /tmp/bitnami-backup
mv /opt/bitnami /tmp/bitnami-backup
mkdir /opt/bitnami
tar -pxzvf $BACKUP_FILE_NAME -C /opt/bitnami

# clean up
rm $BACKUP_FILE_NAME