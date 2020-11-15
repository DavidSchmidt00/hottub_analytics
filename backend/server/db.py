from pymongo import MongoClient


class Database:
    __instance = None

    @staticmethod
    def get_instance():
        if Database.__instance is None:
            Database()
        return Database.__instance

    def __init__(self):
        if Database.__instance is None:
            Database.__instance = self
        else:
            raise Exception("You cannot create another Database object")
        print("Database object created")
        self.client = MongoClient('mongodb://database:27017/')

    def get_database(self):
        if self.client:
            return self.client.badefass
