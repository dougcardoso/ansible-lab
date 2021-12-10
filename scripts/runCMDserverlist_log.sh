#!/bin/bash
########################################################
clear
echo "###########################################################"
echo "#   DBB server maintence scripts AIB WebSphere Team       #"
echo "###########################################################"
echo "# Script to run commands into DBB servers                 #"
echo "# script path: /home/wasadmin/scripts/                    #"
echo "# script name: runCMDserverlist.sh                        #"
echo "# arguments:                                              #"
echo "# run runCMDserverlist.sh                                 #"
echo "# execute with wasadmin user                              #"
echo "# Author: Douglas Cardoso                                 #"
echo "# +353 874597272 / douglas.x.cardoso@aib.ie               #"
echo "# 08-11-2018 /version 1.0                                 #"
echo "###########################################################"
########################################################
#VARIABLES
properDIR="/home/wasadmin/scripts/properties"
resultDir="/tmp/results"
outputFILE="resultrunCMDlog.txt"
#PRODserverlistfile="DBB-server-list-PROD"
PREPRODserverlistfile="DBB-server-list-PREPROD.txt"
########################################################
mkdir -p $properDIR
mkdir -p $resultDir
sudo chmod -R 755 $properDIR
sudo chmod -R 755 $resultDir
########################################################
echo "############################################"
echo "THIS IS PREPRODUCTION SERVER ALPHA AND OMEGA DBB SERVERS"
echo "THIS COMMAND WILL RUN FOR THIS SERVER LIST"
echo "############################################"
#echo "rhdbbwebgm1.mid.aib.pri" >> $properDIR/$PREPRODserverlistfile
#echo "rhdbbwebgm2.mid.aib.pri" >> $properDIR/$PREPRODserverlistfile
echo "rhdbbzulgm1.mid.aib.pri" > $properDIR/$PREPRODserverlistfile
echo "rhdbbdbsomvt1.mid.aib.pri" >> $properDIR/$PREPRODserverlistfile
echo "rhdbbcxpgm1.mid.aib.pri" >> $properDIR/$PREPRODserverlistfile
echo "rhdbbauthgm1.mid.aib.pri" >> $properDIR/$PREPRODserverlistfile
echo "rhdbbzulgm2.mid.aib.pri" >> $properDIR/$PREPRODserverlistfile
echo "rhdbbdbsalvt1.mid.aib.pri" >> $properDIR/$PREPRODserverlistfile
echo "rhdbbcxpgm2.mid.aib.pri" >> $properDIR/$PREPRODserverlistfile
echo "rhdbbauthgm2.mid.aib.pri" >> $properDIR/$PREPRODserverlistfile
echo "rhdbbintalvt1.mid.aib.pri" >> $properDIR/$PREPRODserverlistfile
echo "rhdbbintomvt1.mid.aib.pri" >> $properDIR/$PREPRODserverlistfile
#echo "rhdbbspringavt1.mid.aib.pri" >> $properDIR/$PREPRODserverlistfile
#echo "rhdbbspringovt1.mid.aib.pri" >> $properDIR/$PREPRODserverlistfile
echo "rhdbbbisalvt2.mid.aib.pri" >> $properDIR/$PREPRODserverlistfile
echo "rhdbbbisomvt2.mid.aib.pri" >> $properDIR/$PREPRODserverlistfile
echo "rhdbbbisalvt1.mid.aib.pri" >> $properDIR/$PREPRODserverlistfile
echo "rhdbbbisomvt1.mid.aib.pri" >> $properDIR/$PREPRODserverlistfile
echo "rhdbbpdsomvt1.mid.aib.pri" >> $properDIR/$PREPRODserverlistfile
echo "rhdbbpdsalvt1.mid.aib.pri" >> $properDIR/$PREPRODserverlistfile
echo "rhdbbentomvt1.mid.aib.pri" >> $properDIR/$PREPRODserverlistfile
echo "rhdbbentalvt1.mid.aib.pri" >> $properDIR/$PREPRODserverlistfile
echo "rhdbbexpalvt1.mid.aib.pri" >> $properDIR/$PREPRODserverlistfile
echo "rhdbbexpomvt1.mid.aib.pri" >> $properDIR/$PREPRODserverlistfile
	cat $properDIR/$PREPRODserverlistfile
echo "############################################"
echo "TYPE YOUR USERID"
echo "############################################"	
	read userID
## command validations ##
if [ "$userID" = "" ]; then
    echo "FAILED: You need to type an user able to run commands to servers."
	echo "############################################"
	echo "TYPE YOUR USERID"
	echo "############################################"		
	read userID
fi	
echo "USERID select: "$userID""
echo "############################################"	
echo "BEWARE ABOUT YOUR COMMAND, PLEASE TYPE WITH CARE!!!"
echo "############################################"	
	read commandRUN
## command validations ##
if [ "$commandRUN" = "" ]; then
    echo "FAILED: You need to type one command or script will exit."
	echo "############################################"	
	echo "BEWARE ABOUT YOUR COMMAND, PLEASE TYPE WITH CARE!!!"
	echo "############################################"	
	read commandRUN
fi
## command validations ##
if [ "$commandRUN" = "rm -rf" ]; then
    echo "FAILED: This script not accept commands for remove files or directories"
	exit
fi
## command validations ##
if [ "$commandRUN" = "shutdown -r" ]; then
    echo "FAILED: This script not accept commands for SHUTDOWN server."
	exit
fi
## command validations ##
if [ "$commandRUN" = "chown -R" ]; then
    echo "FAILED!!! BEWARE BEFORE CHANGE OWNER COMMAND!"
	exit
fi
## command validations ##
if [ "$commandRUN" = "chmod -R" ]; then
    echo "FAILED!!! BEWARE BEFORE CHANGE PERMISSIONS COMMAND!"
	exit
fi
#	
echo "COMMAND select: "$commandRUN""	
echo "############################################"	
echo "TWO FACTOR CONFIRMATION FOR DBB SERVERS ** READ YOUR COMMAND BEFORE PROCEED **"
echo "############################################"
	echo $commandRUN
echo "############################################"	
	read -p "#Confirmation1# Are you sure? if Yes, Press enter to continue, if NO, press Control+C to abort."
echo "############################################"	
echo "#Confirmation2# Do you wish run your command for all PREPRODUCTION SERVERS, answer yes or no?" 
echo "############################################"	
read input
if [ "$input" == "yes" ]
	then
function runCMD {
for host in $(cat /home/wasadmin/scripts/properties/DBB-server-list-PREPROD.txt); 
	do 
	echo "access: "$host" with "$userID"...";
	echo "running this command:"$commandRUN""
	ssh "$userID"@"$host" "$commandRUN" > "$resultDir"/"$host"."$outputFILE"; done
echo "Check result file with your commands in directory "$resultDir""
ls -ltr $resultDir
echo "script done!"	
}
runCMD
fi
if [ "$input" == "no" ]
	then 
	echo "Aswered no, script will close now!"
	exit
fi
exit
