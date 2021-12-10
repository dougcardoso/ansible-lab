#!/bin/sh
read host
read servicename
echo ""$host""
echo ""$servicename""
ssh wasadmin@$host "for pid in $(ps -ef | awk '/servicename/ {print $2}'); do kill -9 $pid; done"
ssh remotehost "kill -9 \$(ps -aux | grep foo | grep bar | awk '{print \$2}')"
read command1
$command1
echo "script done"

