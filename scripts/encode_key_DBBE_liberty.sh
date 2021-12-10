#!/bin/sh
########################
#Author:Douglas Cardoso#
#run securityUtility encode for WLP liberty servers DBBE#
########################
clear
echo "This script will encode pass for securityUtility encode"
ssh -q wasadmin@rhdbbzulgm1.mid.aib.pri "cat /opt/liberty/keys/key.xml | grep value"
echo "type a value key from key.xml"
read valueKey
echo "key.xml value:"$valueKey""
echo "type new pass to encode"
read  newpasscode
echo "passcode to encode is:"$newpasscode""
ssh -q wasadmin@rhdbbzulgm1.mid.aib.pri "hostname -f ;/opt/liberty/wlp/bin/securityUtility encode --encoding=aes --key=$valueKey $newpasscode; echo "check encrypted passcode and share it with dev team";exit -1"
echo "Script task completed."
