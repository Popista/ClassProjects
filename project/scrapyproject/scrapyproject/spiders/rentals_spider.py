import scrapy
import re
from scrapyproject.items import ScrapyprojectItem
import time
import math
class Rentals_spider(scrapy.Spider):
    name = "rentals"
    allowed_domains = ["rentals.com"]
    start_urls = [
        "https://www.rentals.com"
    ]
    # delay the crawling speed
    custom_settings = {
        'DOWNLOAD_DELAY': 0.15
    }
    # parse the "script" part in the page listing all apartments or houses by using regular expression
    def regexp_list(self, s):
        # "listingPriceHigh":99999,"listingPriceLow":1214
        # prices
        dict = {}
        pattern = re.compile(r"\"listingPriceHigh\":(.+?),")
        rentalprice_max = pattern.findall(s)
        pattern = re.compile(r"\"listingPriceLow\":(.+?),")
        rentalprice_min = pattern.findall(s)
        dict["rentalprice_max"] = rentalprice_max
        dict["rentalprice_min"] = rentalprice_min
        # "listingBedHigh":3,"listingBedLow":1,"listingBathHigh":2,"listingBathLow":1,"halfBaths":0,"unitSqFt":[680]
        # beds
        pattern = re.compile(r"\"listingBedHigh\":(.+?),")
        numbed = pattern.findall(s)
        dict["numbed"] = numbed
        # baths_full
        pattern = re.compile(r"\"listingBathHigh\":(.+?),")
        num_bath_full = pattern.findall(s)
        dict["num_bath_full"] = num_bath_full
        # baths_part
        pattern = re.compile(r"\"halfBaths\":(.+?),")
        num_bath_part = pattern.findall(s)
        dict["num_bath_part"] = num_bath_part

        # "address":"200 Bicentennial Circle","city":"Sacramento","state":"CA","zipCode":"95826"
        # address
        pattern = re.compile(r",\"address\":\"(.+?)\"")
        streetaddr = pattern.findall(s)
        dict["streetaddr"] = streetaddr
        # city
        pattern = re.compile(r"\",\"city\":\"(.+?)\"")
        city = pattern.findall(s)
        dict["city"] = city
        # state
        pattern = re.compile(r"\",\"state\":\"(.+?)\"")
        state = pattern.findall(s)
        dict["state"] = state
        # zipCode
        pattern = re.compile(r"\"zipCode\":\"(.+?)\"")
        zipcode = pattern.findall(s)
        dict["zipcode"] = zipcode
        # size 
        pattern = re.compile(r"\"unitSqFt\":\[(.+?)\]")
        size = pattern.findall(s)
        for i in range(len(size)):
            if not size[i].isdigit():
                size[i] = -1
        dict["size"] = size

        # "listingSeoPath":"Apartments/California/Sacramento/13441/"
        # pref
        pattern = re.compile(r"\"listingSeoPath\":\"(.+?)\"")
        pref = pattern.findall(s)
        for i in range(len(pref)):
            pref[i] = "https://www.rentals.com/" + pref[i]
        dict["pref"] = pref
        ret = []
        # save information into "item" of scrapy
        for i in range(len(dict["pref"])):
            item = ScrapyprojectItem()
            if not dict["rentalprice_min"][i].isdigit():
                item["rentalprice_min"] = -1
            else:
                if int(dict["rentalprice_min"][i]) != 99999:
                    item["rentalprice_min"] = int(dict["rentalprice_min"][i])
                else:
                    item["rentalprice_min"] = -1

            if not dict["rentalprice_max"][i].isdigit():
                item["rentalprice_max"] = -1
            else:
                if int(dict["rentalprice_max"][i]) != 99999:
                    item["rentalprice_max"] = int(dict["rentalprice_max"][i])
                else:
                    item["rentalprice_max"] = -1
            if not dict["numbed"][i].isdigit():
                item["numbed"] = -1
            else:
                item["numbed"] = int(dict["numbed"][i])
            if not dict["num_bath_full"][i].isdigit():
                item["num_bath_full"] = -1
            else:
                item["num_bath_full"] = int(dict["num_bath_full"][i])
            if not dict["num_bath_part"][i].isdigit():
                item["num_bath_part"] = -1
            else:
                item["num_bath_part"] = int(dict["num_bath_part"][i])
            item["streetaddr"] = dict["streetaddr"][i]
            item["city"] = dict["city"][i]
            item["state"] = dict["state"][i]
            if not dict["zipcode"][i].isdigit():
                item["zipcode"] = None
            else:
                item["zipcode"] = int(dict["zipcode"][i])
            item["size"] = int(dict["size"][i])
            item["pref"] = dict["pref"][i]
            ret.append(item)
            # print(item)
        return ret

    # parse the "script" part in the information page of a house or apartment
    def regexp_info(self, script_string, item):
        # latitude
        
        pattern = re.compile(r"\"latitude\":(.+?),")
        latitude = pattern.findall(script_string)
        if not latitude[0]:
            item["latitude"] = None
        else:
            item["latitude"] = float(latitude[0])
        #print(self.dict["latitude"])
        # longitude
        pattern = re.compile(r"\"longitude\":(.+?),")
        longitude = pattern.findall(script_string)
        if not longitude[0]:
            item["longitude"] = None
        else:
            item["longitude"] = float(longitude[0])

        # "listingType":"Apartments"
        pattern = re.compile(r"\"listingType\":\"(.+?)\"")
        listingType = pattern.findall(script_string)
        if not listingType:
            item["property_type"] = None
        else:   
            item["property_type"] = listingType[0]         

        # "garageCount":null
        pattern = re.compile(r"\"garageCount\":(.+?)}")
        garageCount = pattern.findall(script_string)
        if not garageCount[0].isdigit():
            item["garage"] = None
        else:
            item["garage"] = int(garageCount[0])


    count = 0

    def parse(self, response):
        state_string = response.xpath('//a[@data-tag_section="search_by_state"]/@href').extract()
        #print (state_string)
        for i in range(len(state_string)):
            url = "https://www.rentals.com" + str(state_string[i])
            yield scrapy.Request(url, callback=self.parse_state)
    
    def parse_state(self, response):
        city_string = response.xpath('//div[@class="_3RIrS _3RIrS"]/a/@href').extract()
        #print (city_string)
        for i in range(len(city_string)):
            self.visited = set()
            url = "https://www.rentals.com" + str(city_string[i])
            yield scrapy.Request(url, callback=self.parse_city)



    # parse the pages listing all apartments or houses of one given city
    # for example : https://www.rentals.com/Texas/Arlington/
    # for each apartment or house, we can get some basic information of it in this page
    def parse_city(self, response):
        script_string = response.xpath('//script').extract()
        #print(script_string)
        script_string = str(script_string)
        pattern = re.compile(r"\"item\":\{\"@context\":\"(.+?),\"geo\"")
        lists = pattern.findall(script_string)
        for i in range(len(lists)):
            s = lists[i]
   
            pattern = re.compile(r"\"url\":\"(.+?)\"")
            url = pattern.findall(s)[0]

            pattern = re.compile(r"\"postalCode\":\"(.+?)\",")
            zipcode = pattern.findall(s)[0]

            pattern = re.compile(r"\"addressRegion\":\"(.+?)\",")
            state = pattern.findall(s)[0]

            pattern = re.compile(r"\"streetAddress\":\"(.+?)\",")
            address = pattern.findall(s)[0]

            pattern = re.compile(r"\"addressLocality\":\"(.+?)\",")
            city = pattern.findall(s)[0]


            tmpaddress = address + "," + city
            if tmpaddress in self.visited:
                continue
            self.visited.add(tmpaddress)
            item = ScrapyprojectItem()
            item["city"] = city
            item["streetaddr"] = address
            item["state"] = state
            if not zipcode.isdigit():
                item["zipcode"] = None
            else:
                item["zipcode"] = int(zipcode)
            item["pref"] = url    
            yield scrapy.Request(url, meta={'item': item}, callback=self.parse_house_info_page)
            #print (url)
        #script_string = response.xpath('//script').extract()
        #print(script_string)
        #script_string = str(script_string)
        #l = self.regexp_list(script_string)
        #print(dict["pref"])

