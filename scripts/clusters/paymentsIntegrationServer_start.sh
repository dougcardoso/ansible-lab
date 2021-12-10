ssh -q rhdbbintalvt1.mid.aib.pri "umask 0022; sh /opt/liberty/wlp/bin/server start cardsproxyServer --clean";
ssh -q rhdbbintalvt2.mid.aib.pri "umask 0022; sh /opt/liberty/wlp/bin/server start cardsproxyServer --clean";
ssh -q rhdbbintomvt1.mid.aib.pri "umask 0022; sh /opt/liberty/wlp/bin/server start cardsproxyServer --clean";
ssh -q rhdbbintomvt2.mid.aib.pri "umask 0022; sh /opt/liberty/wlp/bin/server start cardsproxyServer --clean";  
