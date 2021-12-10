#!/bin/sh
for appname in $(cat /home/wasadmin/maintence/scripts/properties/DBB-applist.txt);
do
echo "<table border="0" width="100%"><tr><td><form action="/scripts/apps/"$appname"/call_"$appname"_cluster_stop.do" method="post">" > /tmp/$appname.txt;
echo "<input type="submit" value="stop" name="$appname">" >> /tmp/$appname.txt;
echo ""$appname"</form></td></tr></table>" >> /tmp/$appname.txt;
cat /tmp/$appname.txt
done
