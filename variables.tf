variable "bucket_name" {
  description = "The name of the S3 bucket to create for static website hosting"
  type        = string
}

variable "index_document" {
  description = "The index document for the static website (e.g. index.html)"
  type        = string
  default     = "index.html"
}

variable "error_document" {
  description = "The error document for the static website (e.g. error.html)"
  type        = string
  default     = "error.html"
}

variable "tags" {
  description = "A map of tags to assign to the bucket"
  type        = map(string)
  default     = {}
}

variable "force_destroy" {
  description = "Delete all objects from the bucket so that the bucket can be destroyed without error (use with caution)"
  type        = bool
  default     = false
}

variable "enable_encryption" {
  description = "Enable server-side encryption for the S3 bucket"
  type        = bool
  default     = true
}

variable "block_public_access" {
  description = "Whether to block all public access to the bucket"
  type        = bool
  default     = false
}
