# Dockerfile for icinga2 as monitored client
FROM ruby:2.4.1

MAINTAINER Benedikt Heine

ENV DEBIAN_FRONTEND=noninteractive

ADD content/opt/setup/ /opt/setup/

RUN apt-key add /opt/setup/icinga2.key \
     && apt-get -q  update \
     && apt-get -qy upgrade \
     && apt-get -qy install --no-install-recommends \
          ethtool \
          monitoring-plugins \
          net-tools \
          procps \
          smartmontools \
          snmp \
          sysstat \
          sudo \
          wget \
          curl \
	  ca-certificates \
          redis-tools \
     && apt-get -qy install \
          icinga2 \
          libnagios-plugin-perl \
	  nagios-plugins-contrib \
     && apt-get clean \
     && rm -rf /var/lib/apt/lists/*

ADD content/ /

# Install RAM memory checker
RUN true \
    && wget --no-check-certificate https://raw.githubusercontent.com/justintime/nagios-plugins/master/check_mem/check_mem.pl --directory-prefix="/usr/lib/nagios/plugins/" \
    && chmod 0755 /usr/lib/nagios/plugins/check_mem.pl

# Install CPU checker
RUN true \
    && wget --no-check-certificate https://exchange.icinga.com/exchange/check_cpu.sh/files/551/check_cpu.sh --directory-prefix="/usr/lib/nagios/plugins/" \
    && chmod 0755 /usr/lib/nagios/plugins/check_cpu.sh

# Install PID checker
RUN true \
    && cp /opt/plugins/check_pid /usr/lib/nagios/plugins/check_pid \
    && chmod 0755 /usr/lib/nagios/plugins/check_pid

# Install Sidekiq queue checker
RUN true \
    && cp /opt/plugins/check_sidekiq_queue /usr/lib/nagios/plugins/check_sidekiq_queue \
    && chmod 0755 /usr/lib/nagios/plugins/check_sidekiq_queue

# Install Postgres checker
RUN true \
    && cp /opt/plugins/check_postgres_replication /usr/lib/nagios/plugins/check_postgres_replication \
    && chmod 0755 /usr/lib/nagios/plugins/check_postgres_replication

# Install Sidekiq queues checker (Ruby)
RUN true \
    && cp /opt/plugins/check_sidekiq_queues /usr/lib/nagios/plugins/check_sidekiq_queues \
    && cp /opt/plugins/check_sidekiq_queues.sh /usr/lib/nagios/plugins/check_sidekiq_queues.sh \
    && chmod 0755 /usr/lib/nagios/plugins/check_sidekiq_queues \
    && chmod 0755 /usr/lib/nagios/plugins/check_sidekiq_queues.sh

# Install Sidekiq queues checker2 (Ruby)
RUN true \
    && cp /opt/plugins/check_sidekiq_queues2 /usr/lib/nagios/plugins/check_sidekiq_queues2 \
    && cp /opt/plugins/check_sidekiq_queues2.sh /usr/lib/nagios/plugins/check_sidekiq_queues2.sh \
    && chmod 0755 /usr/lib/nagios/plugins/check_sidekiq_queues2 \
    && chmod 0755 /usr/lib/nagios/plugins/check_sidekiq_queues2.sh

# Install Elasticsearch checker
RUN wget --no-check-certificate https://raw.githubusercontent.com/orthecreedence/check_elasticsearch/master/check_elasticsearch --directory-prefix="/usr/lib/nagios/plugins/" \
    && chmod 0755 /usr/lib/nagios/plugins/check_elasticsearch

# Install Gems
RUN gem install --no-ri --no-rdoc nagios-plugin sidekiq

EXPOSE 5665

ENTRYPOINT ["/opt/run"]
