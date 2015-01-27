FROM java
MAINTAINER Joshua Rubin <jrubin@zvelo.com>

ENV ELASTICSEARCH_VERSION 1.4.2

RUN \
  cd / && \
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-$ELASTICSEARCH_VERSION.tar.gz && \
  tar xvzf elasticsearch-$ELASTICSEARCH_VERSION.tar.gz && \
  rm -f elasticsearch-$ELASTICSEARCH_VERSION.tar.gz && \
  mv /elasticsearch-$ELASTICSEARCH_VERSION /elasticsearch

VOLUME ["/data"]
ADD elasticsearch.yml /elasticsearch/config/elasticsearch.yml
ADD start.sh /elasticsearch/bin/start.sh
ADD templates /elasticsearch/config/templates
WORKDIR /data
ENTRYPOINT ["/elasticsearch/bin/start.sh"]

EXPOSE 9200
EXPOSE 9300
EXPOSE 9301
