hostname -f
find /logs/liberty -mtime +2 -print -exec gzip {} \;
echo "======================================"
