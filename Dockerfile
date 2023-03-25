### CONTAINER BASEADO NO UBUNTU
#############
FROM ubuntu:22.04
############

### INSTALA NETCAT E O SYSTEMCTL E CRIAR ALGUMAS PASTAS NECESSARIAS
########################################
RUN apt-get update && apt-get install -y netcat systemctl mailutils whois cron
RUN mkdir -p /opt/honey && mkdir -p /opt/honey/logs && mkdir -p /opt/honey/banners
RUN echo "set smtp=smtp://smtp-relay.sendinblue.com" > /root/.mailrc
RUN echo "set from=thehivealert@gmail.com" >> /root/.mailrc
RUN echo 'set realname="HoneyBot Cadeolog"' >> /root/.mailrc
RUN echo "set smtp=smtp-relay.sendinblue.com" >> /root/.mailrc
RUN echo "set smtp-auth=thehivealert@gmail.com" >> /root/.mailrc
RUN echo "set smtp-auth-user=thehivealert@gmail.com" >> /root/.mailrc
RUN echo "set smtp-auth-password=*****ColoqueSuaSenhaAqui*********" >> /root/.mailrc
RUN echo "set smtp-use-starttls" >> /root/.mailrc
RUN echo "set ssl-verify=ignore" >> /root/.mailrc
########################################

### SOBE OS SERVICES, LOGS, BANNERS, E INICIA OS SERVICES CRIADOS DO HONEYPOT
COPY services/* /etc/systemd/system/
COPY logs/* /opt/honey/logs/
COPY banners/* /opt/honey/banners/
COPY start.sh /opt/honey/
#######################################

### ADICIONA PERMISSAO AO SCRIPT
#######################################
RUN chmod +x /opt/honey/start.sh
RUN crontab -l | { cat; echo "30 23 * * * bash /opt/honey/logs/envia-email.sh >/dev/null 2>&1"; } | crontab -
########################################

### TODO CONTAINER É EXECUTADO COM USUARIO ROOT (DESCULPA)
########################################
USER root
########################################

### DESCRIÇÃO DO HONEYBOT E SUA VERSÃO
########################################
LABEL description="HoneyBOT"
LABEL version="0.3"
########################################

### EXPOEM AS PORTAS DOS SERVICOS DO HONEYBOT
########################################
EXPOSE 3306
EXPOSE 23
EXPOSE 21
########################################

### PRINCIPAL SERVIÇO DO CONTAINER, SE ELE CAIR LASCOU
########################################
ENTRYPOINT ["/opt/honey/start.sh"]
########################################

### PERMITE QUE O SCRIPT ACIMA NÃO FINALIZE
########################################
#CMD ["-D", "FOREGROUND"]
CMD [ "sleep", "infinity" ]
########################################
