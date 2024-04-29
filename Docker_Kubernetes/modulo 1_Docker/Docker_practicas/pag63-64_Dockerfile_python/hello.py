from flask import Flask
app = Flask(__name__)
@app.route("/")
def hello():
    return "welcome to Dockerlabs!! successfully done !!"
if __name__ == "__main__":
        app.run()
