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

# TEST: Check that there is an error when running step without any commands

BASEDIR=$(dirname "$0")
STEP="$BASEDIR"/../step.sh

$STEP $BASEDIR/prog/run_no_command.sh >/dev/null 2>&1
[ $? -eq 0 ] && exit 1
exit 0


