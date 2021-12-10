#!/bin/sh
########################
#Author:Douglas Cardoso#
#run stop/start/restart for WLP liberty servers DBBE#
########################
clear
cat /home/wasadmin/maintence/scripts/properties/DBB-server-list-PREPROD.txt
echo "type hostname:"
read remotehostname
echo "Generating wlp instance list"
ssh -q wasadmin@$remotehostname "hostname -f ;/opt/liberty/wlp/bin/server list; exit -1" > /tmp/instanceListwlp_dirt.txt
cat /tmp/instanceListwlp_dirt.txt | tail -n +4 > /tmp/instanceListwlp.txt
cat /tmp/instanceListwlp.txt
########################
# ssh -q wasadmin@$remotehostname 'hostname -f ;sh /opt/liberty/wlp/bin/server list; exit -1';
echo "executing command on remote host..."
for instanceListwlp in $(cat /tmp/instanceListwlp.txt); 
	do 
	echo "your options are: remote host:"$remotehostname",liberty instance: "$instanceListwlp", command: stop/start."
	echo "liberty server at remote host:"
		ssh -q wasadmin@$remotehostname "hostname -f ;time /opt/liberty/wlp/bin/server stop $instanceListwlp" &
		sleep 30
		ssh -q wasadmin@$remotehostname "hostname -f ;time /opt/liberty/wlp/bin/server start $instanceListwlp" &
                ssh -q wasadmin@$remotehostname "/opt/liberty/wlp/bin/server status $instanceListwlp"
done
echo "Use Control+C to stop  script"
echo "Script done!"
exit -1
