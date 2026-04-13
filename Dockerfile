FROM debian:stable-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 python3-pip python3-venv git unzip \
    && rm -rf /var/lib/apt/lists/*

# Create virtual environment
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Install Python packages inside venv
RUN pip install --no-cache-dir piper-tts flask

WORKDIR /app

# Copy local model files (no wget)
COPY models models

# Copy server
COPY server.py .

EXPOSE 8080

CMD ["python3", "server.py"]
