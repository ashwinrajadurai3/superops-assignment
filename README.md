# SuperOps-assignment
How to build the environment & the web application altogether
We'll be using terraform to provision the infrastructure & build the application

Pre-requisite:
  AWS Account

Please follow below steps to achieve that 

1. Create an IAM role with read-write access to computing & networking
2. Set programatic access to IAM role & create ACCESS_KEY & SECRET_ACCESS_KEY
3. Create a aws profile in your local to store the creds in /.aws/credentials or export them or pass it as env for terraform during it's execution (of your own choice)
4. Get into web-app folder
5. Do $terraform init to download the required provider plugins
6. Do $terraform plan to review the infrastructure
7. Do $terraform apply to deploy the infrastructure & the web_application
8. Post completion please do curl or copy & paste the output "Application_URL_is _{elb.dns}_" in your web-browser to access the Hello-World application
