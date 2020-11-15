# coding: utf-8

from __future__ import absolute_import

from flask import json
from six import BytesIO

from server.models.temperature import Temperature  # noqa: E501
from server.test import BaseTestCase


class TestDefaultController(BaseTestCase):
    """DefaultController integration test stubs"""

    def test_post_temperatur(self):
        """Test case for post_temperatur

        post current temperatur measurment
        """
        body = Temperature()
        response = self.client.open(
            '/DavidSchmidt00/Badefass_Analyse/1.0.0/temperatur',
            method='POST',
            data=json.dumps(body),
            content_type='application/json')
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))


if __name__ == '__main__':
    import unittest
    unittest.main()
