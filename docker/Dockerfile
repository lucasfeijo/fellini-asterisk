FROM debian:bullseye-slim
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y asterisk && \
    rm -rf /var/lib/apt/lists/*
COPY config/ /etc/asterisk/
CMD ["/usr/sbin/asterisk", "-f", "-U", "asterisk", "-vvv"]