#        for i in range(len(l)):
#            item = l[i]
#            yield scrapy.Request(str(item["pref"]), meta={'item': item}, callback=self.parse_house_info_page)

        # do something here...
        # data is in dict
        #print(dict.keys())
        next_page = response.xpath('//link[@rel="next"]/@href').extract()
        #print(next_page)
        if next_page and next_page != []:
            url = next_page[0]
            yield scrapy.Request(str(url), callback=self.parse_city)
            self.count += 1

    # parse the page when we click into one apartment or house to see more specific information of it
    # for example : https://www.rentals.com/Apartments/Texas/Arlington/2037236/
    def parse_house_info_page(self, response):
        item = response.meta["item"]
        price = response.xpath('//div[@class="_2EN5B"]/text()').extract()
        price = "".join(price)
        price = re.findall(r"\d+\.?\d*", price.replace(",", ""))
        item["rentalprice_min"] = -1
        item["rentalprice_max"] = -1
        if len(price) == 2:
            item["rentalprice_min"] = int(price[0])
            item["rentalprice_max"] = int(price[1])
        elif len(price) == 1:
            item["rentalprice_min"] = int(price[0])
        bb = response.xpath('//span[@data-tid="bed_bath_section"]/text()').extract()
        bb = bb[0].split(",")
        beds = None
        baths = None
        if len(bb) == 2:
            beds = re.findall(r"\d+\.?\d*", bb[0])
            baths = re.findall(r"\d+\.?\d*", bb[1])
        elif len(bb) == 1:
            if "bed" in bb[0]:
                beds = re.findall(r"\d+\.?\d*", bb[0])
            elif "bath" in bb[0]:
                baths = re.findall(r"\d+\.?\d*", bb[0])
        if beds:
            item["numbed"] = int(beds[-1])
        else:
            item["numbed"] = -1
        item["num_bath_full"] = -1
        item["num_bath_part"] = -1
        if baths:
            if len(baths) == 2:
                item["num_bath_full"] = int(baths[-1])
            elif len(baths) == 1:
                tmpbath = float(baths[0])
                decimal = math.modf(tmpbath)
                if decimal[0] > 0.0:
                    item["num_bath_part"] = 1
                else:
                    item["num_bath_part"] = -1
                item["num_bath_full"] = int(decimal[1])
        size = response.xpath('//span[@data-tid="area_in_sqft"]/text()').extract()
        size = "".join(size)
        size = re.findall(r"\d+\.?\d*", size.replace(",", ""))
        if size != []:
            item["size"] = int(size[0])
        else:
            item["size"] = -1

        exterior = response.xpath('//div[@data-tid="Exterior_Features"]/text()').extract()
        item["pool"] = 0
        for i in exterior:
            if i.lower() == "pool":
                item["pool"] = 1
        interior = response.xpath('//div[@data-tid="Interior_Features"]/text()').extract()
        item["fireplace"] = 0
        for i in interior:
            if i.lower() == "fireplace":
                item["fireplace"] = 1
        item["parking"] = None
        tmp = response.xpath('//span[@data-tid="Parking"]/text()').extract()
        if tmp:
            item["parking"] = tmp[0]
        item["description"] = None
        tmp = response.xpath('//div[@data-tid="listing_text"]/text()').extract()
        if tmp:
            item["description"] = tmp[0]
        community = response.xpath('//div[@data-tid="Community_Features"]/text()').extract()
        item["gated"] = 0
        for i in community:
            if "gated" in i.lower():
                item["gated"] = 1
        item["crawl_time"] = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime(time.time()))
        

        script_string = response.xpath('//script').extract()
        #print(script_string)
        script_string = str(script_string)
        self.regexp_info(script_string, item)
        self.count += 1
        print(self.count)
        floortype = response.xpath('//div[@class="_1Tr-v"]/text()').extract()
        # for the apartments, record the floortype
        if floortype != []:
            pattern = re.compile(r"\"listingsWithFloorPlan\":\[(.+?)\]")
            tmp = pattern.findall(script_string)
            tmp = tmp[0]
            t = tmp.split("},{")
            for i in t:
                if i != "":
                    pattern = re.compile(r"\"bathLow\":\"(.+?)\"")
                    bathLow = pattern.findall(i)
                    if bathLow != []:
                        item["num_bath_full"] = int(bathLow[0])

                    pattern = re.compile(r"\"bedLow\":\"(.+?)\"")
                    bedLow = pattern.findall(i)
                    if bedLow != []:
                        item["numbed"] = int(bedLow[0])

                    pattern = re.compile(r"\"halfBaths\":(.+?),")
                    halfBaths = pattern.findall(i)
                    if halfBaths != [] and halfBaths[0].isdigit():
                        item["num_bath_part"] = int(halfBaths[0])

                    pattern = re.compile(r"\"priceLow\":(.+?),")
                    priceLow = pattern.findall(i)
                    if priceLow != [] and int(priceLow[0]) != 99999:
                        item["rentalprice_min"] = int(priceLow[0])
                    else:
                        item["rentalprice_min"] = -1

                    pattern = re.compile(r"\"priceHigh\":(.+?),")
                    priceHigh = pattern.findall(i)
                    if priceHigh != [] and int(priceHigh[0]) != 99999:
                        item["rentalprice_max"] = int(priceHigh[0])
                    else:
                        item["rentalprice_max"] = -1

                    pattern = re.compile(r"\"planSqFt\":\"(.+?)\"")
                    planSqFt = pattern.findall(i)
                    if planSqFt != []:
                        if planSqFt[0].isdigit():
                            item["size"] = int(planSqFt[0])
                        else:
                            item["size"] = int(planSqFt[0].split("-")[0])

                    pattern = re.compile(r"\"inventoryStyle\":\"(.+?)\"")
                    inventoryStyle = pattern.findall(i)
                    if inventoryStyle != []:
                        item["floortype"] = inventoryStyle[0]
                    else:
                        item["floortype"] = None
                    yield item
                    #print(item)

        else:
            item["floortype"] = None
            yield item
            #print(item)




