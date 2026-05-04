# This is a Terraform folder and it's sub-directories.

## The main.tf file of this directory will be described below;

### Step 1 : I declared AWS as the cloud provider, specifying the target region along with the access key and secret key credentials (removed the latter for security purpose).
** **
### Step 2 : I created a security group allowing HTTP from anywhere, SSH from one IP, and all outbound traffic.
** **

### Step 2 : Created a t3.micro EC2 instance using Amazon Linux, then attached the defined security group, and runs a startup script that installs, starts, and serves a basic Apache web page.