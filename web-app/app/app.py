from flask import Flask, session
from flask_session import Session

app = Flask(__name__)

SESSION_TYPE = 'filesystem'
app.config.from_object(__name__)
Session(app)

@app.route('/')
def helloworld():

    if not "last" in session:
        session["last"]=True

    result = session["last"]

    if result:
       session["last"] = False
       print(session["last"])
       return "hello"
    else:
        session["last"] = True
        print(session["last"])
        return "world"




if __name__ == '__main__':
    app.run()