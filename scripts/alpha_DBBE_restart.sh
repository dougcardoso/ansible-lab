sudo su - wasadmin
cd /opt/liberty/deployments/ansible_dbbe
git fetch
git reset --hard origin/DBB-18.0.0-RC
git checkout DBB-18.0.0-RC
git pull
./restart_dbbe.sh environments/preprod-alpha
