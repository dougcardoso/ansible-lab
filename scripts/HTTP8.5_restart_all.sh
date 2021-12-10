#!/bin/sh
echo "########################################################"
echo "# Script to inventary DBB liberty servers #"
echo "# DBB servers #"
echo "# script path: /home/wasadmin/maintence/scripts/ #"
echo "# script name: DBB_all_servers_http_restart.sh #"
echo "# run ./DBB_all_servers_http_restart.sh        #"
echo "# runs with wasadmin user #"
echo "# Author: Douglas Cardoso #"
echo "# Wipro/AIB - Websphere Team #"
echo "# ph: +353 874597272 / douglas.x.cardoso@aib.ie #"
echo "# 10-01-2019 /ver 1.0 #"
echo "########################################################"
## VARIABLES
########################################################
TEMPscript_path="/tmp/script_temp"
DBBpreprodServerlist=`cat /home/wasadmin/maintence/scripts/properties/DBB-server-list-PREPROD.txt`
#DBBprodServerlist=`cat /home/wasadmin/maintence/scripts/properties/DBB-server-list-PROD.txt`
########################################################
# CHECK USER WASADMIN RUNNING SCRIPT
if [ $USER != "wasadmin" ]; then
        echo "Script must be run as user: WASADMIN"
        exit -1
fi
########################################################
sudo mkdir -p $TEMPscript_path
sudo chown wasadmin:wasusers $TEMPscript_path
touch $TEMPscript_path/DBB_HTTP_RESTART_SERVERS.log
chmod -R 755 $TEMPscript_path
truncate -s0 $TEMPscript_path/DBB_HTTP_RESTART_SERVERS.log
########################################################
echo "STARTING HTTPD IHS 8.5 for DBB PREPROD SERVERS..."
for host in $(cat /home/wasadmin/maintence/scripts/properties/DBB-server-list-PREPROD.txt);
do
ssh -q wasadmin@$host "hostname -f ; sudo /opt/liberty/IBMIHS-8.5/bin/apachectl -k stop  -f /opt/liberty/IBMIHS-8.5/conf/httpd.conf; sudo /opt/liberty/IBMIHS-8.5/bin/apachectl -k restart -f /opt/liberty/IBMIHS-8.5/conf/httpd.conf ; ps -ef | grep httpd ; exit -1" 
#>> $TEMPscript_path/DBB_HTTP_RESTART_SERVERS.log
echo "====================================="
done
########################################################
#cat $TEMPscript_path/DBB_INVENTARY_SERVER.log
echo "Log path: "$TEMPscript_path"/DBB_WLP_SERVERS.log"
echo "Script done!"
