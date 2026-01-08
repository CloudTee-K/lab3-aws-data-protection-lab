
# Create Encrypted S3 Bucket

resource "aws_s3_bucket" "encrypted_bucket" {
   bucket = "lab3-sensitive-data-${random_id.bucket_suffix.hex}"
 
   server_side_encryption_configuration {
     rule  {
       apply_server_side_encryption_by_default {
         sse_algorithm    = "aws:kms"
         kms_master_key_id = aws_kms_key.lab3_kms_key.arn
       }
     }
   }
 }

resource "random_id"  "bucket_suffix" {
   byte_length  = 4
}

output "s3_bucket_name"  {
   value  = aws_s3_bucket.encrypted_bucket.bucket

}

# Enforce Encryption via Bucket Policy

resource "aws_s3_bucket_policy" "encrypted_policy" {
   bucket  = aws_s3_bucket.encrypted_bucket.id

   policy   = jsonencode({
     Version  = "2012-10-17",
     Statement  = [
  {
      
      Sid     = "EnforceKMS",
      Effect  = "Deny",
      Principal = "*",
      Action    = "s3:PutObject",
      Resource  = "${aws_s3_bucket.encrypted_bucket.arn}/*",
      Condition = {
        StringNotEquals = {
           "s3:x-amz-server-side-encryption" = "aws:kms"
         }
       }
     }
   ]
 })
}
