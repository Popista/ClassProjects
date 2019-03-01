import pymysql
from math import sin, asin, cos, radians, fabs, sqrt
EARTH_RADIUS = 6371
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

    return distance * 0.62137

# Los Angeles
# citylat = 34.040968
# citylong = -118.244942
# state = "CA"
# cityname = "Los Angeles"

# Riverside
# 33.986904, -117.378117
citylat = 33.986904
citylong = -117.378117
state = "CA"
cityname = "Riverside"

db = pymysql.connect("localhost","ylai017","2312rentals","homeDB")
cursor = db.cursor(pymysql.cursors.DictCursor)
sql = "select rentalprice_min, rentalprice_max, latitude, longitude from rentals_2019 where crawl_time >= '2019-01-31 00:00:00' and state = %s and city = %s"
import collections
res = collections.defaultdict(list)
data = cursor.execute(sql, (state, cityname))

for _ in range(data):
    info = cursor.fetchone()
    rentalprice_min = info['rentalprice_min']
    rentalprice_max = info['rentalprice_max']
    latitude = info['latitude']
    longitude = info['longitude']
    dis = get_distance_hav(citylat, citylong, latitude, longitude)
    if dis > 20:
         continue
    if rentalprice_min != -1 and rentalprice_max != -1:
        price = (rentalprice_min + rentalprice_max) / 2
    elif rentalprice_min != -1:
        price = rentalprice_min
    elif rentalprice_max != -1:
        price = rentalprice_max
    else:
        continue
    # 0-5, 6-10, 11-15, 16-20
    if dis <= 5:
        res["0-5"].append(price)
    elif 6 <= dis <= 10:
        res["6-10"].append(price)
    elif 11 <= dis <= 15:
        res["11-15"].append(price)
    elif 16 <= dis <= 20:
        res["16-20"].append(price)
if res["0-5"]:
    print ("0-5:")
    print ("# of houses: " + str(len(res["0-5"])))
    print ("Highest price: " + str(max(res["0-5"])) + " Lowest price: " + str(min(res["0-5"])) + " Average price: " + str(sum(res["0-5"]) / len(res["0-5"])))

if res["6-10"]:
    print ("6-10:")
    print ("# of houses: " + str(len(res["6-10"])))
    print ("Highest price: " + str(max(res["6-10"])) + " Lowest price: " + str(min(res["6-10"])) + " Average price: " + str(sum(res["6-10"]) / len(res["6-10"])))

if res["11-15"]:
    print ("11-15:")
    print ("# of houses: " + str(len(res["11-15"])))
    print ("Highest price: " + str(max(res["11-15"])) + " Lowest price: " + str(min(res["11-15"])) + " Average price: " + str(sum(res["11-15"]) / len(res["11-15"])))

if res["16-20"]:
    print ("16-20:")
    print ("# of houses: " + str(len(res["16-20"])))
    print ("Highest price: " + str(max(res["16-20"])) + " Lowest price: " + str(min(res["16-20"])) + " Average price: " + str(sum(res["16-20"]) / len(res["16-20"])))
        
