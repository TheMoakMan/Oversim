from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
    return "Welcome to Oversim Fantasy Overwatch Simulator"

@app.route('/login')
def login():
    return "Please enter a username and password:"

if __name__ == '__main__':
    app.run()

