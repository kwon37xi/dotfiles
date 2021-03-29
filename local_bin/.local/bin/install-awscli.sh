#!/bin/sh
# https://docs.aws.amazon.com/ko_kr/cli/latest/userguide/install-cliv2-linux.html

rm -f /tmp/awscliv2.zip
rm -rf /tmp/aws

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o /tmp/awscliv2.zip

cd /tmp
unzip awscliv2.zip

if [ -d "/opt/aws-cli" ]
then
    echo "> Updating awscli v2..."
    sudo /tmp/aws/install --install-dir /opt/aws-cli --bin-dir /usr/local/bin  --update
else
    echo "> Installing awscli v2..."
    sudo /tmp/aws/install --install-dir /opt/aws-cli --bin-dir /usr/local/bin
fi
rm -rf /tmp/aws
