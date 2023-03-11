#############
FROM ubuntu:22.04
############

### INSTALA APACHE CURL PHP MODSEC ###
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

#######################################
RUN chmod +x /opt/honey/start.sh
########################################

########################################
USER root
########################################

########################################
LABEL description="HoneyFodase"
LABEL version="0.1"
########################################

########################################
#VOLUME /var/www/html/
########################################

########################################
EXPOSE 3306
EXPOSE 23
EXPOSE 21
########################################

########################################
ENTRYPOINT ["/opt/honey/start.sh"]
########################################

########################################
#CMD ["-D", "FOREGROUND"]
CMD [ "sleep", "infinity" ]
########################################
