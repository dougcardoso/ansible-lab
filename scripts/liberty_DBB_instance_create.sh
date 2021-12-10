#!/bin/sh
########################################################
clear
echo "###########################################################"
echo "#   DBB server maintence scripts AIB WebSphere Team       #"
echo "###########################################################"
echo "# Script to create liberty instance for DBB               #"
echo "# script path: /home/wasadmin/scripts/                    #"
echo "# script name: liberty_DBB_instance_create.sh             #"
echo "# arguments:                                              #"
echo "# run liberty_DBB_instance_create.sh                      #"
echo "# execute with wasadmin user                              #"
echo "# Author: Douglas Cardoso                                 #"
echo "# +353 874597272 / douglas.x.cardoso@aib.ie               #"
echo "# 13-11-2018 /version 1.0                                 #"
echo "###########################################################"
########################################################
#VARIABLES liberty
########################################################
scriptproperties="/opt/liberty/scripts/properties"
authorizedkeyspath="/home/wasadmin/.ssh"
libertyCMDcreate="/opt/liberty/wlp/bin/server create"
LIBERTYINSTALL="/opt/liberty/"
wily10INST="/opt/liberty/wily10/"
wily10_7INST="/opt/liberty/wily10_7/"
keysLIBERTY="/opt/liberty/keys"
logsLIBERTY="/logs/liberty"
libertyinstanceDIR="/opt/liberty/wlp/usr/servers"
libertyHOSTNAME=`hostname -f`
libertyconf_jvmoptions="jvm.options"
libertyconf_serverxml="server.xml"
libertyconf_keyfile="key.xml"
libertyconf_serverenv="server.env"
willysetjavaagent="javaagent-javaagent:/opt/liberty/wily10_7/Agent.jar"
willysetIntroscopeAgent="-Dcom.wily.introscope.agentProfile=/opt/liberty/wily10_7/core/config/IntroscopeAgent.profile"
willysetbootdelegation="-Dorg.osgi.framework.bootdelegation=com.wily.*"
willysetagentName="-Dcom.wily.introscope.agent.agentName"
hostname=`hostname -f`

#create instance liberty
    echo "Script will create liberty instance into server:  "$hostname""
	echo "Type liberty instance name:"
	read libertyInstanceName
	echo "Your liberty instance name "$libertyInstanceName""
$libertyCMDcreate $libertyInstanceName
#create instance liberty
	sudo cp -p $scriptproperties/wlp-replaceINSTANCESERVERNAME $scriptproperties/wlp-$libertyInstanceName
	sed -i -e "s/replaceINSTANCESERVERNAME/${libertyInstanceName}/g" $scriptproperties/wlp-$libertyInstanceName
	sudo cp -p $scriptproperties/wlp-$libertyInstanceName /etc/init.d/
	cd /etc/init.d/
	sudo systemctl enable wlp-$libertyInstanceName
	cd /opt/liberty/scripts
#ulimit setting
	ulimit -u 131072
#wily settings
	touch $libertyinstanceDIR/$libertyInstanceName/$libertyconf_jvmoptions
	sudo cp -p $libertyinstanceDIR/$libertyInstanceName/$libertyconf_jvmoptions $libertyinstanceDIR/$libertyInstanceName/$libertyconf_jvmoptions.orig.bkp
	echo $willysetjavaagent >> $libertyinstanceDIR/$libertyInstanceName/$libertyconf_jvmoptions
	echo $willysetIntroscopeAgent >> $libertyinstanceDIR/$libertyInstanceName/$libertyconf_jvmoptions
	echo $willysetbootdelegation >> $libertyinstanceDIR/$libertyInstanceName/$libertyconf_jvmoptions
	echo ""$willysetagentName"="$libertyInstanceName"" >> $libertyinstanceDIR/$libertyInstanceName/$libertyconf_jvmoptions
	sudo sort $libertyinstanceDIR/$libertyInstanceName/$libertyconf_jvmoptions | uniq
#firewall-cmd commands for http and https
	echo "Type liberty/firewall instance HTTP port:"
	read httpPORT
	echo "HTTP port number:"$httpPORT""
	echo "Type liberty/firewall instance HTTPS port:"
	read httpsPORT
	echo "HTTPS port number: "$httpsPORT""
#firewall-cmd commands for http and https
	sudo firewall-cmd  --list-ports | grep port
	sudo firewall-cmd  --permanent --zone=public --add-port=$httpPORT/tcp
	sudo firewall-cmd  --permanent --zone=public --add-port=$httpsPORT/tcp
	sudo firewall-cmd  --list-ports | grep port
	sudo firewall-cmd  --reload
#keyfile config
	mkdir -p $keysLIBERTY
	sudo cp -p $keysLIBERTY/$libertyconf_keyfile $keysLIBERTY/$libertyconf_keyfile.orig.bkp
	sudo cp -p $keysLIBERTY/trust.jks $keysLIBERTY/trust.jks.bkp1
	sudo cp -p $scriptproperties/trust.jks $keysLIBERTY
	sudo cp -p $scriptproperties/$libertyconf_keyfile $keysLIBERTY/$libertyconf_keyfile
