#!/bin/bash
########################################################
## VARIABLES
########################################################
BLACK="\033[30m"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
PINK="\033[35m"
CYAN="\033[36m"
WHITE="\033[37m"
NORMAL="\033[0;39m"
libertyinstanceDIR="/opt/liberty/wlp/usr/servers"
libertyinstanceFILE="libertyServerList.txt"
TEMPscript_path="/tmp/temp_script"
hostname=`hostname -f`
timestamp=`date`
########################################################
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
# "# Script for set automatic restart of wlp scripts for DBB servers #"
# "# DBB servers PREPROD #"
# "# script path: /home/wasadmin/maintence/scripts/ #"
# "# script name: wlpStatus.sh #"
# "# run ./wlpStatus.sh #"
# "# runs with wasadmin user #"
# "# Author: Douglas Cardoso #"
# "# Wipro/AIB - Websphere Team #"
# "# ph: +353 874597272 / douglas.x.cardoso@aib.ie #"
# "# 12-12-2018 /ver 1.0 #"
# "########################################################"
printf $NORMAL
########################################################
# CHECK USER WASADMIN RUNNING SCRIPT
if [ $USER != "wasadmin" ]; then
        echo "Script must be run as user: WASADMIN"
        exit -1
fi
########################################################
echo "READING EACH WLP LIBERTY INSTANCE..."
ls $libertyinstanceDIR
########################################################
## BUILD INSTANCE FILE#################################################################################
#amkdir -p $TEMPscript_path
#ls $libertyinstanceDIR > $TEMPscript_path/$libertyinstanceFILE
#cat $TEMPscript_path/$libertyinstanceFILE | while read libertyINSTANCEServer
#do
#	echo "Running check "$libertyINSTANCEServer"";
#		printf $GREEN
#			ps -ef | grep $libertyINSTANCEServer;
#		printf $NORMAL
##SERVICE INSTANCE CHECK###############################################################################
#[ -f /etc/init.d/wlp-$libertyINSTANCEServer ] && echo "wlp-"$libertyINSTANCEServer" Found SUCCESS!" || echo "wlp-"$libertyINSTANCEServer" Not found, FAILED!!!" ;
#	echo "wlp script found:"
#		ls -ltr /etc/init.d/wlp* | grep "wlp";
#	echo " ===>>> STATUS <<<==="
#		printf $GREEN
#		echo "check status "$libertyINSTANCEServer"";
#		sh /opt/liberty/wlp/bin/server status $libertyINSTANCEServer;			
#		printf $NORMAL
#	echo " ===>>> STATUS <<<==="
#done
################################################################################
## BUILD INSTANCE FILE#################################################################################
touch libertyINSTANCEServerRESTART.txt
#	ls /opt/liberty/wlp/usr/servers > libertyinstanceFILE.txt ;
	/opt/liberty/wlp/bin/server list | tail -n+3 > libertyinstanceFILE.txt
	cat libertyinstanceFILE.txt | while read libertyINSTANCEServer
do
#echo "check status "$libertyINSTANCEServer"";
	/opt/liberty/wlp/bin/server status $libertyINSTANCEServer | grep "running with process ID"  | awk '{print $2}' >> libertyINSTANCEServerRESTART.uniq.txt;
done
## BUILD INSTANCE FILE TO RESTART#################################################################################
sort libertyINSTANCEServerRESTART.uniq.txt | uniq > libertyINSTANCEServerRESTART.txt;
cat libertyINSTANCEServerRESTART.txt | while read libertyINSTANCEServerRESTART;
do
	echo "wlp status running:";
		/opt/liberty/wlp/bin/server status $libertyINSTANCEServerRESTART | grep "running with process ID"  | awk '{print $2}';
	echo "restart wlp stopping... "$libertyINSTANCEServerRESTART"";
		/opt/liberty/wlp/bin/server stop $libertyINSTANCEServerRESTART;
	echo "======================="
done
printf $NORMAL
##CHECK SERVICES##########################################################################################################
## BUILD INSTANCE FILE TO RESTART#################################################################################
sort libertyINSTANCEServerRESTART.uniq.txt | uniq > libertyINSTANCEServerRESTART.txt;
cat libertyINSTANCEServerRESTART.txt | while read libertyINSTANCEServerRESTART;
do
	echo "wlp starting...";
		/opt/liberty/wlp/bin/server start $libertyINSTANCEServerRESTART;
        echo "wlp status running:";
                /opt/liberty/wlp/bin/server status $libertyINSTANCEServerRESTART | grep "running with process ID"  | awk '{print $2}';
        echo "======================="
done
printf $NORMAL
echo ""$hostname" at "$date""
echo "Script done!"
