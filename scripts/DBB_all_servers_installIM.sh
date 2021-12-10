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
echo "Clean last IM installation"
	for copyhost in $(cat /home/wasadmin/maintence/scripts/properties/DBB-server-list-PREPROD.txt); do ssh -q wasadmin@$copyhost "hostname -f; sudo rm -rf /data/MIT/IM/; sudo rm -rf /home/wasadmin/IBM/; sudo rm -rf /home/wasadmin/var; sudo rm -rf /home/wasadmin/etc ; sudo mkdir -p /data/MIT/IM/"
	done
echo "Copy IM package"
	for copyhost in $(cat /home/wasadmin/maintence/scripts/properties/DBB-server-list-PREPROD.txt); do scp -p /mnt/InstallationManager-1.8-Linux/agent.installer.linux.gtk.x86_64_1.8.6001.20170428_1156.zip @$copyhost:/tmp;
	done
echo "Unzip and install IM"
	for copyhost in $(cat /home/wasadmin/maintence/scripts/properties/DBB-server-list-PREPROD.txt); do ssh -q wasadmin@$copyhost 'hostname -f; sudo mv /tmp/agent.installer.linux.gtk.x86_64_1.8.6001.20170428_1156.zip /data/MIT/IM; sudo chown -R wasadmin:wasusers /data/MIT/IM; cd /data/MIT/IM/; unzip agent.installer.linux.gtk.x86_64_1.8.6001.20170428_1156.zip; ./userinstc -acceptLicense';
	done
echo "script done"
