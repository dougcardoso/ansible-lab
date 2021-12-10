CK="\033[30m"
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
echo "DBB Syncronization script alpha / omega"
echo "sync scripts running for omega spring server"
scp -r -p /home/wasadmin/maintence rhdbbspringovt1.mid.aib.pri:/home/wasadmin
#echo "sync scripts running for alpha spring server"
#sudo scp -r -p /home/wasadmin/maintence u42288@rhdbbspringavt1.mid.aib.pri:/home/u42288
#ssh u42288@rhdbbspringavt1 'ls -ltr /home/u42288/maintence ; hostname -f'
echo "PROD Infra Ansible"
scp -r -p /home/wasadmin/maintence rhwasbldalvp1.mid.aib.pri:/home/wasadmin
echo "script done!"
