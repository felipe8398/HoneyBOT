### CONTAINER BASEADO NO UBUNTU
#############
FROM ubuntu:22.04
############

### INSTALA NETCAT E O SYSTEMCTL E CRIAR ALGUMAS PASTAS NECESSARIAS
########################################
RUN apt-get update && apt-get install -y netcat systemctl
RUN mkdir -p /opt/honey && mkdir -p /opt/honey/logs && mkdir -p /opt/honey/banners
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
EXPOSE 80
EXPOSE 443
########################################

### PRINCIPAL SERVIÇO DO CONTAINER, SE ELE CAIR LASCOU
########################################
ENTRYPOINT ["/opt/honey/start.sh"]
########################################

### PERMITE QUE O SCRIPT ACIMA NÃO FINALIZE
########################################
CMD [ "sleep", "infinity" ]
########################################
