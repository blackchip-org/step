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

# TEST: Check that an error is printed if the step cannot be found

BASEDIR=$(dirname "$0")
STEP="$BASEDIR"/../step.sh

RESULT=$($STEP --only nostep $BASEDIR/prog/step4.sh 2>&1)
[ $? -ne 0 ] || exit 1
[ "$RESULT" == "step4.sh (step): No such step: nostep" ]


