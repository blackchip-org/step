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

# TEST: Check that banners can be overriden

BASEDIR=$(dirname "$0")
. $BASEDIR/config

expected() {
    cat <<EOF
program: step4_banner_override.sh, step: step1
1
program: step4_banner_override.sh, step: step2
2
program: step4_banner_override.sh, step: step3
3
program: step4_banner_override.sh, step: step4
4
EOF
}

diff <($RUN --verbose $FX/step4_banner_override.sh) \
    <(expected) >/dev/null

