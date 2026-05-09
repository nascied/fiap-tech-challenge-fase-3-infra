resource "aws_s3_bucket" "this" {
  bucket              = "${local.s3_prefix_name}-${var.aws_s3_bucket_name}"
  object_lock_enabled = true

}