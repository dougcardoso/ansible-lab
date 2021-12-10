#!/bin/sh
########################
#Author:Douglas Cardoso#
#run stop/start/restart for WLP liberty servers DBBE#
########################
clear
cat /home/wasadmin/maintence/scripts/properties/DBB-server-list-PREPROD.txt
echo "type hostname:"
read remotehostname
ssh -q wasadmin@$remotehostname "hostname -f ;/opt/liberty/wlp/bin/server list; exit -1"
echo "type liberty instance name without wlp- :"
read wlpinstance
ssh -q wasadmin@$remotehostname "hostname -f ;/opt/liberty/wlp/bin/server status $wlpinstance; exit -1"
echo "type action, start or  stop:"
read actionCMD
########################
echo "your options are: remote host:"$remotehostname",liberty instance: "$wlpinstance", command: "$actionCMD"."
echo "liberty server at remote host:"
# ssh -q wasadmin@$remotehostname 'hostname -f ;sh /opt/liberty/wlp/bin/server list; exit -1';
echo "executing command on remote host..."
ssh -q wasadmin@$remotehostname "hostname -f ;time /opt/liberty/wlp/bin/server $actionCMD $wlpinstance;/opt/liberty/wlp/bin/server status $wlpinstance; exit -1"
echo "Script task completed."
echo "To script exit, please press (Control+C)"
sleep 10
sh /home/wasadmin/maintence/scripts/recycle_DBBE_liberty.sh
