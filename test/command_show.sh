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

# TEST: Check that step banners are printed when using the --banner option

BASEDIR=$(dirname "$0")
RUN="$BASEDIR"/../bin/run

expected() {
    cat <<EOF
+ echo 1
1
+ echo 2
2
+ echo 3
3
+ step4
+ echo 4
4
+ local return_code=0
+ set +x
EOF
}

diff <($RUN --debug $BASEDIR/prog/step4.sh 2>&1) <(expected) >/dev/null

