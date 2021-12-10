#!/bin/sh
for host in $(cat /home/wasadmin/maintence/scripts/properties/DBB-server-list-PREPROD.txt);
do
ssh -q wasadmin@$host "hostname -f; find /opt/liberty/ -type f -name "javacore*" -delete; find /opt/liberty/ -type f -name "heapdump*" -delete; df -kh ."
done
echo "script done!"
