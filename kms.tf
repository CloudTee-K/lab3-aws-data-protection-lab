resource "aws_kms_key" "lab3_kms_key" {
   description      = "Lab 3 KMS key for data protection"
   deletion_window_in_days  = 7
   enable_key_rotation      = true
}


output  "kms_key_arn" {
  value  = aws_kms_key.lab3_kms_key.arn
}
