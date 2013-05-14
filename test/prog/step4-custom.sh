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

STEP_ONLY_SHORT="O"
STEP_ONLY_LONG="ONLY"
STEP_START_SHORT="S"
STEP_START_LONG="START"
STEP_END_SHORT="E"
STEP_END_LONG="END"
STEP_LIST_SHORT="L"
STEP_LIST_LONG="LIST"

. $BASEDIR/../../step.sh

step step1 \
    echo "1"
step step2 \
    echo "2"
step step3 \
    echo "3"
step step4 \
    echo "4"