import boto3

print(boto is working)
from botocore.exceptions import NoCredentialsError, ClientError

s3 = boto3.client('s3')

local_file = 'index.html'
bucket_name = 'first-bucket'
s3_file_name = 'index.html'

try:
    s3.upload_file(local_file, bucket_name, s3_file_name)
    print(f"Uploaded {local_file} to s3://{bucket_name}/{s3_file_name}")
except FileNotFoundError:
    print(f"File {local_file} not found")
except NoCredentialsError:
    print("AWS credentials not found or not configured")
except ClientError as e:
    print(f"Error uploading file: {e}")