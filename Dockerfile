FROM alpine:latest

ADD hello.sh /opt/hello.sh

RUN apk add --no-cache --virtual .build-deps ca-certificates curl \
 && chmod +x /opt/hello.sh

ENTRYPOINT ["sh", "-c", "/opt/hello.sh"]
