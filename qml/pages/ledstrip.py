# -*- coding: utf-8 -*-
"""
Created on Thu Sep 22 15:41:49 2016
@author: Dylan Van Assche
@title: ledstrip handler

   This file is part of RGBWiFi.

   RGBWiFi is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   RGBWiFi is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with RGBWiFi.  If not, see <http://www.gnu.org/licenses/>.

"""

import requests
import pyotherside

def rgb(red, green, blue, ip):
    red = int(red)
    green = int(green)
    blue = int(blue)
    requests.get("http://{0}/red/{1}".format(ip, str(red)))
    requests.get("http://{0}/green/{1}".format(ip, str(green)))
    requests.get("http://{0}/blue/{1}".format(ip, str(blue)))
    pyotherside.send('result', '[INFO] RED={0} GREEN={1} BLUE={2}'.format(str(red), str(green), str(blue)))
