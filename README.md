
# LAB 3 – Data Protection & Key Management

## Goal
Protect sensitive data even if infrastructure is compromised by enforcing encryption at rest and in transit.

---

## Build

1. **Encrypted EBS Volumes**  
   - All EC2 storage uses AWS-managed or customer-managed encryption keys.

2. **Encrypted S3 Bucket**  
   - Bucket enforces server-side encryption using AWS KMS keys.

3. **Customer-Managed KMS Keys**  
   - Fine-grained control over access and rotation.

4. **Bucket Policies**  
   - Explicitly deny any unencrypted uploads.
   - Restrict access to only authorized IAM users.

---

## Hands-On

1. Create an encrypted S3 bucket and customer-managed KMS key.  
2. Launch EC2 instance with encrypted EBS volumes.  
3. Attempt uploads:
   - **Encrypted upload** → succeeds  
   - **Unencrypted upload** → fails

4. Rotate KMS keys and verify continued access to encrypted data.

---

## Attacks Prevented

- **Data theft from snapshots** – EBS volume encryption prevents recovery without keys.  
- **Insider access** – IAM policies + KMS enforce least privilege.  
- **Accidental public exposure** – Bucket policy prevents unencrypted uploads.

---

## Validation

```bash
# Upload with encryption
aws s3 cp secret.txt s3://<bucket-name> --sse aws:kms

# Upload without encryption
aws s3 cp secret.txt s3://<bucket-name>
# Result: AccessDenied due to explicit deny in bucket policy


=======
# lab3-aws-data-protection-lab
Hands-on AWS/Terraform lab to enforce encryption and data protection
