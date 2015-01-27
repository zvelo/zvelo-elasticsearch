#!/bin/bash

for tmpl in /elasticsearch/config/templates/*.json; do
  sed -i "s|{{TEMPLATE_DEFAULT_INDEX_NUMBER_OF_SHARDS}}|$TEMPLATE_DEFAULT_INDEX_NUMBER_OF_SHARDS|g" $tmpl
  sed -i "s|{{TEMPLATE_DEFAULT_INDEX_NUMBER_OF_REPLICAS}}|$TEMPLATE_DEFAULT_INDEX_NUMBER_OF_REPLICAS|g" $tmpl
done

sed -i "s|{{DISCOVERY_ZEN_PING_UNICAST_HOSTS}}|$DISCOVERY_ZEN_PING_UNICAST_HOSTS|g" /elasticsearch/config/elasticsearch.yml
sed -i "s|{{COREOS_PRIVATE_IPV4}}|$COREOS_PRIVATE_IPV4|g" /elasticsearch/config/elasticsearch.yml

exec /elasticsearch/bin/elasticsearch "$@"
