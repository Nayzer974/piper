from flask import Flask, request, send_file
import subprocess
import uuid
import os

app = Flask(__name__)

MODELS = {
    "fr": "models/fr_FR-tom-medium.onnx",
    "ar": "models/ar_JO-kareem-medium.onnx"
}

@app.post("/tts")
def tts():
    data = request.json
    text = data.get("text", "")
    lang = data.get("lang", "fr")  # "fr" par défaut

    model = MODELS.get(lang, MODELS["fr"])

    out = f"{uuid.uuid4()}.wav"

    subprocess.run([
        "piper",
        "--model", model,
        "--output", out
    ], input=text, text=True)

    return send_file(out, mimetype="audio/wav")

app.run(host="0.0.0.0", port=8080)
