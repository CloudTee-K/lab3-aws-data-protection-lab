validation.md (LAB 3 – Data Protection & Key Management)

# LAB 3 Validation – Data Protection & Key Management

## Goal
Ensure all sensitive data is encrypted in transit and at rest, and enforce encryption-only policies on S3.

---

## 1. Upload Encrypted File to S3

Command:
```bash
aws s3 cp secret.txt s3://lab3-sensitive-data-46f1462b --sse aws:kms

RESULT:
upload: ./secret.txt to s3://lab3-sensitive-data-46f1462b/secret.txt

Success - file uploaded using KMS-managed encryption.


## 2. Attempt Upload Without Encryption

Command:

aws s3 cp secret.txt s3://lab3-sensitive-data-46f1462b
RESULT :
upload failed: ./secret.txt to s3://lab3-sensitive-data-46f1462b/secret.txt 
An error occurred (AccessDenied) when calling the PutObject operation:
User: arn:aws:iam::129040473895:user/AdminUseruser is not authorized
to perform: s3:PutObject on resource: "arn:aws:s3:::lab3-sensitive-data-46f1462b/secret.txt"
with an explicit deny in a resource-based policy

Failure - unecrypted uploads blocked by bucket policy


## 3 Observations

Enforced KMS encryption ensures data protection at rest.

Explicit deny in bucket policy prevents accidental or malicious unencrypted uploads.

Validates compliance and prevents insider threats or accidental data exposure.



---

### **lessons-learned.md** (LAB 3)

```markdown
# LAB 3 – Lessons Learned

1. **Encryption Enforcement**
   - S3 bucket policies can enforce encryption for all uploaded objects.
   - Any attempt to bypass encryption is automatically denied.

2. **KMS Key Management**
   - Customer-managed KMS keys give fine-grained control over who can access and rotate keys.
   - Rotating KMS keys does not impact already encrypted data, ensuring continuity.

3. **Data Protection**
   - Even if IAM credentials are compromised, bucket policies prevent unencrypted uploads.
   - Encrypted EBS volumes protect data at rest, even if the EC2 instance is compromised.

4. **Compliance and Audit**
   - AWS KMS logs can be used to verify key usage.
   - Ensures audit trails for sensitive data access and encryption enforcement.

5. **Key Takeaway**
   - Combining **S3 bucket policies + KMS encryption** creates strong data protection.
   - Always test by attempting forbidden operations (unencrypted uploads) to validate security controls.

