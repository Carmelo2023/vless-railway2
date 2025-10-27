# Utiliser une image légère de base
FROM alpine:latest

# Installer les dépendances nécessaires
RUN apk add --no-cache curl unzip

# Télécharger et installer Xray-core
RUN mkdir -p /xray \
    && cd /xray \
    && curl -L -o xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip \
    && unzip xray.zip \
    && rm xray.zip

# Copier la configuration JSON
COPY config.json /xray/config.json

# Exposer le port (Railway attribue automatiquement le port)
EXPOSE 443

# Lancer Xray
ENTRYPOINT ["/xray/xray", "-config", "/xray/config.json"]
