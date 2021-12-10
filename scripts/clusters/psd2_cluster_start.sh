ssh -q rhdbbdbsalvt1.mid.aib.pri "umask 0022; sh /opt/liberty/wlp/bin/server start psd2 --clean";
ssh -q rhdbbdbsalvt2.mid.aib.pri "umask 0022; sh /opt/liberty/wlp/bin/server start psd2 --clean";
ssh -q rhdbbdbsomvt1.mid.aib.pri "umask 0022; sh /opt/liberty/wlp/bin/server start psd2 --clean";
ssh -q rhdbbdbsomvt2.mid.aib.pri "umask 0022; sh /opt/liberty/wlp/bin/server start psd2 --clean";  
