#!/bin/sh
for host in $(cat /home/wasadmin/maintence/scripts/properties/DBB-server-list-PREPROD.txt);
do
	echo "============================"
	ssh -q wasadmin@$host "mkdir -p /opt/liberty/admin ; exit -1"; 
	ssh -q wasadmin@$host "/opt/liberty/wlp/bin/server list > /opt/liberty/admin/WLP_list0.txt; cat /opt/liberty/admin/WLP_list0.txt | tail -n +3 > /opt/liberty/admin/WLP_list.txt; rm -rf  /opt/liberty/admin/WLP_list0.txt; exit -1";
	ssh -q wasadmin@$host "hostname -f ; cat /opt/liberty/admin/WLP_list.txt ; exit -1";
done
