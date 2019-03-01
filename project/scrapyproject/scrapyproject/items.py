# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# https://doc.scrapy.org/en/latest/topics/items.html

import scrapy


class ScrapyprojectItem(scrapy.Item):
    # define the fields for your item here like:
    # name = scrapy.Field()
    rentalprice_min = scrapy.Field()
    rentalprice_max = scrapy.Field()
    numbed = scrapy.Field()
    num_bath_full = scrapy.Field()
    num_bath_part = scrapy.Field()
    streetaddr = scrapy.Field()
    city = scrapy.Field()
    state = scrapy.Field()
    zipcode = scrapy.Field()
    size = scrapy.Field()
    pref = scrapy.Field()
    latitude = scrapy.Field()
    longitude = scrapy.Field()
    property_type = scrapy.Field()
    garage = scrapy.Field()

    pool = scrapy.Field()
    parking = scrapy.Field()
    gated = scrapy.Field()
    fireplace = scrapy.Field()
    description = scrapy.Field()
    crawl_time = scrapy.Field()
    floortype = scrapy.Field()
