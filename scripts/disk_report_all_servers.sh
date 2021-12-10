#!/bin/bash
for host in $(cat /home/wasadmin/maintence/scripts/properties/DBB-server-list-PREPROD.txt);
        do
        ssh -q wasadmin@$host "hostname -f ; du -kh /opt/liberty | grep -v 0 | grep G > /tmp/liberty_disk_report.log ;sudo chmod -R 755 /tmp/liberty_disk_report.log ; echo "=========================" ; cat /tmp/liberty_disk_report.log ; exit -1"
done
echo "script done!"
