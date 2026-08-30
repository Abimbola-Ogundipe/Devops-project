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

    findings = macie.get_findings(
        findingIds=finding_ids
    )

    for finding in findings.get("findings", []):

        resources = finding.get("resources", [])

        for resource in resources:

            if resource.get("type") != "S3Object":
                continue

            s3_object = resource.get("s3Object", {})

            bucket_name = s3_object.get("bucketName")
            object_key = s3_object.get("key")

            if bucket_name != SOURCE_BUCKET:
                continue

            print(f"Sensitive object found: {object_key}")

            s3.copy_object(
                Bucket=QUARANTINE_BUCKET,
                CopySource={
                    "Bucket": SOURCE_BUCKET,
                    "Key": object_key
                },
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