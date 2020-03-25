#! /usr/bin/python

import os
import re
import sys
import subprocess

def main():
    ##if os.path.isfile('./env/bin/activate'):
    text = subprocess.check_output(['git', 'status'])
    # r makes it a raw string and doesnt parse backslash escapes
    # otherwise it would have to be [^\\\\t]

    # ignore all tabs, newlines, and spaces before any python path to file
    # make / optional and allows for multiple dirs
    result = re.findall(r'[^\t|^\n|^\s+][\w+/?]+\w+.py', str(text))

    for r in result:
        print("-----"+r+"-----")
        if os.path.isfile(r):
            subprocess.call(['flake8', r])
            print("")
        else:
            print("Does not exist")

main()
