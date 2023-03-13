#!/bin/bash

################################################

# CRIANDO RELATORIO DIARIO DOS IPs ATACANTES   #

################################################

for line in $(strings -a *.log | grep received | awk -F " on " '{print $2}' | awk -F " " '{print $1}' | sort -n | uniq -c | sort -n | awk -F " " '{print $2}')
do
echo -n "$line;" && whois $line | grep @ | head -n1 | awk '{print $NF'} | sed "s/'//g"  | sed "s/(//g" | sed "s/)//g"
done >> $(date +"%Y-%m-%d").diario

#################################################

# ENVIANDO NOTIFICACAO POR EMAIL		#

#################################################

DIARIO=$(date +"%Y-%m-%d").diario

for n in $(cat $DIARIO); do FROM="thehivealert@gmail.com" && PARA="$(echo $n | awk -F ";" '{print $2}')" && ASSUNTO="$(echo O IP $n | awk -F ";" '{print $1}') se conectou no Honeypot" && CORPO=$(for line in $(echo $n) ; do IP=$(echo $line | awk -F ";" '{print $1}') && line1=$(echo $line | awk -F ";" '{print $1}') && PORTA=$(strings -a *.log | grep -A5 $line1 | grep "Listening on" | head -n1 | awk '{print $NF}') && DATA=$(strings -a *.log | grep -A5 $line1 | grep "UTC" | head -n1 ) && echo "The IP $IP made a request to the Honeypot, connecting to the port $PORTA in $DATA, this is an indication that it is scanning or trying to abuse someone else infrastructure. If you have any questions, please reply to thehivealert@gmail.com" ; done)

echo "$CORPO" | mailx -s "$ASSUNTO" "$PARA" -r "$FROM"

done
