from flask import Flask, jsonify
app = Flask(__name__)

@app.get("/")
def hello():
    return jsonify(message="Hello from API"), 200

@app.get("/healthz")
def healthz():
    return "ok", 200

@app.get("/livez")
def livez():
    return "alive", 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
