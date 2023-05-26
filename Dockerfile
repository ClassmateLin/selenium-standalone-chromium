FROM --platform=$TARGETPLATFORM alpine:3.17

ENV TZ=Asia/Shanghai

RUN sed -i "s/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g" /etc/apk/repositories \
    && apk update  \
    && apk add --no-cache chromium-chromedriver tzdata openjdk8-jre \
    && echo "${TZ}" > /etc/timezone \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && mkdir -p /usr/local/selenium-server \
    &&  wget https://github.com/SeleniumHQ/selenium/releases/download/selenium-4.9.0/selenium-server-4.9.1.jar -O /usr/local/selenium-server/selenium.jar \
    && rm -rf /var/cache/apk/*


CMD ["/usr/bin/java", "-jar", "/usr/local/selenium-server/selenium.jar", "standalone"]