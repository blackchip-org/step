#!/bin/bash

# Copyright 2013 blackchip.org
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

BASEDIR=$(dirname "$0")

. $BASEDIR/config

step -s section1
step step11 echo "1.1"
step step12 echo "1.2"

step -s section2
step step21 echo "2.1"
step step22 echo "2.2"

step -s section3
step step31 echo "3.1"
step step32 echo "3.2"

step -s section4
step step41 echo "4.1"
step step42 echo "4.2"



