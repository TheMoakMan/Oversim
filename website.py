from flask import Flask, render_template
import functions


app = Flask(__name__)

@app.route('/')
def home_page():
    title = "Oversim, Fantasy Overwatch Simulator"
    desc = functions.desc()
    return render_template('ovs.html', title = title, description = desc)

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

