""" Stages of the Cross download module.

Uses socket and wget to pull data from the webserver, 
then checks that data against an MD5 checksum to verify integrity of the files.
"""
from socket import gethostname as host
import subprocess

# set the constant url for files to get pulled, using host()
# in order to allow the pi's to use a variable method for pulling
# their specific content
BASE_URL = 'http://sagebrush.support/sotc/' + host() + '/'
files = ["video.m4v","music.wav"]
OUTPUT_DIRECTORY= "/tmp/"

def download():
    """Initiates the get request to pull the data from the web server."""

    for present in files:
        url = BASE_URL + present
        subprocess.run(['wget','-np','-nH','--cut-dirs=1','-P',OUTPUT_DIRECTORY, url],
                        stdout=subprocess.PIPE, stderr=subprocess.PIPE)

        # debugging
        # print(url)
        # out = proc.communicate() # proc is the subprocess.Popen function.
        # print(out)

    # debugging
    # print(BASE_URL)
    # print(out)
    # print(err)

download()
