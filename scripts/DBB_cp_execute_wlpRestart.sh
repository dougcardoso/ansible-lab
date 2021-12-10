#!/bin/sh
echo "########################################################"
echo "# Script to gzip of old files log path for liberty DBB servers #"
echo "# DBB servers Liberty Validations #"
echo "# script path: /home/wasadmin/maintence/scripts/ #"
echo "# script name: wlpRestart.sh #"
echo "# run ./wlpRestart.sh #"
echo "# runs with wasadmin user #"
echo "# Author: Douglas Cardoso #"
echo "# Wipro/AIB - Websphere Team #"
echo "# ph: +353 874597272 / douglas.x.cardoso@aib.ie #"
echo "# 14-11-2018 /ver 1.0 #"
echo "########################################################"
## VARIABLES
########################################################
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
echo "Copy script "wlpRestart.sh" to DBB preprod servers..."
for copyhost in $(cat /home/wasadmin/maintence/scripts/properties/DBB-server-list-PREPROD.txt);
do
scp -p /home/wasadmin/maintence/scripts/local/wlpRestart.sh wasadmin@$copyhost:/opt/liberty/maintence/scripts/
done
########################################################
echo "If you continue now, script will restart all DBB PREPROD servers for DBB, for exit Control+C."
read -p "Continue (y/n)?" answer
if [ "$answer" = "y" ]; then
  echo "Script will continue now.";
else
  echo "Script will exit now";
  exit -1
fi
########################################################
echo "Connecting the DBB preprod servers to execute "wlpRestart.sh" script..."
$DBBpreprodServerlist
echo "start execution..."
for host in $(cat /home/wasadmin/maintence/scripts/properties/DBB-server-list-PREPROD.txt);
do
ssh -q wasadmin@$host "sh /opt/liberty/maintence/scripts/wlpRestart.sh ; hostname -f" > $TEMPscript_path/$host.wlpRestart.log ;
echo "======================================" >> $TEMPscript_path/$host.wlpRestart.log ;
done
echo "Script done"
