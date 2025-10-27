FROM alpine:latest

RUN apk add --no-cache wget unzip jq

WORKDIR /app

# Télécharger Xray-core (version stable)
RUN wget https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip -O xray.zip && \
    unzip xray.zip && \
    chmod +x xray

# Copier la config
COPY config.json /app/config.json

# Script d'entrée : injecter $PORT dans config.json avant lancement
RUN echo '#!/bin/sh\n\
if [ -z "$PORT" ]; then echo "PORT not set"; exit 1; fi\n\
jq --arg p "$PORT" '"'"'.inbounds[0].port = ($p|tonumber)'"'"' /app/config.json > /app/config.tmp && mv /app/config.tmp /app/config.json\n\
exec ./xray -config /app/config.json' > /app/start.sh && chmod +x /app/start.sh

EXPOSE 80

CMD ["/app/start.sh"]
