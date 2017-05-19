#!/usr/bin/python3
import requests
from bs4 import BeautifulSoup
import argparse
import os

PYPI_BASE_URL = "https://pypi.python.org/pypi/%s"
BASE_URL = "https://pypi.python.org/pypi?%saction=search&term=%s&submit=search"
CGREEN = '\33[32m'
CBLUE = '\33[34m'
CEND = '\33[0m'


class pypiLatest:
    matchingPackages = []
    actualSearchTerm = None

    def parsePackageList(self, response):
        soup = BeautifulSoup(response.text, "lxml")
        packageList = soup.find("table", {"class": "list"}).find_all("tr")
        packageArray = []
        pack = []
        for package in packageList:
            try:
                pack = package.find("a").text.split("\xa0")
            except:
                pass
            if len(pack) == 2:
                packageArray.append(pack)
        return packageArray

    def printPackages(self):
        print(" [*] Available version of the package")
        for package in self.matchingPackages:
            if package[2] == "actual":
                print(CGREEN + " [+] %s  :  %s" % (package[0], package[1]) + CEND)
            else:
                if package[2] == "matching":
                    print(CBLUE + " [+] %s  :  %s" % (package[0], package[1]) + CEND)
                else:
                    print(" [+] %s  :  %s" % (package[0], package[1]))
        del self.matchingPackages[:]

    def verifyPackage(self, package, searchTerm):
        try:
            if self.actualsearchTerm == package[0]:
                return False, package
        except:
            pass
        if searchTerm == package[0]:
            package.append("actual")
            return True, package

        if searchTerm.lower() == package[0][:len(searchTerm)].lower():
            package.append("matching")
            return True, package

        return False, package

    def handleActualUrl(self, res):
        packageList = self.parsePackageList(res)
        i = 0
        for package in packageList:
            if i > 1:
                break
            package.append("actual")
            self.matchingPackages.append(package)
            i += 1

    def searchPyPi(self, searchTerm):
        url = BASE_URL % ("%3A", searchTerm)
        res = requests.get(url)
        packageList = self.parsePackageList(res)
        i = 0
        for package in packageList:
            if i > 2:
                break
            verified, packageData = self.verifyPackage(package, searchTerm)
            if verified:
                if len(packageData) == 3:
                    self.matchingPackages.append(packageData)
                    i += 1

    def getLatestPyPi(self, searchTerm):
        url = PYPI_BASE_URL % (searchTerm)
        res = requests.get(url, allow_redirects=True)
        if res.status_code == "404":
            self.searchPyPi(searchTerm)
        else:
            self.actualSearchTerm = res.url.split("/pypi/")[1]
            self.handleActualUrl(res)
            self.searchPyPi(searchTerm)

        self.printPackages()

    def checkPackageFromFile(self, filePath):
        with open(filePath, "r") as file:
            fileContent = file.read().split("\n")
            for package in fileContent:
                try:
                    package = package.split("==")
                    print("\n [+] PACKAGE : %s >> currentVersion %s" % (package[0], package[1]))
                    self.getLatestPyPi(package[0].strip())
                except:
                    pass


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("-p", "--package", help="Add the name of package you want to search for")
    parser.add_argument("-f", "--file", help="Add the name of the requirements.txt file corresponding to this flag")
    args = parser.parse_args()
    pypi = pypiLatest()
    if args.package:
        pypi.getLatestPyPi(args.package)
    else:
        if args.file:
            if args.file[:1] == "/":
                try:
                    os.stat(args.file)
                    pypi.checkPackageFromFile(args.file)
                except Exception as e:
                    print(" [+] Entered path is not valid..  Enter a valid Path" + e.message)
            else:
                path = "%s/%s" % (os.getcwd(), args.file)
                print(" [+] Provided file path is  : %s" % path)
                pypi.checkPackageFromFile(path)
