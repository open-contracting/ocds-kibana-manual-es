FROM docker.elastic.co/logstash/logstash-oss:6.4.0

USER root
RUN yum install epel-release -y && yum install jq -y
RUN mkdir -p /data /logs && chown -R logstash:logstash /data /logs

USER logstash
COPY pipeline.conf /usr/share/logstash/pipeline/logstash.conf
COPY template.json /opt/template.json
COPY entrypoint.sh /opt/entrypoint.sh

ENTRYPOINT ["bash", "/opt/entrypoint.sh"]
