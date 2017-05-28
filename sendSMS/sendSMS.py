#!/usr/bin/python3

import requests
import json

BASE_URL = "http://site23.way2sms.com/Login1.action"
SMS_URL = "http://site23.way2sms.com/smstoss.action"
SESSION = requests.Session()


def getConfig():
    with open("config.json", "r") as file:
        config = json.load(file)
    return config


def getAuthenticationToken(CONFIG):
    postData = {
        'username': CONFIG["User"],
        'password': CONFIG["Password"]
    }
    res = SESSION.post(BASE_URL, data=postData, allow_redirects=True)
    authToken = res.request.headers["cookie"].split("~")[1]
    return authToken


def sendMsg(token, msg, recipient):
    postData = {
        "ssaction": "ss",
        "Token": token,
        "mobile": recipient,
        "message": msg,
        "msgLen": len(msg)
    }
    r = SESSION.post(SMS_URL, data=postData, allow_redirects=True)
    return r.status_code


if __name__ == "__main__":
    CONFIG = getConfig()
    token = getAuthenticationToken(CONFIG)
    msg = input(" Enter Your Msg (140 chars max)  : : \n")
    recipient = input("Enter the recipient No :: ")
    status = sendMsg(token, msg, recipient)
    if status == 200:
        print("[+] The msg has been sent successfully")
    else:
        print("[-] There was an error while sending the message")
