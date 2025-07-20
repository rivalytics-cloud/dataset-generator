\# S3 Module



This module provisions two S3 buckets used by the dataset generator app:



---



\## 🔹 1. `dataset-generator-files`



\*\*Purpose:\*\*  

Stores all generated dataset files (CSV, JSON, XLSX, etc.) created by the backend Lambda function.



\*\*Contents:\*\*  

\- User-generated datasets organized by request or UUID.

\- Metadata files (optional, for dataset descriptions or logs).



\*\*Configuration \& Behavior:\*\*

\- Public access: \*\*Blocked\*\*

\- Versioning: \*\*Enabled\*\* (optional, recommended if files might be overwritten)

\- Lifecycle Policy: 

&nbsp; - Objects are stored for \*\*30 days\*\*, then transitioned to \*\*Glacier\*\* or \*\*deleted\*\*.

&nbsp; - Designed to manage storage costs for temp files.

\- Access: 

&nbsp; - Write permissions granted to the dataset generation Lambda.

&nbsp; - Read permissions granted to the app when generating a presigned URL.



\*\*Future Considerations:\*\*

\- Add automatic cleanup with lifecycle rules.

\- Add bucket policy to restrict access by IP or user.



---



\## 🔹 2. `dataset-generator-html-app`



\*\*Purpose:\*\*  

Hosts the static frontend website for the dataset generator app.



\*\*Contents:\*\*

\- HTML, CSS, JS files for the app interface.

\- Assets (images, logos, fonts, etc.)



\*\*Configuration \& Behavior:\*\*

\- Static website hosting: \*\*Enabled\*\*

\- Index document: `index.html`

\- Error document: `404.html`

\- Public access: \*\*Allowed\*\* via bucket policy

\- CORS: Configured to allow API calls to backend



\*\*Deployment:\*\*

\- Files are deployed using CI/CD or manual `aws s3 sync`.

\- Should be invalidated if used behind a CloudFront distribution.



---



\## 🛠️ Output Variables (from Terraform)



\- `bucket\_files\_name`

\- `bucket\_html\_name`

\- `bucket\_html\_website\_endpoint`



---



\## 📌 Notes



Each bucket is created with encryption enabled by default (`AES-256`). Tagging is used for resource organization and cost tracking.





