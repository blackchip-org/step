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

[ "$STEP_ONLY_SHORT"  ] || STEP_ONLY_SHORT="o"
[ "$STEP_ONLY_LONG"   ] || STEP_ONLY_LONG="only"
[ "$STEP_START_SHORT" ] || STEP_START_SHORT="s"
[ "$STEP_START_LONG" ]  || STEP_START_LONG="start"
[ "$STEP_END_SHORT" ]   || STEP_END_SHORT="e"
[ "$STEP_END_LONG" ]    || STEP_END_LONG="end"
[ "$STEP_LIST_SHORT" ]  || STEP_LIST_SHORT="l"
[ "$STEP_LIST_LONG" ]   || STEP_LIST_LONG="list"
 
__STEP_SHORT_OPTS="$STEP_ONLY_SHORT:$STEP_START_SHORT:$STEP_END_SHORT:\
                   $STEP_LIST_SHORT"
__STEP_LONG_OPTS="$STEP_ONLY_LONG:,$STEP_START_LONG:,$STEP_END_LONG:,\
                  $STEP_LIST_LONG"

__STEP_ARGS=$(getopt -o "$__STEP_SHORT_OPTS" -l "$__STEP_LONG_OPTS" -- $@)

if [ $? -ne 0 ]; then
    exit 1
fi

__STEP_ORIGINAL_ARGS=$@
eval set -- "$__STEP_ARGS"

while true; do 
    case "$1" in
	-$STEP_ONLY_SHORT|--$STEP_ONLY_LONG)
	    __STEP_ONLY=$2
	    __STEP_REQUESTED=$2
	    shift 2
	    ;;
	-$STEP_START_SHORT|--$STEP_START_LONG)
	    __STEP_START=$2
	    __STEP_SKIP=1
	    __STEP_REQUESTED=$2
	    shift 2
	    ;;
	-$STEP_END_SHORT|--$STEP_END_LONG)
	    __STEP_END=$2
	    __STEP_REQUESTED=$2
	    shift 2
	    ;;
	-$STEP_LIST_SHORT|--$STEP_LIST_LONG)
	    __STEP_LIST=1
	    shift
	    ;;
	--)
	    shift;
	    break;
	    ;;
    esac
done

eval set -- "$__STEP_ORIGINAL_ARGS"
	    
step() {
    local step=$1
    shift
    if [ "$__STEP_LIST" ] ; then
	echo $step
	return 0
    fi
    if [ "$__STEP_ONLY" ] && [ "$step" != "$__STEP_ONLY" ] ; then
	return 0
    fi
    if [ "$step" == "$__STEP_START" ] ; then
	unset __STEP_SKIP
    fi
    if [ "$__STEP_SKIP" ] ; then
	return 0
    fi
    "$@"
    __STEP_EXECUTED=1
    if [ "$step" == "$__STEP_END" ] ; then
	__STEP_SKIP=1
    fi
}

__step_die() {
    echo "$@" >&2
    exit 1
}

__step_check_exit() {
    if [ "$__STEP_REQUESTED" ] && [ ! "$__STEP_EXECUTED" ] ; then
	__step_die "No such step: $__STEP_REQUESTED"
    fi
}

trap __step_check_exit EXIT
