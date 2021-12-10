#!/bin/bash
echo ########################################################
echo # Script to fix log path for liberty DBB servers
echo # DBB servers Liberty Validations
echo # script path: /opt/liberty/scripts
echo # script name: fix_logPath_liberty.sh
echo # run ./fix_logPath_liberty.sh
echo # runs with wasadmin user
echo # Author: Douglas Cardoso
echo # Wipro/AIB - Websphere Team
echo # ph: +353 874597272 / douglas.x.cardoso@aib.ie
echo # 14-11-2018 /ver 1.0
echo ########################################################
## VARIABLES
########################################################
logsLIBERTY="/logs/liberty"
libertyinstanceDIR="/opt/liberty/wlp/usr/servers"
libertyinstanceFILE="libertyServerList.txt"
TEMPscript_path="/tmp/script_temp"
libertyHOSTNAME=`hostname -f`
########################################################
# CHECK USER WASADMIN RUNNING SCRIPT
if [ $USER != "wasadmin" ]; then
        echo "Script must be run as user: WASADMIN"
        exit -1
fi
########################################################
# path and permission for script temp
sudo mkdir -p $TEMPscript_path
sudo chown wasadmin:wasusers $TEMPscript_path
chmod -R 755 $TEMPscript_path
########################################################
# CREATE A liberty INSTANCE LIST
ls $libertyinstanceDIR > $TEMPscript_path/$libertyinstanceFILE
cat $TEMPscript_path/$libertyinstanceFILE | while read libertyInstanceName
do
		echo "Running check "$libertyInstanceName"";
		ln -s $libertyinstanceDIR/$libertyInstanceName $logsLIBERTY/$libertyInstanceName
#symbolic link for logs
		sudo chmod -R 755 $logsLIBERTY/$libertyInstanceName
#zip files 10 days old
		find $libertyinstanceDIR/$libertyInstanceName/logs -mtime +10 -print -exec gzip {} \;
done
echo "Script done"
