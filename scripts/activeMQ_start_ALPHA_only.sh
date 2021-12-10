echo "Change log permissions for activemq"
ssh -q rhdbbdbsalvt1 "sudo chown -R wasadmin:wasusers /opt/ActiveMqPreprodALPHAData/"
ssh -q rhdbbdbsalvt2 "sudo chown -R wasadmin:wasusers /opt/ActiveMqPreprodALPHAData/"
ssh -q rhdbbdbsomvt1 "sudo chown -R wasadmin:wasusers /opt/ActiveMqPreprodOmegaData/"
ssh -q rhdbbdbsomvt2 "sudo chown -R wasadmin:wasusers /opt/ActiveMqPreprodOmegaData/"
echo "activemq start:"
ssh -q rhdbbdbsalvt1 "hostname -f ; /opt/liberty/apache-activemq-5.13.3/bin/activemq start"
ssh -q rhdbbdbsalvt2 "hostname -f ; /opt/liberty/apache-activemq-5.13.3/bin/activemq start"
ssh -q rhdbbdbsomvt1 "hostname -f ; /opt/liberty/apache-activemq-5.13.3/bin/activemq stop"
ssh -q rhdbbdbsomvt2 "hostname -f ; /opt/liberty/apache-activemq-5.13.3/bin/activemq stop"
echo "activemq status:"
ssh -q rhdbbdbsalvt1 "hostname -f ; /opt/liberty/apache-activemq-5.13.3/bin/activemq status"
ssh -q rhdbbdbsalvt2 "hostname -f ; /opt/liberty/apache-activemq-5.13.3/bin/activemq status"
ssh -q rhdbbdbsomvt1 "hostname -f ; /opt/liberty/apache-activemq-5.13.3/bin/activemq status"
ssh -q rhdbbdbsomvt2 "hostname -f ; /opt/liberty/apache-activemq-5.13.3/bin/activemq status"
