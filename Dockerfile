FROM openjdk:12
ARG DD_AGENT_IP
ENV DD_IP=${DD_AGENT_IP}

# copy over our app
WORKDIR /app
# COPY build/libs/gs-spring-boot-docker-0.1.0.jar /app
COPY build/libs/datadog-java-apm-example.jar /app
# Might be hacky -- dunno
# https://github.com/DataDog/dd-trace-java/releases
COPY datadog/dd-java-agent-0.43.0.jar /app/dd-java-agent.jar

# Fix for https://stackoverflow.com/questions/6784463/error-trustanchors-parameter-must-be-non-empty
# CMD sudo /var/lib/dpkg/info/ca-certificates-java.postinst configure
# NOTE: @ckelner: https://github.com/docker-library/openjdk/issues/145 switch to slim

EXPOSE 8080

# use shell form of entrypoint rather than exec so we can take advantage of variables
ENTRYPOINT java -javaagent:/app/dd-java-agent.jar -Ddd.service.name=dd-java-apm-example-openjdk -Ddd.agent.host=$DD_IP -Ddatadog.slf4j.simpleLogger.defaultLogLevel=debug -jar /app/datadog-java-apm-example.jar
