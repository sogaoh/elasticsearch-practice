FROM logstash:7.6.0

RUN rm -rf /usr/share/logstash/pipeline
COPY logstash/pipeline /usr/share/logstash/pipeline
COPY logstash/mysql-connector-java-8.0.19.jar /usr/share/logstash/mysql-connector-java-8.0.19.jar