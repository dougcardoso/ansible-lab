#!/bin/bash
echo "########################################################"
echo "# Script to gzip of old files log path for liberty DBB servers #"
echo "# DBB servers Liberty Validations #"
echo "# script path: /opt/liberty/maintence/scripts #"
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
logsLIBERTY="/logs/liberty"
libertyinstanceDIR="/opt/liberty/wlp/usr/servers"
libertyinstanceFILE="libertyServerList.txt"
TEMPscript_path="/tmp/script_temp"
libertyHOSTNAME=`hostname -f`
logsLIBERTYDIRsize=`df /logs | awk '{print $5}' | sed -ne 2p | cut -d"%" -f1`
libertyDIRsize=`df /opt/liberty | awk '{print $5}' | sed -ne 2p | cut -d"%" -f1`
sizeLIMIT="85"
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
# CREATE A liberty INSTANCE LIST
ls $libertyinstanceDIR > $TEMPscript_path/$libertyinstanceFILE
cat $TEMPscript_path/$libertyinstanceFILE | while read libertyInstanceName
do
		echo "Running check "$libertyInstanceName"";
#zip files 05 days old
		mkdir -p $libertyinstanceDIR/$libertyInstanceName/logs/old_gzip_logs
		find $libertyinstanceDIR/$libertyInstanceName/logs/ -name "*.gz" -exec mv {} $libertyinstanceDIR/$libertyInstanceName/logs/old_gzip_logs \;
		find $logsLIBERTY/$libertyInstanceName/logs/ -name "*.gz" -exec mv {} $libertyinstanceDIR/$libertyInstanceName/logs/old_gzip_logs \;
		find $libertyinstanceDIR/$libertyInstanceName/logs/ -mtime +05 -print -exec gzip {} \;
		find $logsLIBERTY/$libertyInstanceName/logs/ -mtime +05 -print -exec gzip {} \;
#delete files more than 30 days		
		find $libertyinstanceDIR/$libertyInstanceName/logs/ -maxdepth 3 -mtime +30 -delete -type f -name '*.tar' -o -name '*.gz'
		find $logsLIBERTY/$libertyInstanceName/logs/ -maxdepth 3 -mtime +30 -delete -type f -name '*.tar' -o -name '*.gz'
		find $libertyinstanceDIR/$libertyInstanceName/logs/old_gzip_logs -maxdepth 3 -mtime +30 -delete -type f -name '*.tar' -o -name '*.gz'
done
########################################################
# Check if disk is FULL
if [ $logsLIBERTYDIRsize -gt $sizeLIMIT ]
then
	echo ""$hostname" THIS SERVER IS 85% DISK FULL, PLEASE CHECK!!!"
	echo ""$logsLIBERTYDIRsize""
	exit -1
fi
if [ $libertyDIRsize -gt $sizeLIMIT ]
then
	echo ""$hostname" THIS SERVER IS 85% DISK FULL, PLEASE CHECK!!!"
	echo ""$libertyDIRsize""
	exit -1
fi
########################################################
# report disk usage
df -kh $logsLIBERTY
df -kh $libertyinstanceDIR
echo "Script done"
