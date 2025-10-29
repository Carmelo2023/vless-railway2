FROM teddysun/xray:latest

COPY config.json /etc/xray/config.json

EXPOSE 3000

CMD ["xray", "-config", "/etc/xray/config.json"]
