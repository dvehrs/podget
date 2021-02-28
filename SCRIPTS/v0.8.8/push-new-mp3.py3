#!/usr/bin/env python3
#https://stackoverflow.com/questions/16953842/using-os-walk-to-recursively-traverse-directories-in-python
#given a folder name, walk through its entire hierarchy

import os, time, http.client, urllib
now = time.time()
nowLess24h = time.time() - (48*60*60) #48 hours
podList = []

def recursive_walk(folder):
    global podList
    for folderName, subfolders, filenames in os.walk(folder):
        if subfolders:
            for subfolder in subfolders:
                recursive_walk(subfolder)
        created = os.path.getctime(folderName)
        if created <= now and created >= nowLess24h:
            #print(folderName, created)
            lenFolderName = len(folderName) 
            folderName = (folderName[13:lenFolderName])
            if folderName != ".LOG" and folderName != "m3u-tmp":
                #print(folderName)
                podList.append(folderName)

recursive_walk('/home/pi/POD/') #where your podcast's are located)

podsStr = "<font color='#ff8000'><b>Last 48h pod Casts</b></font>" + chr(int(10)) + ''.join(str(e) + chr(int(10)) for e in podList) #the font etc stuff is to give a coloured heading to the Pushover list of podcasts
#print(podsStr)
PUSH_MSG =  podsStr

#setup pushover API
app_key = "xxx"
user_key = "yyy"

#This function sends the push message using Pushover.
def sendPush(PUSH_MSG):
   conn = http.client.HTTPSConnection("api.pushover.net:443")
   conn.request("POST", "/1/messages.json",
      urllib.parse.urlencode({
         "token": app_key,
         "user": user_key,
         "message": PUSH_MSG,
         "html": 1,
         "sound": "tugboat"
      }), { "Content-type": "application/x-www-form-urlencoded" })

   conn.getresponse()
   return
   
# Run function to send message to Pushover
sendPush(PUSH_MSG)

