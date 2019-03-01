# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://doc.scrapy.org/en/latest/topics/item-pipeline.html
from scrapy.exporters import JsonItemExporter
import pymysql
from logging import log

class ScrapyprojectPipeline(object):
    def __init__(self, db):
        self.db = db

    @classmethod
    def from_settings(cls, settings):
        dbparams=dict(
            host=settings['MYSQL_HOST'],
            db=settings['MYSQL_DBNAME'],
            user=settings['MYSQL_USER'],
            passwd=settings['MYSQL_PASSWD'],
        )
        db = pymysql.connect(dbparams['host'], dbparams['user'], dbparams['passwd'], dbparams['db'])
        return cls(db)

    def process_item(self, item, spider):
        cursor = self.db.cursor()
        result = None
        sql = "INSERT INTO `rentals_2019` (website, home_url, property_type, latitude, longitude, streetaddr, city, state, zipcode, country, numbed, num_bath_full, num_bath_part, rentalprice_min, rentalprice_max, floortype, garage, size, pool, gatedCommunity, fireplace, description, crawl_time, record_type) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
        #param = ('www.rentals.com', item["pref"], item["property_type"], item["latitude"], item["longitude"], item["streetaddr"], item["city"], item["state"], item["zipcode"], 'United States', item["numbed"], item["num_bath_full"], item["num_bath_part"], item["rentalprice_min"], item["rentalprice_max"], item["floortype"], item["garage"], item["size"], item["pool"], item["gated"], item["fireplace"], item["description"], item["crawl_time"])
        try:
            result = cursor.execute(sql, ('www.rentals.com', item["pref"], item["property_type"], item["latitude"], item["longitude"], item["streetaddr"], item["city"], item["state"], item["zipcode"], 'United States', item["numbed"], item["num_bath_full"], item["num_bath_part"], item["rentalprice_min"], item["rentalprice_max"], item["floortype"], item["garage"], item["size"], item["pool"], item["gated"], item["fireplace"], item["description"], item["crawl_time"], 'rent'))
            self.db.commit()
        except Exception:
            traceback.print_exc()
            self.db.rollback()
        return item

    def spider_closed(self, spider):
        self.db.close()


