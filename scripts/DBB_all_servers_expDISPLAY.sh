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
echo "Install xclock for X11 linux"
	for copyhost in $(cat /home/wasadmin/maintence/scripts/properties/IM_DBB-server-list-PREPROD.txt); do ssh -q wasadmin@$copyhost "hostname -f; echo "Mounting IBM install disks, from 10.33.2.14 at /mnt:" ; sudo mount 10.33.2.14:/carbon/its/InstallationManagerRepositories_8.5 /mnt ; export DISPLAY=10.255.42.227:0.0; /home/wasadmin/IBM/InstallationManager/eclipse/IBMIM" ;done
echo "script done"
