FROM debian:trixie

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

RUN apt-get -y install ansible python3-apt

COPY ansible/* /etc/ansible/

RUN ansible-playbook -i "localhost," -c local /etc/ansible/site.yml

RUN apt-get -y remove ansible python-apt;apt-get -y autoremove

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 80

EXPOSE 443

CMD ["apache2-reverse-proxy"]
