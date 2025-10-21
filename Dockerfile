FROM alpine:latest

RUN apk add --no-cache wget unzip

WORKDIR /app

# Télécharger Xray-core
RUN wget https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip -O xray.zip && \
    unzip xray.zip && \
    chmod +x xray

COPY config.json /app/config.json

CMD ["./xray", "-config", "/app/config.json"]
