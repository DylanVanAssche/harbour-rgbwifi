# -*- coding: utf-8 -*-
"""
Created on Thu Sep 22 15:41:49 2016

@author: dylan
"""

import requests
import pyotherside

def rgb(red, green, blue):
    red = int(red)
    green = int(green)
    blue = int(blue)
    requests.get("http://192.168.1.33/red/" + str(red))
    requests.get("http://192.168.1.33/green/" + str(green))
    requests.get("http://192.168.1.33/blue/" + str(blue))
    pyotherside.send('result', '[INFO] RED=' + str(red) + ' GREEN=' + str(green) + ' BLUE=' + str(blue))