#!/bin/bash
echo "########################################################"
echo "# Script to gzip of old files log path for liberty DBB servers #"
echo "# DBB servers Liberty Validations #"
echo "# script path: /home/wasadmin/maintence/scripts/ #"
echo "# script name: DBB_all_servers_setAUTOrestartWLP.sh #"
echo "# run ./DBB_all_servers_setAUTOrestartWLP.sh #"
echo "# runs with wasadmin user #"
echo "# Author: Douglas Cardoso #"
echo "# Wipro/AIB - Websphere Team #"
echo "# ph: +353 874597272 / douglas.x.cardoso@aib.ie #"
echo "# 14-11-2018 /ver 1.0 #"
echo "########################################################"
## VARIABLES
########################################################
scriptpath="/home/wasadmin/maintence/scripts/"
TEMPscript_path="/tmp/script_temp"
DBBpreprodServerlist=`cat /home/wasadmin/maintence/scripts/properties/DBB-server-list-PREPROD.txt`
########################################################
# CHECK USER WASADMIN RUNNING SCRIPT
if [ $USER != "wasadmin" ]; then
        echo "Script must be run as user: WASADMIN"
        exit -1
fi
########################################################
sudo mkdir -p $TEMPscript_path
sudo chown wasadmin:wasusers $TEMPscript_path
chmod -R 755 $TEMPscript_path
########################################################
echo "Creating direcotory /opt/liberty/maintence/scripts/ to DBB preprod servers..."
for hostDIR in $(cat /home/wasadmin/maintence/scripts/properties/DBB-server-list-PREPROD.txt);
do
ssh wasadmin@$hostDIR "mkdir -p /opt/liberty/maintence/scripts/"
done
########################################################
echo "Copy script "setAUTOrestartWLP.sh" to DBB preprod servers..."
for copyhost in $(cat /home/wasadmin/maintence/scripts/properties/DBB-server-list-PREPROD.txt);
do
scp -p local/set_autorestart_service.sh wasadmin@$copyhost:/opt/liberty/maintence/scripts/
done
########################################################
echo "############################################"
        read -p "Are you want to proceed with execution of setAUTOrestartWLP for all DBB PREPROD SERVERS? ? if Yes, Press enter to continue, if NO, press Control+C to abort."
echo "############################################"
########################################################
echo "Connecting the DBB preprod servers to execute "setAUTOrestartWLP.sh" script..."
$DBBpreprodServerlist
echo "start execution..."
for host in $(cat /home/wasadmin/maintence/scripts/properties/DBB-server-list-PREPROD.txt);
do
ssh wasadmin@$host "sh /opt/liberty/maintence/scripts/set_autorestart_service.sh ; hostname -f" > $TEMPscript_path/$host.setAUTOrestartWLP.log
done
echo "Script done"
