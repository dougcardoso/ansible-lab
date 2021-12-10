#!/bin/sh
########################################################
## VARIABLES
########################################################
TEMPscript_path="/tmp/script_temp"
DBBpreprodServerlist=`cat /home/wasadmin/maintence/scripts/properties/DBB-server-list-PREPROD.txt`
BLACK="\033[30m"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
PINK="\033[35m"
CYAN="\033[36m"
WHITE="\033[37m"
NORMAL="\033[0;39m"
printf $PINK
echo "########################################################"
printf $RED
echo "   #      ###   ######          ######  ######  ######"
echo "  # #      #    #     #         #     # #     # #     #"
echo " #   #     #    #     #         #     # #     # #     #"
echo "#     #    #    ######          #     # ######  ######"
echo "#######    #    #     #         #     # #     # #     #"
echo "#     #    #    #     #         #     # #     # #     #"
echo "#     #   ###   ######          ######  ######  ######"
printf $PINK
echo "########################################################"
printf $WHITE
echo "########################################################"
echo "# Script to copy and execute wlpStatus all DBB Servers #"
echo "# DBB servers Liberty Validations #"
echo "# script path: /home/wasadmin/maintence/scripts/ #"
echo "# script name: wlpStatus.sh #"
echo "# run ./wlpStatus.sh #"
echo "# runs with wasadmin user #"
echo "# Author: Douglas Cardoso #"
echo "# Wipro/AIB - Websphere Team #"
echo "# ph: +353 874597272 / douglas.x.cardoso@aib.ie #"
echo "# 14-11-2018 /ver 1.0 #"
echo "########################################################"
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
echo "Copy script "wlpStatus.sh" to DBB preprod servers..."
for copyhost in $(cat /home/wasadmin/maintence/scripts/properties/DBB-server-list-PREPROD.txt);
do
ssh -q wasadmin@$copyhost "hostname -f ; mkdir -p /opt/liberty/maintence/scripts" 
scp -q -p /home/wasadmin/maintence/scripts/local/dbb_local_inventory_Certs.sh wasadmin@$copyhost:/opt/liberty/maintence/scripts/
done
########################################################
echo "Connecting the DBB preprod servers to execute "wlpStatus.sh" script..."
$DBBpreprodServerlist
echo "start execution..."
for host in $(cat /home/wasadmin/maintence/scripts/properties/DBB-server-list-PREPROD.txt);
do
ssh -q wasadmin@$host "hostname -f ; sh /opt/liberty/maintence/scripts/dbb_local_inventory_Certs.sh" 
#ssh wasadmin@$host "sh /opt/liberty/maintence/scripts/wlpStatus.sh ; hostname -f" > $TEMPscript_path/$host.wlpStatus.log
done
echo "Script done"
