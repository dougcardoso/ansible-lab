#!/bin/sh
echo "########################################################"
echo "# Script to reset password for all DBB servers         #"
echo "# script path: /home/wasadmin/maintence/scripts        #"
echo "# script name: ./DBBalllibertyPermissions.sh           #"
echo "# run ./DBBalllibertyPermissions.sh                    #"
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
for host in $(cat /home/wasadmin/maintence/scripts/properties/DBB-server-list-PREPROD.txt);
do
echo "Change permissions... for /tmp and /opt/liberty/wlp/usr/servers/"
ssh -q wasadmin@$host "sudo chmod 1777 /tmp; chmod -R 755 /opt/liberty/wlp/usr/servers/ ; echo ""$host"" ;  echo "=========================" ;exit -1"
done
echo "Script done!"
