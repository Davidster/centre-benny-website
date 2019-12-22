Management scripts/info for website of Centre Benny

## Initial setup instructions:

- Create Amazon Lighsail instance with Bitnami Wordpress pre-installed
- Create an S3 bucket to hold backups
- Create IAM permissions for the server to access S3 e.g.
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:GetAccessPoint",
                "s3:PutAccountPublicAccessBlock",
                "s3:GetAccountPublicAccessBlock",
                "s3:ListAllMyBuckets",
                "s3:ListAccessPoints",
                "s3:ListJobs",
                "s3:CreateJob",
                "s3:HeadBucket"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::centre-benny-backups",
                "arn:aws:s3:::centre-benny-backups/*"
            ]
        }
    ]
}
```
- Create IAM credentials which grant programmatic access to the above permission
- SSH into the lightsail server and run the following commands:
<!--- ssh keys in ~/.aws/bennyserver.csv -->
```
sudo aws configure # enter IAM keys + region for S3 bucket access
git clone https://github.com/Davidster/centre-benny-website.git
```
- *TODO: instructions for CRON backup script (`0 7 * * MON`)*