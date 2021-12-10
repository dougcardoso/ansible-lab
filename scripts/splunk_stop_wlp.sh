echo "Stop Splunk for DBB servers preprod"
#DBBE preprod server list
sudo rm -f /tmp/splunk_stop_preprod_servers.log
touch /tmp/splunk_stop_preprod_servers.log
sudo chmod -R 755 /tmp/splunk_stop_preprod_servers.log;
for host in $(cat /home/wasadmin/maintence/scripts/properties/DBB-splunk_list.txt);
do
#ssh remote command
ssh -q wasadmin@$host "hostname -f ; sudo /opt/splunk/splunkforwarder/bin/splunk status; date; exit -1" >> /tmp/splunk_stop_preprod_servers.log
echo "script processing... "$host""
done
sh /home/wasadmin/maintence/scripts/splunk_status_wlp.sh > /tmp/splunk_status_preprod_servers.log
cat /tmp/splunk_status_preprod_servers.log >> /tmp/splunk_stop_preprod_servers.log
exit -1
