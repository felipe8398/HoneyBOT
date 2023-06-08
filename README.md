# HoneyBOT

## OBJETIVO: ##

- Ter um Honeypot
- Criar interface para compartilhamento dos logs para bloqueio dos IPs em servidores de produção

## Como subir o HoneyBOT ? ##

- Realizar o famoso git clone https://github.com/felipe8398/HoneyBOT.git
- Ter instalado o Docker
- Realizar o build da imagem, exemplo: docker image build -t honey:0.4 .
- Subir o container, exemplo: docker container run -p 443:443 -p 80:80 -p 21:21 -p 23:23 -p 3306:3306 -d --mount type=bind,src=/opt/HoneyBOT/logs/,dst=/opt/honey/logs/ honey:0.4

### Quero adicionar um novo serviço para o Honeypot como fazer ? ###

- Criar um arquivo .service dentro de /HoneyBOT/services
- Adicionar o nome do novo serviço dentro de start.sh
- Criar o arquivo de log em /HoneyBOT/logs
- Criar o bannher em /HoneyBOT/banners

### Como enviar os IOCs para o OTX AlienVault ? ###
 - Abra o arquivo OTX.sh que está dentro de /logs
 - Adicione sua API KEY do AlienVault e adicione seu PulseID
 - Basta executar bash OTX.sh para executar o envio dos IOCs
