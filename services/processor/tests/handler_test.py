# <module-name>.py

import unittest
import sys

sys.path.append('processor')

from listener import listener, health

class TestClass(unittest.TestCase):

    def test_health(self):
        self.asserEqual(health("Ok"), 'Ok')
