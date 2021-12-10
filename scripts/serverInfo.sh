#!/bin/bash
serverinfo="serverinfo.txt"
hostname=`hostname`
touch /home/wasadmin/$hostname.$serverinfo
date >> /home/wasadmin/$hostname.$serverinfo
echo "===============================================" >> /home/wasadmin/$hostname.$serverinfo
hostname >> /home/wasadmin/$hostname.$serverinfo
echo "===============================================" >> /home/wasadmin/$hostname.$serverinfo
uname -a >> /home/wasadmin/$hostname.$serverinfo
echo "===============================================" >> /home/wasadmin/$hostname.$serverinfo
ls -ltr /logs >> /home/wasadmin/$hostname.$serverinfo
echo "===============================================" >> /home/wasadmin/$hostname.$serverinfo
ls -ltr /opt >> /home/wasadmin/$hostname.$serverinfo
echo "===============================================" >> /home/wasadmin/$hostname.$serverinfo
ps -ef | grep httpd >> /home/wasadmin/$hostname.$serverinfo
echo "===============================================" >> /home/wasadmin/$hostname.$serverinfo
ps -ef | grep java >> /home/wasadmin/$hostname.$serverinfo
echo "===============================================" >> /home/wasadmin/$hostname.$serverinfo
service --status-all >> /home/wasadmin/$hostname.$serverinfo
echo "===============================================" >> /home/wasadmin/$hostname.$serverinfo
ifconfig | grep inet >> /home/wasadmin/$hostname.$serverinfo
clear
cat /home/wasadmin/$hostname.$serverinfo
