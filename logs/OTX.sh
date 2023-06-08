#!/bin/bash

API_KEY="xyz"
PULSE_ID="abc"
IOC_TYPE="IPv4"
################################################

# CRIANDO RELATORIO DIARIO DOS IPs ATACANTES   #

################################################

cd /opt/HoneyBOT/logs
for line in $(strings -a *.log | grep received | awk -F " on " '{print $2}' | awk -F " " '{print $1}' | sort -n | uniq -c | sort -n | awk -F " " '{print $2}')
do
echo "$line"
done >> $(date +"%Y-%m-%d").diario

#################################################

# ENVIANDO IOC para o OTX Alien Vault		#

#################################################

DIARIO=$(date +"%Y-%m-%d").diario

while IFS= read -r n; do
PORT=$(strings -a *.log | grep -A5 $n | grep "Listening on" | head -n1 | awk '{print $NF}') &&
DATA=$(strings -a *.log | grep -A5 $n | grep "UTC" | head -n1 ) &&
    curl -X PATCH "https://otx.alienvault.com/api/v1/pulses/$PULSE_ID" \
        -H "X-OTX-API-KEY: $API_KEY" \
        -H "Content-Type: application/json" \
        -d '{
            "indicators": {
                "add": [
                    {
                        "expiration": "01/01/25", 
                        "type": "'"$IOC_TYPE"'",
                        "indicator": "'"$n"'",
                        "content": "",
                        "role": "scanning_host",
                        "title": "Scan",
                        "description": "Scanning on HoneyPOT port '"$PORT"' in '"$DATA"'"
                    }
                ]
            }
        }'
done < "$DIARIO"

##################################################################################################

# LIMPA LOG DO DIA ANTERIOR                              					 #

##################################################################################################

echo " " > /opt/HoneyBOT/logs/23.log
echo " " > /opt/HoneyBOT/logs/21.log
echo " " > /opt/HoneyBOT/logs/3306.log
echo " " > /opt/HoneyBOT/logs/80.log
echo " " > /opt/HoneyBOT/logs/443.log

rm $(date +"%Y-%m-%d").diario

