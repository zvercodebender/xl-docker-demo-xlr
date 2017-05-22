FROM openjdk:jre-alpine
MAINTAINER XebiaLabs "info@xlrebialabs.com"
RUN apk update && apk add supervisor wget
RUN wget -O /tmp/xl-release-trial.zip https://xebialabs.box.com/shared/static/3qxsc7hi5c07vnen0i71cj7s7lgkuqj0.zip  && mkdir -p /opt/xlr && unzip /tmp/xl-release-trial.zip -d /opt/xlr && mv /opt/xlr/xl-release-*-server /opt/xlr/server && rm -rf /tmp/xl-release-trial.zip
ADD resources/xl-release-server.conf /opt/xlr/server/conf/xl-release-server.conf
ADD resources/synthetic.xml /opt/xlr/server/ext/synthetic.xml
RUN /opt/xlr/server/bin/run.sh -setup -reinitialize -force
ADD resources/supervisord.conf /etc/supervisord.conf
ADD resources/xl-release-server.conf /opt/xlr/server/conf/xl-release-server.conf
RUN ln -fs /license/xl-release-license.lic /opt/xlr/server/conf/xl-release-license.lic
CMD ["/usr/bin/supervisord"]
EXPOSE 5516
