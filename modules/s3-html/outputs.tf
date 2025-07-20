# outputs.tf

output "html_bucket_name" {
  value = aws_s3_bucket.html_app.id
}

output "html_website_url" {
  value = aws_s3_bucket.html_app.website_endpoint
}
