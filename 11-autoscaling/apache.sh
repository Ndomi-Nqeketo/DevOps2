#!/bin/bash
# exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
/usr/bin/yum update
# DEBIAN_FRONTEND=noninteractive /usr/bin/yum upgrade -yq
/usr/bin/yum install httpd -y
systemctl start httpd
systemctl enable httpd
# /usr/sbin/ufw allow in "Apache Full"
/bin/echo "Hello world " >/var/www/html/index.html
instance_ip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo $instance_ip >>/var/www/html/index.html

# Installing SSM
cd /tmp
sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
sudo systemctl enable amazon-ssm-agent
sudo systemctl start amazon-ssm-agent