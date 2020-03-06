# Test trace with v7

The current code requires Java v9 which cannot be installed in macOS.

## Start Datadog Agent

```sh
docker run -d --rm --name dd-agent-test \
  -v /var/run/docker.sock:/var/run/docker.sock:ro \
  -v /proc/:/host/proc/:ro \
  -v /sys/fs/cgroup/:/host/sys/fs/cgroup:ro \
  -e DD_API_KEY=${DD_API_KEY} \
  -e DD_APM_ENABLED=true \
  -e DD_APM_DD_URL=https://trace.agent.datadoghq.eu \
  -p 8126:8126/tcp \
  -e DD_LOG_LEVEL=DEBUG \
  datadog/agent:7
```

Get IP

```sh
DD_AGENT_IP_ADDR=`docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' dd-agent-test`
```

Run to start the container:

```
docker run -d -p 8081:8080 --rm --name dd-java-apm dd-java-example \
-e TAGS=host:dd-java-apm-demo-openjdk,env:demo -e DD_AGENT_IP=${DD_AGENT_IP_ADDR}
```
