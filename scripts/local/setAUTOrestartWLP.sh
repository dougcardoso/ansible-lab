o "########################################################"
echo "# Script for set automatic restart of wlp scripts for DBB servers #"
echo "# DBB servers PREPROD #"
echo "# script path: /home/wasadmin/maintence/scripts/ #"
echo "# script name: setAUTOrestartWLP.sh #"
echo "# run ./setAUTOrestartWLP.sh #"
echo "# runs with wasadmin user #"
echo "# Author: Douglas Cardoso #"
echo "# Wipro/AIB - Websphere Team #"
echo "# ph: +353 874597272 / douglas.x.cardoso@aib.ie #"
echo "# 12-12-2018 /ver 1.0 #"
echo "########################################################"
## VARIABLES
########################################################
libertyinstanceDIR="/opt/liberty/wlp/usr/servers"
libertyinstanceFILE="libertyServerList.txt"
TEMPscript_path="/tmp/temp_script"
hostname=`hostname -f`
timestamp=`date`
########################################################
# CHECK USER WASADMIN RUNNING SCRIPT
if [ $USER != "wasadmin" ]; then
        echo "Script must be run as user: WASADMIN"
        exit -1
fi
########################################################
echo "READING EACH WLP LIBERTY INSTANCE..."
ls $libertyinstanceDIR
########################################################
## BUILD INSTANCE FILE#################################################################################
mkdir -p $TEMPscript_path
                        ls $libertyinstanceDIR > $TEMPscript_path/$libertyinstanceFILE
                        cat $TEMPscript_path/$libertyinstanceFILE | while read libertyINSTANCEServer
do
                echo "Running check "$libertyINSTANCEServer"";
##SERVICE INSTANCE CHECK###############################################################################
	[ -f /etc/init.d/wlp-$libertyINSTANCEServer ] && echo "wlp-"$libertyINSTANCEServer" Found SUCCESS!" || echo "wlp-"$libertyINSTANCEServer" Not found, FAILED!!!" ;
		echo "wlp script found:"
		ls -ltr /etc/init.d/wlp* | grep "wlp"
		echo "Applying systemctl enable for wlp:"
			sudo systemctl enable wlp-$libertyINSTANCEServer;
		echo "Checking result from chkconfig:"
			sudo /usr/sbin/chkconfig | grep wlp-$libertyINSTANCEServer;
done
##CHECK SERVICES##########################################################################################################
echo ""$hostname" at "$date""
echo "Script done!"
