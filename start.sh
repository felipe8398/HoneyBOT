#!/bin/bash
systemctl daemon-reload
systemctl start honeytelnet.service
systemctl start honeyftp.service
systemctl start honeyMYSQL.service
exec "$@"
