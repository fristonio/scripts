#!/usr/bin/python3
import requests
from bs4 import BeautifulSoup
import argparse

BASE_URL = "https://pypi.python.org/pypi?%saction=search&term=%s&submit=search"


def printPackages(packages):
    print(" [*] Available version of the package")
    for package in packages:
        print(" [+] %s  :  %s" % (package[0], package[1]))


def verifyPackage(package, searchTerm):
    if searchTerm.lower() == package[0][:len(searchTerm)].lower():
        return True
    return False


def getLatestPyPi(searchTerm):
    url = BASE_URL % ("%3A", searchTerm)
    res = requests.get(url)
    soup = BeautifulSoup(res.text, "lxml")
    table = soup.find("table", {"class": "list"})
    packageList = table.find_all("tr")
    matchingPackage = []
    i = 1
    skip = True
    for package in packageList:
        if skip:
            skip = False
        else:
            if i < 6:
                pack = package.find("td").find("a").text.split("\xa0")
                if verifyPackage(pack, searchTerm):
                    matchingPackage.append(pack)
                    i += 1
    printPackages(matchingPackage)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("-p", "--package", help="Add the name of package you want to search for", required=True)
    args = parser.parse_args()
    getLatestPyPi(args.package)
