# Sumo Logic Okta Collector Docker Image
# Version 0.1

FROM ubuntu:18.04
MAINTAINER Sumo Logic <docker@sumologic.com>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update --quiet && \
 apt-get install -y --no-install-recommends apt-utils nginx && \
 apt-get upgrade --quiet --allow-downgrades --allow-remove-essential --allow-change-held-packages -y && \
 apt-get install --quiet --allow-downgrades --allow-remove-essential --allow-change-held-packages -y wget && \
 wget -q -O /tmp/collector.deb https://collectors.sumologic.com/rest/download/deb/64 && \
 dpkg -i /tmp/collector.deb && \
 rm /tmp/collector.deb && \
 apt-get clean --quiet && \
 rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


ENV SUMO_CLOBBER true
ENV SUMO_ENABLE_SNI true

ENV SUMO_COLLECTOR_NAME sumojanus-okta-collector-dev
ENV SUMO_SOURCE_CATEGORY dev/okta

COPY run.sh /run.sh
COPY sumojanus-okta /sumojanus-okta
ADD sumo-sources.json.tmpl /etc/sumo-sources.json.tmpl

EXPOSE 80 2222

ENTRYPOINT ["/bin/bash", "/run.sh"]
