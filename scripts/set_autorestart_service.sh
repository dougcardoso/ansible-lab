#!/bin/sh
ls /etc/init.d | grep wlp > /tmp/wlp-list.txt
for wlpservicename in $(cat /tmp/wlp-list.txt);
        do
        sudo systemctl enable $wlpservicename ; hostname -f
        done
echo "script done!" 
