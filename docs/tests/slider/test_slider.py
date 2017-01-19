#!/usr/bin/env python
import unittest
from MooseDocs.testing import MarkdownTestCase

class TestSlider(MarkdownTestCase):
  """
  Test to make sure that "moose/python/MooseDocs/extensions/MooseSlider.py"
  parses a test block correctly.
  """

  def testSlider(self):
    self.assertConvert('test_slider.html', 'test_slider.md')

if __name__ == '__main__':
  unittest.main(module=__name__, verbosity=2)