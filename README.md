# HoneyBOT

## OBJETIVO: ##

- Ter um Honeypot
- Enviar notificação para as ASNs responsaveis por se conectar no Honeypot
- Criar interface para compartilhamento dos logs para bloqueio dos IPs em servidores de produção

## Como subir o HoneyBOT ? ##

- Realizar o famoso git clone https://github.com/felipe8398/HoneyBOT.git
- Ter instalado o Docker
- Realizar o build da imagem, exemplo: docker image build -t honey:0.2 .
- Subir o container, exemplo: docker container run -p 21:21 -p 23:23 -p 3306:3306 -d --mount type=bind,src=/opt/HoneyBOT/logs/,dst=/opt/honey/logs/ honey:0.2
- Instalar o mailx na máquina host
- Criar crontab na máquina host com a seguinte configuração: 30 23 * * * /bin/bash /opt/HoneyBOT/logs/envia-email.sh >/dev/null 2>&1

### Quero adicionar um novo serviço para o Honeypot como fazer ? ###

- Criar um arquivo .service dentro de /HoneyBOT/services
- Adicionar o nome do novo serviço dentro de start.sh
- Criar o arquivo de log em /HoneyBOT/logs
- Criar o bannher em /HoneyBOT/banners

### Obs: Ainda está sendo feito: ###
- Criar interface para compartilhamento dos logs para bloqueio dos IPs em servidores de produção
