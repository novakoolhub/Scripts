# Libraries

import flask
from gevent.pywsgi import WSGIServer
import json

import keyboard
import pyautogui


# Emulator keyboard API

App = flask.Flask(__name__)

@App.route("/", methods=["GET"])

def GetKeys():
    KeyStates = {}
    FailedKeys = []

    for Key in pyautogui.KEYBOARD_KEYS:
        try:
            KeyStates[Key] = keyboard.is_pressed(Key)
        except:
            FailedKeys.append(Key)

    return json.dumps(KeyStates)

HttpServer = WSGIServer(('0.0.0.0', 4888), App)
HttpServer.serve_forever()
