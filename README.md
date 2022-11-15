# Simaple Use
docker-compose.yaml
```yaml
version: '3'

services:
  tuic-server:
    image: lisonfan/tuic-server:{{ tag }}
    network_mode: {{ network mode }}
    command: -c /path/to/you/config.json
    volumes:
      - /path/to/you/config.json:/path/to/you/config.json
```