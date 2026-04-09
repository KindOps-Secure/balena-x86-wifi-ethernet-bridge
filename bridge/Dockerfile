FROM balenalib/x86_64-debian:latest

RUN install_packages \
    bridge-utils \
    wireless-tools \
    iproute2 \
    iw

COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

CMD ["/usr/local/bin/start.sh"]
