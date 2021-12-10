ssh rhdbbintalvt1.mid.aib.pri "sh /opt/liberty/wlp/bin/server stop paymentsIntegrationServer"; 
ssh rhdbbintalvt2.mid.aib.pri "sh /opt/liberty/wlp/bin/server stop paymentsIntegrationServer";
ssh rhdbbintomvt1.mid.aib.pri "sh /opt/liberty/wlp/bin/server stop paymentsIntegrationServer";
ssh rhdbbintomvt2.mid.aib.pri "sh /opt/liberty/wlp/bin/server stop paymentsIntegrationServer";

ssh rhdbbintalvt1.mid.aib.pri "sh /opt/liberty/wlp/bin/server start paymentsIntegrationServer"; 
ssh rhdbbintalvt2.mid.aib.pri "sh /opt/liberty/wlp/bin/server start paymentsIntegrationServer"; 
ssh rhdbbintomvt1.mid.aib.pri "sh /opt/liberty/wlp/bin/server start paymentsIntegrationServer"; 
ssh rhdbbintomvt2.mid.aib.pri "sh /opt/liberty/wlp/bin/server start paymentsIntegrationServer";
