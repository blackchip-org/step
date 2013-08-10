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

# TEST: Check that an error is printed if no step is in a run

BASEDIR=$(dirname "$0")
STEP="$BASEDIR"/../step.sh

RESULT=$($STEP $BASEDIR/prog/run_no_step.sh 2>&1)
[ $? -ne 0 ] || exit 1

# Remove all usage text
RESULT=$(echo $RESULT | sed -e 's/ Usage.*//')
[ "$RESULT" == "run_no_step.sh (step): No step specified in run" ]


