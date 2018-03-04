FROM golang:1.8-alpine

RUN apk add --no-cache --virtual .deps curl git \
 && apk add --no-cache python \
 && curl -so /tmp/cloud-sdk.tar.gz https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-191.0.0-linux-x86_64.tar.gz \
 && tar xzf /tmp/cloud-sdk.tar.gz -C /usr/local/ \
 && rm /tmp/cloud-sdk.tar.gz \
 && /usr/local/google-cloud-sdk/install.sh --quiet --additional-components app-engine-go cloud-datastore-emulator \
 && go get google.golang.org/appengine \
 && apk del .deps

ENTRYPOINT [ "/usr/local/google-cloud-sdk/bin/dev_appserver.py", "--host", "0.0.0.0", "--admin_host", "0.0.0.0", "--enable_host_checking", "false", "--enable_console", "true", "--datastore_path", "/tmp/datastore.db" ]
CMD []
