 # Scripts
 
 > A collection of my scripts.
 
 ## setuptScript :

 * A setup script to install and setup all the packages i use.
 * Usage :
    * `sudo ./setupScript.sh`
 ## starterScript :

 * A starter setup script including only starter packages, helpful while setting up a cloud server.
    * `sudo ./starterScript.sh
 ## pypiLatest :

 * A python script that list lastest version available for python package provided
 * Usage : 
    * For a package : `python3 pypiLatest.py -p [PackageName]`
    * For requirements file : `python3 pypiLatest.py -f [filePath(absolute/relative)]`
 * Screenshots :
    ![pypiLatestSS](https://github.com/fristonio/scripts/blob/master/screenshots/pypiLatest.png)
 
 ## Github-Notify :

 * A simple python scripts that send you notification whenever your feeds for github changes
 * Usage:
    * Download Script, Add config.json using sample.config.json Get your token by subscribing to github RSS feeds
    * Run `nohup ./feeder.py > /dev/null 2>&1 &` to run the program in background
    * Add the command in cronJob @reboot to get it running every time you log in 

