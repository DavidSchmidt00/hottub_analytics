import requests
from pymongo import MongoClient


class OpenWeatherMap:
    __instance = None

    @staticmethod
    def get_instance():
        if OpenWeatherMap.__instance is None:
            OpenWeatherMap()
        return OpenWeatherMap.__instance

    def __init__(self):
        if OpenWeatherMap.__instance is None:
            OpenWeatherMap.__instance = self
        else:
            raise Exception("You cannot create another OpenWeatherMap object")
        print("OpenWeatherMap object created")
        self.API_KEY = "148b02a293fad6315168c491b88bc5ed"

    def get_temp(self):
        try:
            res = requests.get(
                "https://api.openweathermap.org/data/2.5/weather?zip=65627,DE&appid={}&units=metric".format(self.API_KEY))
            if res.status_code == 200:
                try:
                    return res.json()["main"]["temp"]
                except:
                    pass
        except:
            pass
        return None
