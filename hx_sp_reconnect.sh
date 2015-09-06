#!/bin/bash
speedportpassword="CHANGEME"
scriptname=$(basename $0)
tmpfile=$(mktemp)
cookiejar=$(mktemp)


logger -i -t "${scriptname}" "Speedport W921V  - Login"
curl -k -s "https://speedport.ip/data/Login.json"   --data "password=${speedportpassword}&showpw=0" --referer "https://speedport.ip" --cookie-jar ${cookiejar} -O ${tmpfile}

logger -i -t "${scriptname}" "Speedport W921V  - Offline"
curl -k -s "https://speedport.ip/data/Connect.json" --data "req_connect=offline" --referer "https://speedport.ip" --cookie ${cookiejar} --cookie-jar "/tmp/speedport.cookie" -O ${tmpfile}

logger -i -t "${scriptname}" "Speedport W921V  - Online"
curl -k -s "https://speedport.ip/data/Connect.json" --data "req_connect=online" --referer "https://speedport.ip" --cookie ${cookiejar} --cookie-jar "/tmp/speedport.cookie" -O ${tmpfile}

logger -i -t "${scriptname}" "Speedport W921V  - Logout"
curl -k -s "https://speedport.ip/data/Login.json"   --data "logout=byby" --referer "https://speedport.ip" --cookie-jar ${cookiejar} -O ${tmpfile}

if [ -f ${tmpfile} ]; then
logger -i -t "${scriptname}" "Speedport W921V  - Deleting downloaded data"
rm ${tmpfile}
fi

if [ -f ${cookiejar} ]; then
logger -i -t "${scriptname}" "Speedport W921V  - Deleting cookies"
rm ${cookiejar}
fi

exit 0

