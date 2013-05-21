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
STEP="$BASEDIR"/../step.sh

expected() {
    cat <<EOF

===== step4.sh: step1
1

===== step4.sh: step2
2

===== step4.sh: step3
3

===== step4.sh: step4
4
EOF
}

diff <($STEP -b $BASEDIR/prog/step4.sh) <(expected) >/dev/null

