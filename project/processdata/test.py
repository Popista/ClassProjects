import pymysql
import time
from math import sin, asin, cos, radians, fabs, sqrt
import usaddress

EARTH_RADIUS=6371          
 
def hav(theta):
    s = sin(theta / 2)
    return s * s
 
def get_distance_hav(lat0, lng0, lat1, lng1):

    lat0 = radians(lat0)
    lat1 = radians(lat1)
    lng0 = radians(lng0)
    lng1 = radians(lng1)
 
    dlng = fabs(lng0 - lng1)
    dlat = fabs(lat0 - lat1)
    h = hav(dlat) + cos(lat0) * cos(lat1) * hav(dlng)
    distance = 2 * EARTH_RADIUS * asin(sqrt(h))
 
    return distance

db = pymysql.connect("localhost","ylai017","2312rentals","homeDB")
 
cursor = db.cursor(pymysql.cursors.DictCursor)
cursor2 = db.cursor(pymysql.cursors.DictCursor)
cursor3 = db.cursor(pymysql.cursors.DictCursor)
cursor4 = db.cursor()
sql = "select streetaddr, latitude, longitude from `rentals_2019` where state = %s"
sql2 = "select distinct latitude, longitude, yearbuilt, home_url from `homeTrulia_2018` where state = %s and streetaddr like %s"
sql3 = "select state_code from states"
sql4 = "update `rentals_2019` set yearbuilt = %s, trulia_url = %s where streetaddr = %s"
c = cursor3.execute(sql3)
for _ in range(c):
    info3 = cursor3.fetchone()
    state = info3['state_code']
    a = cursor.execute(sql, (state))
    print (state + " " + str(a))
    count = 0
    visited = set()
    for row in range(a):
        info = cursor.fetchone()
        addr = info['streetaddr']
        if addr in visited:
            continue
        visited.add(addr)
        lat1 = info['latitude']
        lon1 = info['longitude']
        try:
            tmp = usaddress.tag(addr)[0]
        except:
            continue
        if tmp:
                #print (tmp)
            if 'AddressNumber' in tmp and 'StreetName' in tmp:
                tstreetaddr = tmp['AddressNumber'] + "%" + tmp['StreetName'] + "%"
            elif 'AddressNumber' in tmp and 'StreetName' not in tmp and 'StreetNamePreType' in tmp:
                tstreetaddr = tmp['AddressNumber'] + "%" + tmp['StreetNamePreType'] + "%"
            else:
                continue
            b = cursor2.execute(sql2, (state, tstreetaddr))
            for row2 in range(b):
                info2 = cursor2.fetchone()
                lat2 = info2['latitude']
                lon2 = info2['longitude']
                year = info2['yearbuilt']
                url = info2['home_url']
                if get_distance_hav(lat1, lon1, lat2, lon2) <= 2:
                    count += 1
                    if year != None:
                        print (str(year))
                    print (str(lat2) + " " + str(lon2)  + " " + url)
                    print (addr)
                    try:
                        d = cursor4.execute(sql4, (year, url, addr)) 
                        #print (str(d) + " row changed")
                        db.commit()
                        print (str(d) + " row changed")
                    except Exception:
                        print (-1)
                        traceback.print_exc()
                        db.rollback()
                        break
    print(count)
db.close()





# print (get_distance_hav(39.188840, -120.117590, 39.189192,-120.1188277))


