
from flask import Flask, render_template, request, redirect, url_for

app = Flask(__name__)

# Temporary storage for reported incidents
incidents = []

@app.route("/")
def index():
    return render_template("index.html", incidents=incidents)

@app.route("/incidents", methods=["POST"])
def create_incident():
    title = request.form.get("title", "").strip()
    description = request.form.get("description", "").strip()
    severity = request.form.get("severity", "Low").strip()

    if title and description and severity in ["Low", "Medium", "High", "Critical"]:
        incidents.append({
            "title": title,
            "description": description,
            "severity": severity
        })

    return redirect(url_for("index"))

@app.route("/health")
def health():
    return {"status": "healthy"}, 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=False)
