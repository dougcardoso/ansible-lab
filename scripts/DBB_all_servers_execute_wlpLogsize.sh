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
echo "# Script to copy and execute wlpLogsize all DBB Servers #"
echo "# DBB servers Liberty Validations #"
echo "# script path: /home/wasadmin/maintence/scripts/ #"
echo "# script name: wlpLogsize.sh #"
echo "# run ./wlpLogsize.sh #"
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
echo "Copy script "wlpLogsize.sh" to DBB preprod servers..."
for copyhost in $(cat /home/wasadmin/maintence/scripts/properties/DBB-server-list-PREPROD.txt);
do
scp -q -p /home/wasadmin/maintence/scripts/local/wlpLogsize.sh wasadmin@$copyhost:/opt/liberty/maintence/scripts/
done
########################################################
echo "Connecting the DBB preprod servers to execute "wlpLogsize.sh" script..."
$DBBpreprodServerlist
echo "start execution..."
for host in $(cat /home/wasadmin/maintence/scripts/properties/DBB-server-list-PREPROD.txt);
do
echo ""$host""
ssh -q wasadmin@$host "sh /opt/liberty/maintence/scripts/wlpLogsize.sh" 
#ssh wasadmin@$host "sh /opt/liberty/maintence/scripts/wlpLogsize.sh ; hostname -f" > $TEMPscript_path/$host.wlpLogsize.log
done
echo "Script done"
