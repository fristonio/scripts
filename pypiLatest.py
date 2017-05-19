#!/usr/bin/python3
import requests
from bs4 import BeautifulSoup
import argparse

BASE_URL = "https://pypi.python.org/pypi?%saction=search&term=%s&submit=search"
CGREEN = '\33[32m'
CBLUE = '\33[34m'
CEND = '\33[0m'


def printPackages(packages):
    print(" [*] Available version of the package")
    for package in packages:
        if package[2] == "actual":
            print(CGREEN + " [+] %s  :  %s" % (package[0], package[1]) + CEND)
        else:
            if package[2] == "matching":
                print(CBLUE + " [+] %s  :  %s" % (package[0], package[1]) + CEND)
            else:
                print(" [+] %s  :  %s" % (package[0], package[1]))


def verifyPackage(package, searchTerm):
    if searchTerm == package[0]:
        package.append("actual")
        return True, package

    if searchTerm.lower() == package[0].lower():
        package.append("matching")
        return True, package

    if searchTerm.lower() == package[0][:len(searchTerm)].lower():
        package.append("relevent")
        return True, package

    return False, package


def getLatestPyPi(searchTerm):
    url = BASE_URL % ("%3A", searchTerm)
    res = requests.get(url)
    soup = BeautifulSoup(res.text, "lxml")
    packageTable = soup.find("table", {"class": "list"})
    packageList = packageTable.find_all("tr")
    matchingPackage = []
    i = 1
    skip = True
    for package in packageList:
        if skip:
            skip = False
        else:
            if i < 6:
                packageData = package.find("td").find("a").text.split("\xa0")
                verified, packageData = verifyPackage(packageData, searchTerm)
                if verified:
                    matchingPackage.append(packageData)
                    i += 1
    printPackages(matchingPackage)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("-p", "--package", help="Add the name of package you want to search for", required=True)
    args = parser.parse_args()
    getLatestPyPi(args.package)
