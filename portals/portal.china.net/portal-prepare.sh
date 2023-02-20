portal=$(cat main-input)
proxy=$(cat proxy-input)


#get the code 
git clone --branch production ssh://git-codecommit.eu-central-1.amazonaws.com/v1/repos/V3_Portal
cd V3_Portal
rm -rf .env.local.example next.config.js
cp /home/ubuntu/toolbox/new-portal-tools/.env.local .
cp /home/ubuntu/toolbox/new-portal-tools/next.config.js .
sed -i "s/portal-url/$portal/g" .env.local
sed -i "s/proxy-gateway/$proxy/g" next.config.js



#build the image
cat /home/ubuntu/toolbox/docker-auth/docker-passwd | docker login --username applebrie --password-stdin
sudo docker build -t applebrie/$portal .
docker push applebrie/$portal
