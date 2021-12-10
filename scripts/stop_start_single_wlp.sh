#!/bin/sh
echo "Script use arguments: [hostname] [wlp service name] [stop/start/status]"
echo "Example: rhdbbzulgm1 cxServer cxp status"
host=$1
wlpaction=$2
wlpservice=$3
echo "Show variables..."
echo $1
echo $2
echo $3
echo "Executing commands..."
ssh -q $host "/bin/bash /etc/init.d/wlp-$wlpservice $wlpaction"
echo "Script done"
