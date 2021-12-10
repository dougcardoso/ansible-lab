#!/bin/sh
ls /etc/init.d | grep wlp > /tmp/wlp-list.txt
for wlpservicename in $(cat /tmp/wlp-list.txt);
        do
        sudo systemctl enable $wlpservicename ; sudo chown root:root /etc/init.d/$wlpservicename; sudo chmod 755 /etc/init.d/$wlpservicename; hostname -f;
        done
sudo systemctl enable activemq
echo "script done!" 
