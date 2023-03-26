#!/bin/bash
systemctl daemon-reload
systemctl start honeytelnet.service
systemctl start honeyftp.service
systemctl start honeyMYSQL.service
systemctl start honeyHTTP.service
systemctl start honeyHTTPS.service
exec "$@"