#	sudo sort $keysLIBERTY/$libertyconf_keyfile | uniq
#security server.xml
	sudo cp -p $libertyinstanceDIR/$libertyInstanceName/$libertyconf_serverxml $libertyinstanceDIR/$libertyInstanceName/$libertyconf_serverxml.orig.bkp
	cat $libertyinstanceDIR/$libertyInstanceName/$libertyconf_serverxml | sed -e '/httpEndpoint/d' > $libertyinstanceDIR/$libertyInstanceName/$libertyconf_serverxml.tmp1
	cat $libertyinstanceDIR/$libertyInstanceName/$libertyconf_serverxml.tmp1 | sed -e '/httpPort/d' > $libertyinstanceDIR/$libertyInstanceName/$libertyconf_serverxml.tmp2
	cat $libertyinstanceDIR/$libertyInstanceName/$libertyconf_serverxml.tmp2 | sed -e '/httpsPort/d' > $libertyinstanceDIR/$libertyInstanceName/$libertyconf_serverxml
	rm -f $libertyinstanceDIR/$libertyInstanceName/$libertyconf_serverxml.tmp1
	rm -f $libertyinstanceDIR/$libertyInstanceName/$libertyconf_serverxml.tmp2
	echo "<sslDefault sslRef='"defaultSSLSettings"'/>" >> $libertyinstanceDIR/$libertyInstanceName/$libertyconf_serverxml
	echo "<ssl id='"defaultSSLSettings"' keyStoreRef='"defaultKeyStore"' trustStoreRef='"defaultTrustStore"' sslProtocol='"SSL_TLSv2"' clientAuthentication='"false"'/>" >> $libertyinstanceDIR/$libertyInstanceName/$libertyconf_serverxml
	echo "<httpEndpoint id='"defaultHttpEndpoint"' host='"*"' httpPort='"replacehttpPORT"' httpsPort='"replacehttsport"' onError='"FAIL"' clientAuthentication='"false"'/>" >> $libertyinstanceDIR/$libertyInstanceName/$libertyconf_serverxml
	echo "<!-- dbb replace_instance_name cert -->" >> $libertyinstanceDIR/$libertyInstanceName/$libertyconf_serverxml
	echo "<keyStore id='"defaultKeyStore"' location='"REPLACEkeystorefile"' password='"REPLACEPASS"' type='"jks"' />" >> $libertyinstanceDIR/$libertyInstanceName/$libertyconf_serverxml
	echo "<keyStore id='"defaultTrustStore"' location='"REPLACETrustStore"' password='"REPLACEPASS"' type='"jks"' />" >> $libertyinstanceDIR/$libertyInstanceName/$libertyconf_serverxml
	echo "<include location='"/opt/liberty/keys/key.xml"' />" >> $libertyinstanceDIR/$libertyInstanceName/$libertyconf_serverxml
	sed -i -e "s/replacehttpPORT/${httpPORT}/g" $libertyinstanceDIR/$libertyInstanceName/$libertyconf_serverxml
	sed -i -e "s/replacehttsport/${httpsPORT}/g" $libertyinstanceDIR/$libertyInstanceName/$libertyconf_serverxml
	sudo sort $libertyinstanceDIR/$libertyInstanceName/$libertyconf_serverxml | uniq
	#security server.env
	sudo cp -p $libertyinstanceDIR/$libertyInstanceName/$libertyconf_serverenv $libertyinstanceDIR/$libertyInstanceName/$libertyconf_serverenv.orig.bkp
	echo "WLP_SKIP_UMASK=true" | tail > $libertyinstanceDIR/$libertyInstanceName/$libertyconf_serverenv
	sudo sort $libertyinstanceDIR/$libertyInstanceName/$libertyconf_serverenv | uniq
#logDIR
	mkdir -p $logsLIBERTY/$libertyInstanceName
	ln -s $libertyinstanceDIR/$libertyInstanceName/logs $logsLIBERTY/$libertyInstanceName
	sudo chmod -R 755 $logsLIBERTY
	sudo chown -R wasadmin:wasusers $logsLIBERTY
#auth keys
	sudo cp -p $authorizedkeyspath/authorized_keys $authorizedkeyspath/authorized_keys.bkp1
	sudo cp -p $scriptproperties/authorized_keys $authorizedkeyspath
#permission and owners
	sudo chmod -R 755 $LIBERTYINSTALL
	sudo chown -R wasadmin:wasusers $LIBERTYINSTALL
	sudo chmod -R 755 $authorizedkeyspath
	sudo chown -R wasadmin:wasusers $authorizedkeyspath
	sudo chmod 600 $authorizedkeyspath/authorized_keys
	sudo chown wasadmin:wasusers $authorizedkeyspath/authorized_keys
#script log
echo "Script finished!"
