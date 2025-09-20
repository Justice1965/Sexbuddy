from flask import Flask, request
from waitress import serve
import logging

# --- Configure logging ---
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
    handlers=[logging.StreamHandler()]
)

# --- Initialize Flask app ---
app = Flask(__name__)

# --- Example route ---
@app.route("/", methods=["GET"])
def home():
    logging.info(f"Received request from {request.remote_addr}")
    return "Hello! Your Flask app is running via Tailscale.", 200

# --- Additional route example ---
@app.route("/status", methods=["GET"])
def status():
    logging.info(f"Status checked by {request.remote_addr}")
    return {"status": "running"}, 200

# --- Start the app with Waitress ---
if __name__ == "__main__":
    logging.info("Starting Flask app on 127.0.0.1:3000")
    serve(app, host="127.0.0.1", port=3000)
