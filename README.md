# Docker Proxy Squid [![Docker Automated build](https://img.shields.io/docker/automated/orangecloudfoundry/squid.svg?style=plastic)](https://hub.docker.com/r/orangecloudfoundry/squid/)

## What about squid

`squid` is a caching proxy for the Web, supporting HTTP and HTTPS.

This docker image supports a container with following features:

* Allow Internet access on port 80, 8080 and 443
* Reduces bandwidth and improves response times by caching and reusing frequently-requested web pages

## How to get it ?

Pull the image from docker Hub:

``` bash
docker pull orangecloudfoundry/squid
```

## How to build it ?

Clone Github repository:

``` bash
git clone https://github.com/orange-cloudfoundry/squid.git
```

Then, build the image:

``` bash
docker build -t squid .
```

**Note:**
If you need to use proxy for Internet access (e.g: export http://`IP_proxy`:3128), you have to use the following syntax:

``` bash
export http_proxy="http://`IP_proxy`:3128"
export https_proxy="http://`IP_proxy`:3128"
docker build --build-arg http_proxy=${http_proxy} --build-arg https_proxy=${https_proxy} -t squid .
```

## How to use it ?

### Use it as standalone container (on single docker host)

Launch the image:

``` bash
docker run -p 3128:3128 -d --name squid -d orangecloudfoundry/squid
```

Acces to the container to see logs transactions:

``` bash
docker exec -it squid sh
```

### Use it with "Docker Bosh Release"

Another option is to deploy the container threw the [Docker Bosh Release](https://github.com/cloudfoundry-community/docker-boshrelease).

In the following example:

  * Deploy 1 instance of the container
  * Squid logs are collected with syslog
  * Volume `/var/spool/squid` is mounted in the container (cache directory)

Example of bosh deployment manifest:

``` yaml
instance_groups:
- name: internet-relay
  instances: 1
  vm_type: small
  stemcell: trusty
...

jobs:
  - {release: docker, name: docker}
  - {release: docker, name: containers}

  properties:
    containers:
    - name: internetsquid
      image: "orangecloudfoundry/squid"
      log_driver: syslog
      bind_ports:
      - "3128:3128"
      bind_volumes:
      - "/var/spool/squid"
```
