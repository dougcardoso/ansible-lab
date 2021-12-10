echo "Start Splunk for DBB servers preprod"
sudo rm -f /tmp/splunk_start_preprod_servers.log
touch /tmp/splunk_start_preprod_servers.log
sudo chmod -R 755 /tmp/splunk_start_preprod_servers.log;
#server list preprod
for host in $(cat /home/wasadmin/maintence/scripts/properties/DBB-splunk_list.txt);
do
#ssh remote command
ssh -q wasadmin@$host "hostname -f ; sudo chown -R splunk:splunk /opt/splunk; sudo umask 0022; sudo /opt/splunk/splunkforwarder/bin/splunk start; sudo umask 0022; date;exit -1" >> /tmp/splunk_start_preprod_servers.log
echo "script processing... "$host""
done
sh /home/wasadmin/maintence/scripts/splunk_status_wlp.sh > /tmp/splunk_status_preprod_servers.log
cat /tmp/splunk_status_preprod_servers.log >> /tmp/splunk_start_preprod_servers.log
exit -1
