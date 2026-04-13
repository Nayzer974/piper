from flask import Flask, request, send_file
import subprocess
import uuid
import os

app = Flask(__name__)

@app.post("/tts")
def tts():
    text = request.json.get("text", "")
    out = f"{uuid.uuid4()}.wav"

    subprocess.run([
        "piper",
        "--model", "models/model.onnx",
        "--output", out
    ], input=text, text=True)

    return send_file(out, mimetype="audio/wav")

app.run(host="0.0.0.0", port=8080)
