echo "Zip old logs for DBB servers preprod"
for host in $(cat /home/wasadmin/maintence/scripts/properties/DBB-server-list-PREPROD.txt);
do
scp /home/wasadmin/maintence/scripts/local/ziplogs.sh wasadmin@$host:/logs/liberty/; 
ssh -q wasadmin@$host "hostname -f ;sh /logs/liberty/ziplogs.sh; df -kh /logs/liberty" &
echo "script processing... "$host""
done
