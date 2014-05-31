#!/bin/bash

# Copyright (c) 2013 - 2014 blackchip.org
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

BASEDIR=$(dirname "$0")

. $BASEDIR/config

step before-section1 echo "before 1"
step -s section1
step step11 echo "1.1"
step step12 echo "1.2"
step -e
step after-section1 echo "after 1"

step before-section2 echo "before 2"
step -s section2
step step21 echo "2.1"
step step22 echo "2.2"
step -e
step after-section2 echo "after 2"

step before-section3 echo "before 3"
step -s section3
step step31 echo "3.1"
step step32 echo "3.2"
step -e
step after-section4 echo "after 3"

step before-section4 echo "before 4"
step -s section4
step step41 echo "4.1"
step step42 echo "4.2"
step -e
step after-section4 echo "after 4"