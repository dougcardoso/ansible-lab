echo "Status Splunk for DBB servers preprod"
sudo rm -f /logs/scripts/splunk_status_preprod_servers.log
touch /logs/scripts/splunk_status_preprod_servers.log
sudo chmod -R 755 /logs/scripts/splunk_status_preprod_servers.log;
#DBBE preprod server list
for host in $(cat /home/wasadmin/maintence/scripts/properties/DBB-splunk_list.txt);
do
#ssh remote command
ssh -q wasadmin@$host "hostname -f ; sudo /opt/splunk/splunkforwarder/bin/splunk status; date; exit -1" >> /logs/scripts/splunk_status_preprod_servers.log
echo "script processing... "$host""
done
cat /logs/scripts/splunk_status_preprod_servers.log
exit -1
