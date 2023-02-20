#get user input
#!/bin/bash
# Ask the user for their name
echo Please provide the name of the new portal?
read portal
echo Please provide the name of the proxy gateway?
read proxy


#creating the structure 
mkdir /home/ubuntu/portals/$portal
cd /home/ubuntu/portals/$portal
echo $portal > /home/ubuntu/portals/$portal/main-input
echo $proxy > /home/ubuntu/portals/$portal/proxy-input
cp /home/ubuntu/toolbox/new-portal-tools/portal-prepare.sh .
cp /home/ubuntu/toolbox/new-portal-tools/server-creator.sh .

./portal-prepare.sh
./server-creator.sh


