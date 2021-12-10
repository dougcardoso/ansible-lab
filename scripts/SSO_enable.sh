echo "Enable SSO preprod:"
ssh rhdbbauthgm1 "sudo /opt/liberty/scripts/maintenance/Divert_Traffic.ksh INTERNAL 9446 10.9.0.250 10.9.0.69 10.9.0.60 10.9.0.62";
ssh rhdbbauthgm2 "sudo /opt/liberty/scripts/maintenance/Divert_Traffic.ksh INTERNAL 9446 10.9.0.250 10.9.0.69 10.9.0.60 10.9.0.62";
ssh rhdbbauthgm3 "sudo /opt/liberty/scripts/maintenance/Divert_Traffic.ksh INTERNAL 9446 10.9.0.250 10.9.0.69 10.9.0.60 10.9.0.62";
ssh rhdbbauthgm4 "sudo /opt/liberty/scripts/maintenance/Divert_Traffic.ksh INTERNAL 9446 10.9.0.250 10.9.0.69 10.9.0.60 10.9.0.62";
sh firewall_report_all_servers.sh;
echo "script done"
