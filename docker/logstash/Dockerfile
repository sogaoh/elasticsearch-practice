FROM logstash:7.5.1

RUN rm -rf /usr/share/logstash/pipeline
COPY logstash/pipeline /usr/share/logstash/pipeline
COPY logstash/mysql-connector-java-8.0.18.jar /usr/share/logstash/mysql-connector-java-8.0.18.jar