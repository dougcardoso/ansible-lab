#!/bin/bash
for host in $(cat /home/wasadmin/maintence/scripts/properties/DBB-server-list-PREPROD.txt);
        do
        ssh -q wasadmin@$host "hostname -f ; sudo chkconfig --list > /tmp/chkconfig_list.txt ; chmod -R 777 /tmp/chkconfig_list.txt; ls -ltr /tmp/chkconfig_list.txt ; echo "=========================" ;exit -1" &
done
echo "script done!"
