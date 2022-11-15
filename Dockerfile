FROM --platform=$TARGETPLATFORM alpine:3

ARG TARGETPLATFORM
ARG VERSION

ENV GLIBC_VERSION=2.35-r0
ENV SAVE_PATH=/usr/bin/tuic

RUN if [ "${TARGETPLATFORM}" = "linux/386" ]; then export TARGET=i686-linux-musl; fi \ 
    && if [ "${TARGETPLATFORM}" = "linux/amd64" ]; then export TARGET=x86_64-linux-musl; fi  \
    && if [ "${TARGETPLATFORM}" = "linux/arm/v6" ]; then \
    export TARGET=arm-linux-gnueabihf; \
    && wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
    && wget -O /tmp/glibc-${GLIBC_VERSION}.apk https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}}/glibc-${GLIBC_VERSION}}.apk \
    && wget -O /tmp/glibc-bin-${GLIBC_VERSION}.apk https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}}/glibc-bin-${GLIBC_VERSION}}.apk \
    && wget -O /tmp/glibc-dev-${GLIBC_VERSION}.apk https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}}/glibc-dev-${GLIBC_VERSION}}.apk \\
    && wget -O /tmp/glibc-i18n-${GLIBC_VERSION}.apk https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}}/glibc-i18n-${GLIBC_VERSION}}.apk \
    && apk add /tmp/glibc-${GLIBC_VERSION}.apk \
    && apk add /tmp/glibc-bin-${GLIBC_VERSION}.apk \
    && apk add /tmp/glibc-dev-${GLIBC_VERSION}.apk \
    && apk add /tmp/glibc-i18n-${GLIBC_VERSION}.apk \
    && rm -rf /tmp/glibc-*.apk \
    fi  \
    && if [ "${TARGETPLATFORM}" = "linux/arm/v7" ]; then export TARGET=armv7-linux-musleabihf; fi  \
    && if [ "${TARGETPLATFORM}" = "linux/arm64" ]; then export TARGET=aarch64-linux-musl; fi  \
    && wget -O $SAVE_PATH https://github.com/EAimTY/tuic/releases/download/${VERSION}/tuic-server-${VERSION}-${TARGET} \
    && chmod +x $SAVE_PATH

ENTRYPOINT ["tuic"]