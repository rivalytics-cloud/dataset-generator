resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  # Optional tags
  tags = var.tags

  # Enable force destroy if specified
  force_destroy = var.force_destroy

  # Enable server-side encryption if requested
  dynamic "server_side_encryption_configuration" {
    for_each = var.enable_encryption ? [1] : []
    content {
      rule {
        apply_server_side_encryption_by_default {
          sse_algorithm = "AES256"
        }
      }
    }
  }

  # Website configuration
  website {
    index_document = var.index_document
    error_document = var.error_document
  }
}

# Block public access unless user says otherwise
resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = var.block_public_access
  block_public_policy     = var.block_public_access
  ignore_public_acls      = var.block_public_access
  restrict_public_buckets = var.block_public_access
}

# Allow public read for static website if NOT blocking public access
resource "aws_s3_bucket_policy" "public_read" {
  count  = var.block_public_access ? 0 : 1
  bucket = aws_s3_bucket.this.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = ["s3:GetObject"]
        Resource  = ["${aws_s3_bucket.this.arn}/*"]
      }
    ]
  })
}
