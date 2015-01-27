# zvelo-elasticsearch

This repository is based on [dockerfile/elasticsearch](https://github.com/dockerfile/elasticsearch).
It contains a **Dockerfile** of [ElasticSearch](http://www.elasticsearch.org/) for [Docker](https://www.docker.com/)'s [automated build](https://registry.hub.docker.com/u/zvelo/zvelo-elasticsearch/) published to the public [Docker Hub Registry](https://registry.hub.docker.com/).

## Base Docker Image

* [java](https://registry.hub.docker.com/_/java/)

## Installation

1. Install [Docker](https://www.docker.com/).
2. Download [automated build](https://registry.hub.docker.com/u/zvelo/zvelo-elasticsearch/) from public [Docker Hub Registry](https://registry.hub.docker.com/):

    ```bash
    docker pull zvelo/zvelo-elasticsearch
    ```

    Alternatively, you can build an image from Dockerfile:

    ```bash
    docker build -t="zvelo/zvelo-elasticsearch" github.com/zvelo/zvelo-elasticsearch
    ```

3. Add fleet metadata to necessary machines:

    ```
    zvelo-elasticsearch=1
    ```

4. Configure settings in etcd ensuring that the hardcoded IP addresses match
   the machines you set the fleet metadata on:

    ```bash
    etcdctl set /config/service/zvelo-elasticsearch/discovery/zen/ping/unicast/hosts 172.17.8.101:9301,172.17.8.102:9301,172.17.8.103:9301
    etcdctl set /config/service/zvelo-elasticsearch/template/default/index.number_of_shards 15
    etcdctl set /config/service/zvelo-elasticsearch/template/default/index.number_of_replicas 2

    for num in 1 2 3; do
        etcdctl set /services/zvelo-elasticsearch/core-0$num:zvelo-elasticsearch-$num:9200 172.17.8.10$num:9201
        etcdctl set /services/zvelo-elasticsearch/core-0$num:zvelo-elasticsearch-$num:9300 172.17.8.10$num:9301
    done
    ```

## Usage

```bash
fleetctl submit zvelo-elasticsearch@.service
fleetctl start zvelo-elasticsearch@{1,2,3}
```
