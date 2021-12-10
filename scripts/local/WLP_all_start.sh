#!/bin/sh
########################
#Author:Douglas Cardoso#
#run stop/start/restart for WLP liberty servers DBBE#
########################
echo "WLP/liberty restart script running..."
/opt/liberty/wlp/bin/server list > /opt/liberty/admin/WLP_list0.txt; cat /opt/liberty/admin/WLP_list0.txt | tail -n +3 > /opt/liberty/admin/WLP_list.txt; rm -rf  /opt/liberty/admin/WLP_list0.txt;
cat /opt/liberty/admin/WLP_list.txt;
for instanceListwlp in $(cat /opt/liberty/admin/WLP_list.txt);
do
time /opt/liberty/wlp/bin/server start $instanceListwlp &;
time /opt/liberty/wlp/bin/server status $instanceListwlp;
done
echo "script done!"
