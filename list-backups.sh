#!/bin/bash

set -e

cd "$(dirname "$0")"

. vars.sh

aws s3 ls s3://$BACKUP_S3_BUCKET