#!/bin/bash
echo ###########################################################
echo # Script to validation configurations of liberty servers
echo # DBB servers Liberty Log link creator
echo # script path: /home/wasadmin/scripts/
echo # script name: liberty_log_link.sh
echo # run ./liberty_log_link.sh
echo # runs with wasadmin user
echo # Author: Douglas Cardoso
echo # Wipro/AIB - Websphere Team
echo # ph: +353 874597272 / douglas.x.cardoso@aib.ie
echo # 07-01-2018 /ver 1.0
echo ###########################################################
## VARIABLES
########################################################
LIBERTYINSTALL="/opt/liberty/"
logsLIBERTY="/logs/liberty"
libertyinstanceDIR="/opt/liberty/wlp/usr/servers"
libertyinstanceFILE="libertyServerList.txt"
libertyscriptpath="/home/wasadmin/maintence/scripts/"
TEMPvalidationscript_path="/tmp/validation_script"
libertyHOSTNAME=`hostname -f`
########################################################
# CHECK USER WASADMIN RUNNING SCRIPT
if [ $USER != "wasadmin" ]; then
        echo "Script must be run as user: WASADMIN"
        exit -1
fi
#############################################################################
echo "Liberty Validations script started"
        clear
                sudo chmod 777 /tmp
                sudo mkdir -p $TEMPvalidationscript_path
                sudo chmod -R 755 $TEMPvalidationscript_path
                sudo chown -R wasadmin:wasusers $TEMPvalidationscript_path
##CHECK DIRECTORIES LIBERTYINSTALL##########################################
if [ -d "$LIBERTYINSTALL" ];
	then
		echo "Validation script "$LIBERTYINSTALL" exists -- SUCCESS!"
	else
		echo "Liberty Install directory NOT EXIST! FAILED!!!" 
fi
##CHECK DIRECTORIES logsLIBERTY#############################################
if [ -d "$logsLIBERTY" ];
	then
		echo "Validation script  "$logsLIBERTY" exists -- SUCCESS!"
	else
		echo "Liberty Logs directory NOT EXIST! FAILED!!!" 
fi
##CHECK DIRECTORIES libertyinstanceDIR##################################
if [ -d "$libertyinstanceDIR" ];
	then
		echo "Validation script  "$libertyinstanceDIR" exists -- SUCCESS!"
			ls -ltr $libertyinstanceDIR >> $TEMPvalidationscript_path/$libertyHOSTNAME.OS.CONFIG.txt
		echo "=======================" >> $TEMPvalidationscript_path/$libertyHOSTNAME.OS.CONFIG.txt	
	else
		echo "Liberty Servers Directory NOT EXIST! FAILED!!!" 
fi
## BUILD INSTANCE FILE#################################################################################
			ls $libertyinstanceDIR > $TEMPvalidationscript_path/$libertyinstanceFILE
			cat $TEMPvalidationscript_path/$libertyinstanceFILE | while read libertyINSTANCEServer
do
		echo "Running check "$libertyINSTANCEServer"";
		unlink $logsLIBERTY/$libertyINSTANCEServer
		unlink $libertyINSTANCEServer
		ln -s $libertyinstanceDIR/$libertyINSTANCEServer/logs $logsLIBERTY/$libertyINSTANCEServer
done
	echo "Check log files available in the script path"
	ls -ltr $logsLIBERTY
	echo "Script end!!!"
