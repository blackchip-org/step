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

# TEST: If there is an error in a step that is a function, the script should 
# exit

BASEDIR=$(dirname "$0")
RUN="$BASEDIR"/../bin/run

expected() {
    cat <<EOF
1
EOF
}

diff <($RUN $BASEDIR/prog/step_error_function.sh) <(expected) >/dev/null
[ $? -eq 0 ] || exit 1

# Make sure return code is passed back
$RUN $BASEDIR/prog/step_error_function.sh >/dev/null
[ $? -eq 0 ] && exit 1
exit 0



