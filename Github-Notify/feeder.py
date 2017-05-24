#!/usr/bin/python3

from bs4 import BeautifulSoup
import json
import time
import feedparser
import os


BASE_URL = "https://github.com/%s.private.atom?token=%s"
with open("config.json", "r") as config:
    CONFIG = json.load(config)
LAST_UPDATE = time.localtime(time.time())


if __name__ == "__main__":
    url = BASE_URL % (CONFIG["username"], CONFIG["rssToken"])
    feeds = feedparser.parse(url)
    while True:
        for feed in feeds.entries:
            if LAST_UPDATE <= feed.updated_parsed:
                LAST_UPDATE = time.localtime(time.time())
                soup = BeautifulSoup(feed.summary, "lxml").text.split("\n")
                notification = ""
                for item in soup:
                    notification += item
                os.system('notify-send -i %s -t %d "%s" "%s"' % (CONFIG["icon"], 10, "Github", notification))
            else:
                break
        time.sleep(30)
