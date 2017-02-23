# Dockerfile for icinga2 as monitored client
FROM debian:jessie

MAINTAINER Benedikt Heine

ENV DEBIAN_FRONTEND=noninteractive \
    ICINGA2_USER_FULLNAME="Icinga2"

RUN apt-get -qq update \
     && apt-get -qqy upgrade \
     && apt-get -qqy install --no-install-recommends \
          ca-certificates \
          curl \
          mailutils \
          procps \
          snmp \
          ssmtp \
          sudo \
          supervisor \
          unzip \
          wget \
     && apt-get clean \
     && rm -rf /var/lib/apt/lists/*

RUN wget --quiet -O - https://packages.icinga.org/icinga.key \
     | apt-key add - \
     && echo "deb http://packages.icinga.org/debian icinga-jessie main" > /etc/apt/sources.list.d/icinga2.list \
     && apt-get -qq update \
     && apt-get -qqy install --no-install-recommends \
          icinga2 \
          icinga2-ido-mysql \
          icingacli \
          monitoring-plugins \
     && apt-get clean \
     && rm -rf /var/lib/apt/lists/*

ADD content/ /

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
