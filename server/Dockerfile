# Use a lightweight base with mosquitto clients
FROM alpine:latest

# Install mosquitto-clients (for mosquitto_pub and mosquitto_sub)
RUN apk add --no-cache mosquitto-clients bash

# Set working directory
WORKDIR /app

# Default command: interactive bash shell
CMD ["/bin/bash"]