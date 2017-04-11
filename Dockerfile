# Dockerfile for icinga2 as monitored client
FROM debian:jessie

MAINTAINER Benedikt Heine

ENV DEBIAN_FRONTEND=noninteractive

ADD content/ /

RUN apt-key add /opt/setup/icinga2.key \
     && apt-get -q  update \
     && apt-get -qy upgrade \
     && apt-get -qy install --no-install-recommends \
          ethtool \
          icinga2 \
          monitoring-plugins \
          net-tools \
          procps \
          smartmontools \
          snmp \
          sysstat \
          sudo \
          wget \
	  ca-certificates \
     && apt-get install -qy libnagios-plugin-perl \
	  nagios-plugins-contrib \
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

# Install RAM memory checker
RUN true \
    && cd /usr/lib/nagios/plugins/ \
    && wget --no-check-certificate https://raw.githubusercontent.com/justintime/nagios-plugins/master/check_mem/check_mem.pl \
    && chmod 0755 check_mem.pl

EXPOSE 80 443 5665

ENTRYPOINT ["/opt/run"]
