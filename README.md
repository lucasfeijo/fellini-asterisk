# Asterisk Container for Building Intercom

This repository contains a minimal Asterisk setup that can be deployed in a Docker container. It is intended to connect an Intelbras analog PBX to Asterisk through a Grandstream HT812 gateway.

## Building the Image

```bash
docker build -t asterisk docker
```

## Running the Container

```bash
docker run -p 5060:5060/udp asterisk
```

Configuration files live in `docker/config` and define a simple IVR that maps digits 1-4 to apartment extensions 201, 202, 301, and 302 via the HT812.

## Tests

Automated tests can be executed with:

```bash
./tests/test_container.sh
```

The script attempts to run the Asterisk container if Docker is available. If Docker is not present, it starts a temporary Asterisk instance directly on the host using the sample configuration.
