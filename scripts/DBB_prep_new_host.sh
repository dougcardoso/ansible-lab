#!/bin/bash
echo ###########################################################
echo # Script to validation configurations of liberty servers
echo # DBB servers Liberty Validations
echo # script path: /home/wasadmin/scripts/
echo # script name: liberty_validations.sh
echo # run ./liberty_validations.sh
echo # runs with wasadmin user
echo # Author: Douglas Cardoso
echo # Wipro/AIB - Websphere Team
echo # ph: +353 874597272 / douglas.x.cardoso@aib.ie
echo # 23-10-2018 /ver 1.0
echo ###########################################################
## VARIABLES
########################################################
LIBERTYINSTALL="/opt/liberty/"
wily10_7INST="/opt/liberty/wily10_7/"
keysLIBERTY="/opt/liberty/keys/"
logsLIBERTY="/logs/liberty"
libertyinstanceDIR="/opt/liberty/wlp/usr/servers"
libertyinstanceFILE="libertyServerList.txt"
libertyscriptpath="/opt/liberty/scripts"
#validationscript_path="/opt/liberty/scripts/validationscript_liberty"
TEMPvalidationscript_path="/tmp/validation_script"
libertyHOSTNAME=`hostname -f`
########################################################
# CHECK USER WASADMIN RUNNING SCRIPT
if [ $USER != "wasadmin" ]; then
        echo "Script must be run as user: WASADMIN"
        exit -1
