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

PROG=$(basename "$0")
VERSION="0.3.0"

usage() {
    cat <<EOF
Usage: $PROG [options] command...

Options:
    -d, --debug          Set x flag after arguments have been processed
    -f, --from STEP      Start exection of command at STEP
    -h, --help           Prints this usage
    -l, --list           List available steps
    -o, --only STEP      Only run STEP in command
    -s, --skip STEP      Run command and skip step STEP. This option can be
                         specified multiple times to skip additional steps
    -t, --to STEP        Run command and stop at STEP
    --version            Prints the version of this command

Notes:
    If no options are specified, all steps in command are executed.
EOF
}

export __STEP_SHORT_OPTS="df:hlo:s:t:v"
export __STEP_LONG_OPTS="debug,from:,help,list,only:,skip:,to:,version"

ARGS=$(getopt -o "$__STEP_SHORT_OPTS" -l "$__STEP_LONG_OPTS" -n "$PROG" -- $@ )

if [ $? -ne 0 ] ; then
    exit 1
fi

__STEP_ARGS=""
eval set -- "$@"

while true; do
    case "$1" in
	--from|-f|--only|-o|--skip|-s|--to|-t)
	    __STEP_ARGS="$__STEP_ARGS $1 $2"
	    shift 2
	    ;;
	--list|-l|--debug|-d)
	    __STEP_ARGS="$__STEP_ARGS $1"
	    shift
	    ;;
	-h|--help)
	    usage
	    exit 0
	    ;;
	--version)
	    echo "$PROG version $VERSION"
	    exit 0
	    ;;
	--)
	    shift
	    break
	    ;;
	*)
	    break
	    ;;
    esac
done

__STEP_ARGS="$__STEP_ARGS" exec "$@"


	    
	    
	