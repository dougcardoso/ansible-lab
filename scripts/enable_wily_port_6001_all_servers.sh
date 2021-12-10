#!/bin/bash
for host in $(cat /home/wasadmin/maintence/scripts/properties/DBB-server-list-PREPROD.txt);
        do
        ssh -q wasadmin@$host "hostname -f ; sudo firewall-cmd --add-port=6001/tcp --permanent ; sudo firewall-cmd --reload; sudo firewall-cmd --list-all ;exit -1" &
done
sh /home/wasadmin/maintence/scripts/firewall_report_all_servers.sh
echo "script done!"
