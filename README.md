# Asterisk Container for Building Intercom

This repository contains a minimal Asterisk setup that can be deployed in a Docker container. It is intended to connect an Intelbras analog PBX to Asterisk through a Grandstream HT812 gateway.

The provided GitHub Actions workflow builds the container image and pushes it to GitHub Container Registry (GHCR) whenever changes are pushed or a pull request is opened.

## Building the Image

```bash
docker build -t asterisk docker
```

Or pull the image built by GitHub Actions:

```bash
docker pull ghcr.io/<owner>/asterisk:latest
```

## Running the Container

```bash
docker run -p 5060:5060/udp ghcr.io/<owner>/asterisk:latest
```

Configuration files live in `docker/config` and define a simple IVR that maps digits 1-4 to apartment extensions 201, 202, 301, and 302 via the HT812.

## Tests

Automated tests can be executed with:

```bash
./tests/test_container.sh
```

The script attempts to run the Asterisk container if Docker is available. If Docker is not present, it starts a temporary Asterisk instance directly on the host using the sample configuration.
