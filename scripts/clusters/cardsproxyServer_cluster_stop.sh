ssh -q rhdbbintalvt1.mid.aib.pri "sh /opt/liberty/wlp/bin/server stop cardsproxyServer";
ssh -q rhdbbintalvt2.mid.aib.pri "sh /opt/liberty/wlp/bin/server stop cardsproxyServer";
ssh -q rhdbbintomvt1.mid.aib.pri "sh /opt/liberty/wlp/bin/server stop cardsproxyServer";
ssh -q rhdbbintomvt2.mid.aib.pri "sh /opt/liberty/wlp/bin/server stop cardsproxyServer";
