#!/bin/sh
for host in $(cat /home/wasadmin/scripts/properties/DBB_new_preprod_servers.txt);
do
sudo yes |scp /home/wasadmin/scripts/local/cpSSHkeyslocal.sh u42288@$host:/home/u42288/
done
