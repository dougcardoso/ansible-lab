#!/bin/sh
########################
#Author:Douglas Cardoso#
#run cluster stop/start/restart for WLP liberty servers DBBE#
########################
clear
echo "cluster wlp script processing, waiting..."
sh /home/wasadmin/maintence/scripts/Gen_WLPlist_all_hosts.sh > /home/wasadmin/maintence/scripts/properties/wlp_list_with_hosts.txt
echo "memory last execution"
cat /tmp/mem_cluster_host_restart_list.txt
echo "wlp service list" 
sort /home/wasadmin/maintence/scripts/properties/wlp_list_with_hosts.txt | uniq | grep -v "rhdbb"
echo "Choose your wlp to start or stop"
cat /home/wasadmin/maintence/scripts/properties/wlp_list_with_hosts.txt | grep $instanceListwlp -B 5
echo "type hostnames, type 1 per line and enter, limit is 4 hosts, if empty, just enter."
echo "type host1"
read remotehostname1
echo "type host2"
read remotehostname2
echo "type host3"
read remotehostname3
echo "type host4"
read remotehostname4
echo $remotehostname1 > /tmp/cluster_host_restart_list.txt
echo $remotehostname2 >> /tmp/cluster_host_restart_list.txt
echo $remotehostname3 >> /tmp/cluster_host_restart_list.txt
echo $remotehostname4 >> /tmp/cluster_host_restart_list.txt
cp -p /tmp/cluster_host_restart_list.txt /tmp/mem_cluster_host_restart_list.txt
echo "Show host cluster member for: "$instanceListwlp":"
echo "Choose your action, start or stop"
read actionCMD
echo "executing command on remote host..."
echo instanceListwlp >> /tmp/mem_cluster_host_restart_list.txt
echo actionCMD >> /tmp/mem_cluster_host_restart_list.txt
for remotehostname in $(cat /tmp/cluster_host_restart_list.txt);
        do
        echo "your options are: remote host:"$remotehostname",liberty instance: "$instanceListwlp", command: "$actionCMD"."
        echo "liberty server at remote host:"
                ssh -q wasadmin@$remotehostname "hostname -f ;time /opt/liberty/wlp/bin/server $actionCMD $instanceListwlp" &
                ssh -q wasadmin@$remotehostname "/opt/liberty/wlp/bin/server status $instanceListwlp"
        echo "Script task completed for host "$remotehostname" wlp "$instanceListwlp"";
done
echo "script done!"
