# Dockerfile for icinga2 as monitored client
FROM debian:jessie

MAINTAINER Benedikt Heine

ENV DEBIAN_FRONTEND=noninteractive \
    ICINGA2_USER_FULLNAME="Icinga2"

ADD content/ /

RUN apt-key add /opt/setup/icinga2.key \
     && apt-get -q  update \
     && apt-get -qy upgrade \
     && apt-get -qy install --no-install-recommends \
          ca-certificates \
          curl \
          icinga2 \
          icinga2-ido-mysql \
          mailutils \
          monitoring-plugins \
          procps \
          snmp \
          ssmtp \
          sudo \
          supervisor \
          unzip \
          wget \
     && apt-get clean \
     && rm -rf /var/lib/apt/lists/*

# Final fixes
RUN true \
    && mv /etc/icinga2/ /etc/icinga2.dist \
    && mkdir /etc/icinga2 \
    && chmod u+s,g+s \
        /bin/ping \
        /bin/ping6 \
        /usr/lib/nagios/plugins/check_icmp

EXPOSE 80 443 5665

# Initialize and run Supervisor
ENTRYPOINT ["/opt/run"]
