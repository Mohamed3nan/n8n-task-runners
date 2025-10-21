# Start from official n8n runners image
FROM n8nio/runners:1.117.0

USER root

# --- [1] System dependencies you may want ---
RUN apk update && apk add --no-cache \
    ffmpeg \
    curl

# --- [2] Python dependencies (extras) ---
# Install extra runtime-only Python packages. Allow usage in the Code node via
# 'N8N_RUNNERS_EXTERNAL_ALLOW' env variable on n8n-task-runners.json.
COPY extras.txt /app/task-runner-python/extras.txt
RUN cd /opt/runners/task-runner-python && uv pip install -r /app/task-runner-python/extras.txt

# --- [3] Custom task runner configuration ---
# Copy your custom n8n-task-runners.json
COPY n8n-task-runners.json /etc/n8n-task-runners.json


USER runner

