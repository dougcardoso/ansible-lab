#!/bin/bash
for host in $(cat /home/wasadmin/maintence/scripts/properties/DBB-server-list-PREPROD.txt);
        do
        ssh -q wasadmin@$host "hostname -f ; sudo firewall-cmd --reload; sudo firewall-cmd --list-all > /tmp/firewall_rules.txt ; chmod -R 777 /tmp/firewall_rules.txt; ls -ltr /tmp/firewall_rules.txt ; echo "=========================" ;exit -1" & 
done
echo "script done!"
exit -1
