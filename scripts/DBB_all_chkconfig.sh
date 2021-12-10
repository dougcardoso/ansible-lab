#!/bin/bash
echo "########################################################"
echo "# Script to gzip of old files log path for liberty DBB servers #"
echo "# DBB servers Liberty Validations #"
echo "# script path: /home/wasadmin/maintence/scripts/ #"
echo "# script name: gziplogsLiberty.sh #"
echo "# run ./gziplogsLiberty.sh #"
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
echo "Copy script "gziplogsLiberty.sh" to DBB preprod servers..."
for copyhost in $(cat /home/wasadmin/maintence/scripts/properties/DBB-server-list-PREPROD.txt);
do
scp -p gziplogsLiberty.sh wasadmin@$copyhost:/opt/liberty/maintence/scripts/
done
########################################################
echo "Connecting the DBB preprod servers to execute "gziplogsLiberty.sh" script..."
$DBBpreprodServerlist
echo "start execution..."
for host in $(cat /home/wasadmin/maintence/scripts/properties/DBB-server-list-PREPROD.txt);
do
ssh wasadmin@$host "sh /opt/liberty/maintence/scripts/gziplogsLiberty.sh ; hostname -f" > $TEMPscript_path/$host.gziplogsLiberty.log
done
echo "Script done"
