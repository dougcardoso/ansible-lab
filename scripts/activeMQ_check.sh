echo "Checking active MQ for preprod"
ssh -q rhdbbdbsalvt1 "hostname -f ; echo "check if active MQ exist:" ; ls /opt/liberty/ | grep activemq ; echo "check if activeMQ is running:" ; sudo /opt/liberty/apache-activemq-5.13.3/bin/activemq status" > /tmp/activeMQ_preprod_report.txt
echo "====================================" >> /tmp/activeMQ_preprod_report.txt
ssh -q rhdbbdbsalvt2 "hostname -f ; echo "check if active MQ exist:" ; ls /opt/liberty/ | grep activemq ; echo "check if activeMQ is running:" ; sudo /opt/liberty/apache-activemq-5.13.3/bin/activemq status" >> /tmp/activeMQ_preprod_report.txt
echo "====================================" >> /tmp/activeMQ_preprod_report.txt
ssh -q rhdbbdbsomvt1 "hostname -f ; echo "check if active MQ exist:" ; ls /opt/liberty/ | grep activemq ; echo "check if activeMQ is running:" ; sudo /opt/liberty/apache-activemq-5.13.3/bin/activemq status" >> /tmp/activeMQ_preprod_report.txt
echo "====================================" >> /tmp/activeMQ_preprod_report.txt
ssh -q rhdbbdbsomvt2 "hostname -f ; echo "check if active MQ exist:" ; ls /opt/liberty/ | grep activemq ; echo "check if activeMQ is running:" ; sudo /opt/liberty/apache-activemq-5.13.3/bin/activemq status" >> /tmp/activeMQ_preprod_report.txt
cat /tmp/activeMQ_preprod_report.txt
