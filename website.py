from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
    return "Welcome to Oversim Fantasy Overwatch Simulator"

@app.route('/login')
def login_page():
    return "Please enter a username and password:"

@app.route('/teams')
def teams_page():
    return "Teams"

@app.route('/play')
def play_page():
    return "Simulation Page"

@app.route('/account')
def account_info():
    return "Account Info"

@app.route('/players')
def players_page():
    return "Players Page"

@app.route('/heroes')
def heroes_page():
    return "All heroes up to patch 0.0.0"

if __name__ == '__main__':
    app.run()

