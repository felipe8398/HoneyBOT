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
- Configurar as informações de envio de email no DockerFile

### Quero adicionar um novo serviço para o Honeypot como fazer ? ###

- Criar um arquivo .service dentro de /HoneyBOT/services
- Adicionar o nome do novo serviço dentro de start.sh
- Criar o arquivo de log em /HoneyBOT/logs
- Criar o bannher em /HoneyBOT/banners

### Obs: Ainda está sendo feito: ###
- Criar interface para compartilhamento dos logs para bloqueio dos IPs em servidores de produção
