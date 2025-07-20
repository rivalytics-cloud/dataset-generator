# main.tf

resource "aws_s3_bucket" "html_app" {
  bucket = "dataset-generator-html-app-${var.env}"
  acl    = "public-read"

  website {
    index_document = "landing.html"
    error_document = "error.html"
    
  }

  tags = {
    Name        = "HTML App Bucket"
    Environment = var.env
    Project     = "Dataset Generator"
  }
}

resource "aws_s3_bucket_policy" "html_app_policy" {
  bucket = aws_s3_bucket.html_app.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.html_app.arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_cors_configuration" "html_app_cors" {
  bucket = aws_s3_bucket.html_app.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
    max_age_seconds = 3000
  }
}
