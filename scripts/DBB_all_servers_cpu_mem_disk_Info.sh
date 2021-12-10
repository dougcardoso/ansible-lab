#!/bin/sh
echo "########################################################"
echo "# Script to inventary DBB liberty servers #"
echo "# DBB servers #"
echo "# script path: /home/wasadmin/maintence/scripts/ #"
echo "# script name: DBB_all_servers_cpu_mem_disk_Info.sh #"
echo "# run ./DBB_all_servers_cpu_mem_disk_Info.sh #"
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
touch $TEMPscript_path/DBB_cpu_mem_disk_info.log
chmod -R 755 $TEMPscript_path
truncate -s0 $TEMPscript_path/DBB_cpu_mem_disk_info.log
########################################################
echo "STARTING CHECK SSH for DBB PREPROD SERVERS..."
for host in $(cat /home/wasadmin/maintence/scripts/properties/DBB-server-list-PREPROD.txt);
do
ssh -q wasadmin@$host "hostname -i ; echo "check cpu process status:" ; sudo mpstat ; echo "check Linux server GB memory:" ; sudo free -mg ; echo "vmstat memory details:"sudo vmstat -s; echo "check disk usage:";  sudo df -kh " >> $TEMPscript_path/DBB_cpu_mem_disk_info.log 
echo "=====================================" >> $TEMPscript_path/DBB_cpu_mem_disk_info.log
echo "script processing... "$host""
done
########################################################
#cat $TEMPscript_path/DBB_INVENTARY_SERVER.log
echo "Log path: "$TEMPscript_path"/DBB_cpu_mem_disk_info.log"
cat $TEMPscript_path/DBB_cpu_mem_disk_info.log
echo "Script done!"
