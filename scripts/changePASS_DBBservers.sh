#!/bin/sh
echo "########################################################"
echo "# Script to reset password for all DBB servers         #"
echo "# script path: /home/wasadmin/maintence/scripts        #"
echo "# script name: ./changePASS_DBBservers.sh              #"
echo "# run ./changePASS_DBBservers.sh                       #"
echo "# runs with wasadmin user                              #"
echo "# Author: Douglas Cardoso                              #"
echo "# Wipro/AIB - Websphere Team                           #"
echo "# ph: +353 874597272 / douglas.x.cardoso@aib.ie        #"
echo "# 14-11-2018 /ver 1.0                                  #"
echo "########################################################"
########################################################
# CHECK USER WASADMIN RUNNING SCRIPT
if [ $USER != "wasadmin" ]; then
        echo "Script must be run as user: WASADMIN"
        exit -1
fi
########################################################
#VARIABLES
echo "type user that you want reset password"
read user
echo "Script will run passwd for user:"$user""
echo "type your password:"
read userPass
echo "script will change your password for: "$userPass""
########################################################
for host in $(cat /home/wasadmin/maintence/scripts/properties/DBB-server-list-PREPROD.txt);
do
echo "userID: "$user""
echo "Passcode typed: "$userPass""
ssh -q wasadmin@$host "echo ""$host"" ; echo $userPass | sudo passwd --stdin $user; echo "=========================" ;exit -1"
done
echo "Script done!"
