#!/bin/bash
########################################################
clear
echo "###########################################################"
echo "#   DBB server maintence scripts AIB WebSphere Team       #"
echo "###########################################################"
echo "# You can send attached file to AIB email                 #"
echo "# script path: /home/wasadmin/scripts/                    #"
echo "# script name: linuxmailme.sh                             #"
echo "# arguments:                                              #"
echo "# run linuxmailme.sh                                      #"
echo "# execute with wasadmin user                              #"
echo "# Author: Douglas Cardoso                                 #"
echo "# +353 874597272 / douglas.x.cardoso@aib.ie               #"
echo "# 08-11-2018 /version 1.0                                 #"
echo "###########################################################"
########################################################
#VARIABLES
hostname=`hostname`
mailfqdn="aib.ie"
########################################################
echo "This script just send email for AIB domain, ex @aib.ie."
read -p "type email of destination, don't include @aib.ie (ex: jonh@aib.ie, type jonh):" emailIDaib
read -p "type email subject:" mailsubject
read -p "type directory and file for attachment (ex: /tmp/report.txt)" MailattachmentFile
echo "Review your options:"
echo "You will send email for: "$emailIDaib"@"$mailfqdn""
echo "Subject: "$mailsubject""
echo "Attachment: "$MailattachmentFile""
echo "############################################"	
echo "#Confirmation# Do you wish send your email, answer yes or no?"
echo "############################################"	
read input
if [ "$input" == "yes" ]
	then
		sudo sendmail -t $emailIDaib@$mailfqdn -m $mailsubject from $hostname -a $MailattachmentFile
		echo "Email sent!"
	else
		if [ "$input" == "no" ]
		then
			echo "Your aswerd NO, exiting..."
		exit -1
	fi
fi
echo "script done!"
