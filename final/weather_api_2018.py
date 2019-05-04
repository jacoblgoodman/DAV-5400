# -*- coding: utf-8 -*-
"""
this is a script that builds a daily weather dataframe with the darksky api  
"""

#packages
import requests # to make calls
import pandas as pd #to make dataframe once calls are done
from datetime import timedelta, date # to formate dates for calls
import time as ti #for introducing delay in script
#base api url
url = 'https://api.darksky.net/forecast/'
#key 
api = '0afa37ac1d3b32df4539e21c51e9eae8'

#location of ny 
lat = '40.7831'
long = '-73.9712'

start_date = date(2018,1,1) #inclusive
end_date = date(2019,1,1) #exclusive
time='T12:00:00' #required for call set to midday
#length
days = [start_date + timedelta(n) for n in range((end_date-start_date).days)]
data = []

for day in days:
    call = f'{url}{api}/{lat},{long},{day.isoformat()}{time}?exclude=hourly,minutely,currently'
    re = requests.get(call)
    record = re.json()['daily']['data']
    record[0]['date'] = day
    data.append(record[0])
    ti.sleep(.25)

df = pd.DataFrame(data)
df.to_csv('weather.csv', index = False )