

#

 # Create Encrypted EBS Volume
resource "aws_ebs_volume"  "encrypted_volume"  {
  availability_zone   = "us-east-1a"
  size    = 10
  encrypted  = true
  kms_key_id   = aws_kms_key.lab3_kms_key.arn
}

output  "ebs_volume_id"  {
   value  = aws_ebs_volume.encrypted_volume.id
}
