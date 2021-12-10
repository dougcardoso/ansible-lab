#!/bin/sh
BLACK="\033[30m"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
PINK="\033[35m"
CYAN="\033[36m"
WHITE="\033[37m"
NORMAL="\033[0;39m"
printf $PINK
echo "########################################################"
printf $RED
echo "   #      ###   ######          ######  ######  ######"
echo "  # #      #    #     #         #     # #     # #     #"
echo " #   #     #    #     #         #     # #     # #     #"
echo "#     #    #    ######          #     # ######  ######"
echo "#######    #    #     #         #     # #     # #     #"
echo "#     #    #    #     #         #     # #     # #     #"
echo "#     #   ###   ######          ######  ######  ######"
printf $PINK
echo "########################################################"
printf $WHITE
printf $GREEN
x="aibmenu"
menu ()
{
while true $x != "aibmenu"
do
clear
printf $PINK
echo "########################################################"
printf $RED
echo "   #      ###   ######          ######  ######  ######"
echo "  # #      #    #     #         #     # #     # #     #"
echo " #   #     #    #     #         #     # #     # #     #"
echo "#     #    #    ######          #     # ######  ######"
echo "#######    #    #     #         #     # #     # #     #"
echo "#     #    #    #     #         #     # #     # #     #"
echo "#     #   ###   ######          ######  ######  ######"
echo "########################################################"
printf $WHITE
echo ">># WEBSPHERE SUPPORT TEAM -  AUTHOR DOUGLAS CARDOSO #<<"
printf $RED
echo "########################################################"
printf $WHITE
echo ""
echo "1)Run DBB_checkSSH_preprod.sh"
echo""
echo "2)Run DBB_all_servers_execute_wlpStatus.sh"
echo""
echo "3)Run changePASS_DBBservers.sh"
echo""
echo "4)Run runCMDserverlist.sh"
echo""
echo "5)Run DBB_checkSERVICES_linux.sh"
echo""
echo "6)Run DBB_inventary_server_wlp.sh"
echo""
echo "7) Read script result log file /tmp/DBB_menu_1_result.txt"
echo""
echo "8)Exit/Adios/Sair"
echo ""
echo "================================================"
printf $YELLOW
echo "Choose your option:"
read x
echo "Option selected is: ($x)"
echo "Processing your option, waiting few seconds to complete execution..."
echo "log available in /tmp/DBB_menu_1_result.txt"
echo "================================================"
printf $NORMAL

case "$x" in


    1)
      echo "SSH access and keys check for PREPROD all DBB servers..."
      sh /home/wasadmin/maintence/scripts/DBB_checkSSH_preprod.sh > /tmp/DBB_menu_1_result.txt
	  cat /tmp/DBB_menu_1_result.txt
	  echo "log available in /tmp/DBB_menu_1_result.txt"
	  sleep 05
echo "================================================"
;;
    2)
      echo "Check status all DBB servers WLP LIBERTY..."
      sh /home/wasadmin/maintence/scripts/DBB_all_servers_execute_wlpStatus.sh > /tmp/DBB_menu_1_result.txt
	  cat /tmp/DBB_menu_1_result.txt
	  echo "log available in /tmp/DBB_menu_1_result.txt"	    
      sleep 05
echo "================================================"
;;
    3)
      echo "Change your password for all DBB PREPROD servers..."
      sh /home/wasadmin/maintence/scripts/changePASS_DBBservers.sh
	  cat /tmp/DBB_menu_1_result.txt
	  echo "log available in /tmp/DBB_menu_1_result.txt"	    
      sleep 05
echo "================================================"
;;
    4)
      echo "Run remotely commands for all DBB servers **WARNING**..."
      sh /home/wasadmin/maintence/scripts/runCMDserverlist.sh
	  echo "log available in /tmp/DBB_menu_1_result.txt"	    
      sleep 05
echo "================================================"
;;
    5)
      echo "Check Linux service status for all DBB servers..."
      sh /home/wasadmin/maintence/scripts/DBB_checkSERVICES_linux.sh > /tmp/DBB_menu_1_result.txt
	  cat /tmp/DBB_menu_1_result.txt
	  echo "log available in /tmp/DBB_menu_1_result.txt"	    
      sleep 05
echo "================================================"
;;
    6)
      echo "Generate an Inventory WLP and hostname DBB servers..."
      sh /home/wasadmin/maintence/scripts/DBB_inventary_server_wlp.sh > /tmp/DBB_menu_1_result.txt
	  cat /tmp/DBB_menu_1_result.txt
	  echo "log available in /tmp/DBB_menu_1_result.txt"	    
      sleep 05
	  echo "================================================"
;;
    7)
      echo "Read script result log file /tmp/DBB_menu_1_result.txt, 20 seconds opened."
      cat /tmp/DBB_menu_1_result.txt
	  echo "File available in /tmp/DBB_menu_1_result.txt"	    
      sleep 20

echo "================================================"
 ;;
       8)
      echo "Check status for WLP liberty DBB servers..."
      sh /home/wasadmin/maintence/scripts/DBB_all_wlpStatus.sh > /tmp/DBB_menu_1_result.txt
          cat /tmp/DBB_menu_1_result.txt
          echo "log available in /tmp/DBB_menu_1_result.txt"
      sleep 20

echo "================================================"
 ;;
      9)
         echo "Exit..."
                 echo "File available in /tmp/DBB_menu_1_result.txt"
         clear;
         exit;
echo "================================================"

;;

*)
        echo "Invalid option, Little Smart!"
esac
done

}
menu
printf $NORMAL
echo "File available in /tmp/DBB_menu_1_result.txt"	    
echo "Script done!"
