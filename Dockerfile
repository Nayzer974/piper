FROM debian:stable-slim

RUN apt-get update && apt-get install -y \
    python3 python3-pip git wget unzip \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install piper-tts flask

WORKDIR /app

# Téléchargement du modèle Piper FR (Tom Medium)
RUN mkdir models
RUN wget -O models/model.onnx https://huggingface.co/rhasspy/piper-voices/resolve/main/fr/fr_FR/tom/medium/model.onnx
RUN wget -O models/model.onnx.json https://huggingface.co/rhasspy/piper-voices/resolve/main/fr/fr_FR/tom/medium/model.onnx.json

COPY server.py .

EXPOSE 8080

CMD ["python3", "server.py"]
