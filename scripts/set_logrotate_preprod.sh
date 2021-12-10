echo "Copy logrotation files to DBB preprod servers..."
for copyhost in $(cat /home/wasadmin/maintence/scripts/properties/DBB-server-list-PREPROD.txt);
do
ssh -q wasadmin@copyhost "mkdir -p /tmp/logrotate_files/";
cd /home/wasadmin/maintence/scripts/local/logrotate_files/;
scp * wasadmin@$copyhost:/tmp/logrotate_files/; 
ssh -q wasadmin@copyhost "cd /tmp/logrotate_files/; sudo cp * /etc/logrotate.d/; ls /etc/logrotate.d/"
done
