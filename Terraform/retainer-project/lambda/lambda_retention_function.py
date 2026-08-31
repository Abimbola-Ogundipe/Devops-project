import boto3
import os

macie = boto3.client("macie2")
s3 = boto3.client("s3")

SOURCE_BUCKET = os.environ["SOURCE_BUCKET"]
QUARANTINE_BUCKET = os.environ["QUARANTINE_BUCKET"]


def lambda_handler(event, context):

    print("Checking Macie findings...")

    response = macie.list_findings()

    finding_ids = response.get("findingIds", [])

    print(f"Found {len(finding_ids)} Macie findings.")

    if not finding_ids:
        return {
            "statusCode": 200,
            "body": "No Macie findings found."
        }

    response = macie.get_findings(
        findingIds=finding_ids
    )

    for finding in response.get("findings", []):

        finding_type = finding.get("type", "")

        if not finding_type.startswith("SensitiveData:S3Object"):
            continue

        resources = finding.get("resourcesAffected", {})

        s3_bucket = resources.get("s3Bucket", {})
        s3_object = resources.get("s3Object", {})

        bucket_name = s3_bucket.get("name")
        object_key = s3_object.get("key")


        print(f"Bucket: {bucket_name}")
        print(f"Object: {object_key}")

        if bucket_name != SOURCE_BUCKET:
            continue

        if not object_key:
            continue

        print(f"Sensitive object found: {object_key}")

        s3.copy_object(
            CopySource={
                "Bucket": SOURCE_BUCKET,
                "Key": object_key
            },
            Bucket=QUARANTINE_BUCKET,
            Key=object_key
        )

        print(
            f"Copied {object_key} "
            f"to quarantine bucket."
        )

    return {
        "statusCode": 200,
        "body": "Macie findings processed."
    }