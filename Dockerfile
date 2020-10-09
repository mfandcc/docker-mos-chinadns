FROM alpine:latest

ENV VERSION v1.5.3

WORKDIR /opt

RUN set -xe && \
    mkdir /config && \
    apk add --no-cache unzip curl ca-certificates && \
    curl -fsSLO --compressed "https://github.com/IrineSistiana/mos-chinadns/releases/download/${VERSION}/mos-chinadns-linux-amd64.zip" && \
    unzip -o "mos-chinadns-linux-amd64.zip" -d /opt && \
    rm -rf "mos-chinadns-linux-amd64.zip" && \
    mv /opt/config.yaml /opt/chn_domain.list /opt/chn.list /config/ && \
    rm -f /opt/README.MD /opt/LICENSE && \
    chmod +x /opt/mos-chinadns && \
    apk del unzip curl

VOLUME [ "/config" ]

CMD [ "/opt/mos-chinadns", "-c", "/config/config.yaml", "-dir", "/config"]
