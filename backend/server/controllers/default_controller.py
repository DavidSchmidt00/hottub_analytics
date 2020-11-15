import datetime
import json

import connexion
import six

from server.models.heating import Heating  # noqa: E501
from server.models.temperature import Temperature  # noqa: E501
from server import util
from ..db import Database
from ..dto.heating_measurement import HeatingMeasurement
from ..openweathermap import OpenWeatherMap
from ..dto.temperature_measurement import TemperatureMeasurement


def post_heizen(body=None):  # noqa: E501
    """post number of wood logs you put onto the fire

     # noqa: E501

    :param body: store heating process
    :type body: dict | bytes

    :rtype: None
    """
    if connexion.request.is_json:
        body = Heating.from_dict(connexion.request.get_json())  # noqa: E501
        db = Database.get_instance()
        client = db.get_database()
        to_add = HeatingMeasurement(logs=body.logs, inital_heat=body.inital_heat,
                                    time=datetime.datetime.utcnow())
        client.heating.insert_one(
            to_add.__dict__)
        print("Added Heating Record: " + str(to_add.__dict__))
        return None, 200
    return None, 400


def post_temperatur(body=None):  # noqa: E501
    """post current temperatur measurment

     # noqa: E501

    :param body: Temperature to add
    :type body: dict | bytes

    :rtype: None
    """
    if connexion.request.is_json:
        body = Temperature.from_dict(connexion.request.get_json())  # noqa: E501
        db = Database.get_instance()
        client = db.get_database()
        oWM = OpenWeatherMap.get_instance()
        to_add = TemperatureMeasurement(water_temp=body.temperature,
                                        time=datetime.datetime.now(),
                                        outside_temp=oWM.get_temp())
        client.temperature.insert_one(to_add.__dict__)
        print("Added Temperature Record: " + str(to_add.__dict__))

        return None, 200
    return None, 400