fi
# CLEANING OLD FILES##########################################################
        sudo rm -f $TEMPvalidationscript_path/*.OS.CONFIG.txt
        sudo rm -f $TEMPvalidationscript_path/*.serverxml_serverenv_jvmoptions.txt
        sudo rm -f $TEMPvalidationscript_path/*.OS.CONFIG.txt
        sudo rm -f $TEMPvalidationscript_path/*.serverxml_serverenv_jvmoptions.txt
        sudo rm -f $TEMPvalidationscript_path/$libertyHOSTNAME.OS.CONFIG.txt
#############################################################################
echo "Liberty Validations script started"
        clear
                sudo chmod 777 /tmp
                sudo mkdir -p $TEMPvalidationscript_path
                sudo chmod -R 755 $TEMPvalidationscript_path
                sudo chown -R wasadmin:wasusers $TEMPvalidationscript_path
                sudo touch $TEMPvalidationscript_path/$libertyHOSTNAME.OS.CONFIG.txt
                sudo chown -R wasadmin:wasusers $TEMPvalidationscript_path/$libertyHOSTNAME.OS.CONFIG.txt
                sudo chmod -R 755 $TEMPvalidationscript_path/$libertyHOSTNAME.OS.CONFIG.txt
                echo ""$libertyHOSTNAME"" >> $TEMPvalidationscript_path/$libertyHOSTNAME.OS.CONFIG.txt
                echo "=======================" >> $TEMPvalidationscript_path/$libertyHOSTNAME.OS.CONFIG.txt
                date >> $TEMPvalidationscript_path/$libertyHOSTNAME.OS.CONFIG.txt
        echo "=======================" >> $TEMPvalidationscript_path/$libertyHOSTNAME.OS.CONFIG.txt
##CHECK DIRECTORIES LIBERTYINSTALL##########################################
if [ -d "$LIBERTYINSTALL" ];
	then
		echo "Validation script "$LIBERTYINSTALL" exists -- SUCCESS!"
	else
		echo "Liberty Install directory NOT EXIST! FAILED!!!" 
fi
##CHECK DIRECTORIES wily10INST###############################################
if [ -d "$wily10_7INST" ];
	then
		echo "Validation script  "$wily10_7INST" exists -- SUCCESS!"
	else
		echo "Wily directory NOT EXIST! FAILED!!!" 
fi
##CHECK DIRECTORIES keysLIBERTY#############################################
if [ -d "$keysLIBERTY" ];
	then
		echo "Validation script  "$keysLIBERTY" exists -- SUCCESS!"
			chmod -R 755 $keysLIBERTY
			ls -ltr $keysLIBERTY >> $TEMPvalidationscript_path/$libertyHOSTNAME.OS.CONFIG.txt
		echo "=======================" >> $TEMPvalidationscript_path/$libertyHOSTNAME.OS.CONFIG.txt
	else
		echo "Liberty Keys directory NOT EXIST!FAILED!!!" 
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
##CHECK ULIMIT WASADMIN##########################################################################
		echo "ULIMIT WASADMIN =======================" >> $TEMPvalidationscript_path/$libertyHOSTNAME.OS.CONFIG.txt
if [ "$(ulimit -u)" == "131072" ]; then
        echo "WASADMIN ulimit set to 131072 -- SUCCESS!"
	else
		echo "WASADMIN ulimit not set to 131072 -- FAILED!!!"
fi
			id >> $TEMPvalidationscript_path/$libertyHOSTNAME.OS.CONFIG.txt
			ulimit -u >> $TEMPvalidationscript_path/$libertyHOSTNAME.OS.CONFIG.txt
		echo "END ULIMIT WASADMIN =======================" >> $TEMPvalidationscript_path/$libertyHOSTNAME.OS.CONFIG.txt	
##CHECK ULIMIT SECURITY FILE#####################################################################
		echo "ULIMIT SEC FILE =======================" >> $TEMPvalidationscript_path/$libertyHOSTNAME.OS.CONFIG.txt	
			cat /etc/security/limits.conf >> $TEMPvalidationscript_path/$libertyHOSTNAME.OS.CONFIG.txt	
		echo "END ULIMIT SEC FILE =======================" >> $TEMPvalidationscript_path/$libertyHOSTNAME.OS.CONFIG.txt	
##CHECK FIREWALL#################################################################################
		echo " FIREWALL CONFIG =======================" >> $TEMPvalidationscript_path/$libertyHOSTNAME.OS.CONFIG.txt	
			sudo firewall-cmd --list-all | grep tcp >> $TEMPvalidationscript_path/$libertyHOSTNAME.OS.CONFIG.txt
		echo "END FIREWALL CONFIG =======================" >> $TEMPvalidationscript_path/$libertyHOSTNAME.OS.CONFIG.txt	
##CHECK SSH AND PERMISSION#########################################################################
		echo "SSH KEYS PERMISSIONS =======================" >> $TEMPvalidationscript_path/$libertyHOSTNAME.OS.CONFIG.txt
if [ $(stat -c %a /home/wasadmin/.ssh/authorized_keys) != 600 ]; 
	then
		echo "/home/wasadmin/.ssh/authorized_keys -- PERMISSION FAILED!!!";
		chmod 600 /home/wasadmin/.ssh/authorized_keys
		echo "/home/wasadmin/.ssh/authorized_keys -- PERMISSION CHANGE FOR 600";
		ls -ltr /home/wasadmin/.ssh/authorized_keys
	else
		echo "/home/wasadmin/.ssh/authorized_keys -- PERMISSION SUCCESS!";
fi
			sudo ls -ltr /home/wasadmin/.ssh >> $TEMPvalidationscript_path/$libertyHOSTNAME.OS.CONFIG.txt
		echo "END SSH KEYS PERMISSIONS =======================" >> $TEMPvalidationscript_path/$libertyHOSTNAME.OS.CONFIG.txt	
		echo "AUTH KEYS CONTENT =======================" >> $TEMPvalidationscript_path/$libertyHOSTNAME.OS.CONFIG.txt	
			sudo cat /home/wasadmin/.ssh/authorized_keys >> $TEMPvalidationscript_path/$libertyHOSTNAME.OS.CONFIG.txt
		echo "END AUTH KEYS CONTENT =======================" >> $TEMPvalidationscript_path/$libertyHOSTNAME.OS.CONFIG.txt	
## BUILD INSTANCE FILE#################################################################################
			ls $libertyinstanceDIR > $TEMPvalidationscript_path/$libertyinstanceFILE
			cat $TEMPvalidationscript_path/$libertyinstanceFILE | while read libertyINSTANCEServer
do
		echo "Running check "$libertyINSTANCEServer"";
##SERVICE INSTANCE CHECK###############################################################################
	[ -f /etc/init.d/wlp-$libertyINSTANCEServer ] && echo "wlp-"$libertyINSTANCEServer" Found SUCCESS!" || echo "wlp-"$libertyINSTANCEServer" Not found, FAILED!!!" ;
			ls -ltr /etc/init.d/wlp* | grep wlp
			sudo systemctl enable wlp-$libertyINSTANCEServer;
##CHECK SERVICES##########################################################################################################
		echo "CHECK SERVICES =======================" >> $TEMPvalidationscript_path/$libertyHOSTNAME.OS.CONFIG.txt;
				chkconfig --list | grep wlp >> $TEMPvalidationscript_path/$libertyHOSTNAME.OS.CONFIG.txt;
		echo "END CHECK SERVICES =======================" >> $TEMPvalidationscript_path/$libertyHOSTNAME.OS.CONFIG.txt;
##SERVER.XML PORT VALIDATIONS##########################################################################################################
	[ -f $libertyinstanceDIR/$libertyINSTANCEServer/server.xml ] && echo ""$libertyINSTANCEServer"/server.xml Found SUCCESS!" || echo ""$libertyINSTANCEServer"/server.xml Not found, FAILED!!!" ;
		echo ""$libertyINSTANCEServer" =======================" > $TEMPvalidationscript_path/$libertyINSTANCEServer.serverxml_serverenv_jvmoptions.txt;
		echo ""$libertyINSTANCEServer"" >> $TEMPvalidationscript_path/$libertyINSTANCEServer.serverxml_serverenv_jvmoptions.txt;
		echo "=======================" >> $TEMPvalidationscript_path/$libertyINSTANCEServer.serverxml_serverenv_jvmoptions.txt;
		echo ""$libertyINSTANCEServer" SERVER.XML =======================" >> $TEMPvalidationscript_path/$libertyINSTANCEServer.serverxml_serverenv_jvmoptions.txt;
			cat $libertyinstanceDIR/$libertyINSTANCEServer/server.xml >> $TEMPvalidationscript_path/$libertyINSTANCEServer.serverxml_serverenv_jvmoptions.txt;
		echo ""$libertyINSTANCEServer" END SERVER.XML =======================" >> $TEMPvalidationscript_path/$libertyINSTANCEServer.serverxml_serverenv_jvmoptions.txt;
## CHECK HTTP/HTTPS PORT EXIST IN FIREWALL #######################################################################################
			cat $libertyinstanceDIR/$libertyINSTANCEServer/server.xml |grep "httpPort"| grep -Eo '[0-9]{1,4}'
			cat $libertyinstanceDIR/$libertyINSTANCEServer/server.xml |grep "httpPort"| grep -v "-1"|  grep -Eo '[0-9]{1,4}' | head -n1
			cat $libertyinstanceDIR/$libertyINSTANCEServer/server.xml |grep "httpPort"| grep -v "-1"| grep -Eo '[0-9]{1,4}' | tail -n1
##SERVER.ENV VALIDATIONS##########################################################################################################
	[ -f $libertyinstanceDIR/$libertyINSTANCEServer/server.env ] && echo ""$libertyINSTANCEServer"/server.env Found SUCCESS!" || echo ""$libertyINSTANCEServer"/server.env Not found, FAILED!!!" ;
		echo ""$libertyINSTANCEServer" SERVER.ENV =======================" >> $TEMPvalidationscript_path/$libertyINSTANCEServer.serverxml_serverenv_jvmoptions.txt;
			cat $libertyinstanceDIR/$libertyINSTANCEServer/server.env >> $TEMPvalidationscript_path/$libertyINSTANCEServer.serverxml_serverenv_jvmoptions.txt;
		echo ""$libertyINSTANCEServer" END SERVER.ENV =======================" >> $TEMPvalidationscript_path/$libertyINSTANCEServer.serverxml_serverenv_jvmoptions.txt;
##JVM.OPTIONS VALIDADTIONS##########################################################################################################
	[ -f $libertyinstanceDIR/$libertyINSTANCEServer/jvm.options ] && echo "/"$libertyINSTANCEServer"/jvm.options Found SUCCESS!" || echo "/"$libertyINSTANCEServer"/jvm.options Not found, FAILED!!!" ;
	echo ""$libertyINSTANCEServer" JVM.OPTIONS =======================" >> $TEMPvalidationscript_path/$libertyINSTANCEServer.serverxml_serverenv_jvmoptions.txt;
		cat $libertyinstanceDIR/$libertyINSTANCEServer/jvm.options >> $TEMPvalidationscript_path/$libertyINSTANCEServer.serverxml_serverenv_jvmoptions.txt;
	echo ""$libertyINSTANCEServer" END JVM.OPTIONS =======================" >> $TEMPvalidationscript_path/$libertyINSTANCEServer.serverxml_serverenv_jvmoptions.txt;
##LINK LOG PATH #########################################################################################################################
	ln -s $libertyinstanceDIR/$libertyINSTANCEServer/logs  $logsLIBERTY/$libertyINSTANCEServerLog
done
##CHECK LOG DIRECTORIES INSTANCE##########################################################################################################
cat $libertyinstanceFILE | while read libertyINSTANCEServerLog
do
	if [ -d "$logsLIBERTY"/"$libertyINSTANCEServerLog" ];
		then
			echo "Validation script  "$logsLIBERTY"/"$libertyINSTANCEServerLog" exists -- SUCCESS!" ;
			echo "=======================" >> $libertyINSTANCEServerLog.serverxml_serverenv_jvmoptions.txt;
				sudo chmod 777 /tmp
				sudo cp -p $libertyINSTANCEServerLog.serverxml_serverenv_jvmoptions.txt /tmp ;
				sudo cp -p $TEMPvalidationscript_path/$libertyHOSTNAME.OS.CONFIG.txt /tmp ;
				sudo chmod 600 $libertyINSTANCEServerLog.serverxml_serverenv_jvmoptions.txt ;
				sudo chmod 600 $TEMPvalidationscript_path/$libertyHOSTNAME.OS.CONFIG.txt ;
				mkdir -p $TEMPvalidationscript_path/
				mv /tmp/*.OS.CONFIG.txt $TEMPvalidationscript_path
				mv /tmp/*.serverxml_serverenv_jvmoptions.txt $TEMPvalidationscript_path
		else
			mkdir -p $logsLIBERTY/$libertyINSTANCEServerLog
			echo "Liberty LOG Directory for "$libertyINSTANCEServerLog" CREATED!!!"
	fi
done
			echo "Check log files available in the script path"
				ls -ltr $TEMPvalidationscript_path
			echo "Script end!!!"
