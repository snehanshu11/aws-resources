- users
- groups: Multiple users can be assigend to a group
- roles: can be assigned to any identity (users, group, roles, federated users etc).
- policies: used to authorize an identity

# scenario1 -  Give a user temporary access to S3 buckets in the account
- create a user sxs356
- create a role [ rolename: S3FullAccess, policyname: AmazonS3FullAccess]
- assign an inline permission policy to the user to assume a role
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "sts:AssumeRole",
            "Resource": "arn:aws:iam::590183900117:role/S3FullAccess"
        }
    ]
}
```  
- give programmtic access to user and configure .aws/credentials file
```
aws sts get-caller-identity
{
    "UserId": "AIDAYS2NTUPK2O5QCDGQP",
    "Account": "590183900117",
    "Arn": "arn:aws:iam::590183900117:user/sxs356"
}
```
```
assume_role_output=$(aws sts assume-role --role-arn arn:aws:iam::590183900117:role/S3FullAccess --role-session-name s3-access)
export AWS_ACCESS_KEY_ID=$(echo $assume_role_output | jq -r '.Credentials.AccessKeyId')
export AWS_SECRET_ACCESS_KEY=$(echo $assume_role_output | jq -r '.Credentials.SecretAccessKey')
export AWS_SESSION_TOKEN=$(echo $assume_role_output | jq -r '.Credentials.SessionToken')
aws s3 ls
```

# scenario2 -  Give a user temporary access to S3 buckets in another account
- create user in parent account [590183900117] from where access request needs to be initiated
- create a role in another account[748735308412] where s3 buckets are present [ rolename: 590183900117-s3access, policyname: AmazonS3FullAccess]
- trust policy need to be modified for the above role in [748735308412]. i.e [748735308412] needs to trust account [590183900117]
- assign an inline permission policy to the user in account [590183900117] to assume a role
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "sts:AssumeRole",
            "Resource": "arn:aws:iam::748735308412:role/590183900117-s3access"
        }
    ]
}
```
- give programmtic access to user and configure .aws/credentials file
```
aws sts get-caller-identity
{
    "UserId": "AIDAYS2NTUPK2O5QCDGQP",
    "Account": "590183900117",
    "Arn": "arn:aws:iam::590183900117:user/sxs356"
}
```
```
assume_role_output=$(aws sts assume-role --role-arn arn:aws:iam::748735308412:role/590183900117-s3access --role-session-name s3-access)
export AWS_ACCESS_KEY_ID=$(echo $assume_role_output | jq -r '.Credentials.AccessKeyId')
export AWS_SECRET_ACCESS_KEY=$(echo $assume_role_output | jq -r '.Credentials.SecretAccessKey')
export AWS_SESSION_TOKEN=$(echo $assume_role_output | jq -r '.Credentials.SessionToken')
aws s3 ls
```