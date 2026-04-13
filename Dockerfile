FROM debian:stable-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 python3-pip python3-venv git wget unzip \
    && rm -rf /var/lib/apt/lists/*

# Create virtual environment
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Install Python packages inside venv
RUN pip install --no-cache-dir piper-tts flask

WORKDIR /app

# Download Piper model
RUN mkdir models
RUN wget -O models/model.onnx https://huggingface.co/rhasspy/piper-voices/resolve/main/fr/fr_FR/tom/medium/model.onnx
RUN wget -O models/model.onnx.json https://huggingface.co/rhasspy/piper-voices/resolve/main/fr/fr_FR/tom/medium/model.onnx.json

COPY server.py .

EXPOSE 8080

CMD ["python3", "server.py"]
