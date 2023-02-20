#!/bin/bash

#user input 
portal=$(cat main-input)
proxy=$(cat proxy-input)

#providing Hetzner token 
API_TOKEN=nec1YKXMUQhI8nWY1zBfbyDAMoFVlrFeVVtNZt8DF7dETHQEKypp7nDCRs6ObXv0

#getting and modifing the user-data cloud-config

git clone git@github.com:applebrie-github/b-15-m.git
cd b-15-m
rm -rf config.yaml
cp /home/ubuntu/toolbox/cloud-config/config.yaml .
sed -i "s/xportalx/$portal/g" config.yaml
git add --all
git commit -m "integrating server creation"
git push 
sleep 3 

curl -X POST -H "Authorization: Bearer $API_TOKEN" -H "Content-Type: application/json" -d '{"automount":false, "image":"ubuntu-20.04","labels":{},"location":"nbg1","name":"portal.fxglobe.io","public_net":{"enable_ipv4":true,"enable_ipv6":false},"server_type":"cx11","ssh_keys":["b-15-m-pub-key"],"start_after_create":true,"user_data":"#include\nhttps://raw.githubusercontent.com/applebrie-github/b-15-m/main/config.yaml"}' 'https://api.hetzner.cloud/v1/servers' > public-ip




#providing the new server public ip to the user
sleep 3
cat public-ip | grep -A4 ipv4| tail -4 | grep ip |echo "Public IP is " $(sed -e "s/\"ip\": //")


