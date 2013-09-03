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

__STEP_PROG="$(basename "$0") (step)"

__step_error() {
    echo "$__STEP_PROG: $@" >&2
}

eval set -- "$__STEP_ARGS"
__STEP_SKIPS=""

while true; do 
    case "$1" in
	--banner|-b)
	    __STEP_BANNER=1
	    shift
	    ;;
	--command|-c)
	    __STEP_COMMAND=1
	    shift
	    ;;
	--verbose|-v)
	    __STEP_BANNER=1
	    __STEP_COMMAND=1
	    shift
	    ;;
	--only|-o)
	    __STEP_ONLY=$2
	    __STEP_REQUESTED=$2
	    shift 2
	    ;;
	--from|-f)
	    __STEP_FROM=$2
	    __STEP_DISABLED=1
	    __STEP_REQUESTED=$2
	    shift 2
	    ;;
	--to|-t)
	    __STEP_TO=$2
	    __STEP_REQUESTED=$2
	    shift 2
	    ;;
	--list|-l)
	    __STEP_LIST=1
	    shift
	    ;;
	--skip|-s)
	    __STEP_SKIPS="$__STEP_SKIPS __STEP_SKIP_$2&"
	    shift 2
	    ;;
	--debug|-d)
	    __STEP_DEBUG=1
	    shift
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

# Banner to be shown before each step is executed when using the --banner
# option. Override by assigning another banner command to the
# STEP_BANNER variable
__step_banner() {
    local prog=$1
    local step=$2

    echo -e "\n===== $prog: $step"
}
STEP_BANNER=__step_banner

# If the --command option is used to print out the commands to be executed,
# this prints out inline commands (function calls set +x). Override by 
# assigning another command to the STEP_COMMAND variable
__step_command() {
    echo "+ $@"
}
STEP_COMMAND=__step_command

if [ "$__STEP_DEBUG" ] ; then
    set -x
fi

__RUN_SHORT_OPTS="f"
__RUN_LONG_OPTS="function"

__run_usage() {
    cat <<EOF
Usage: run [options] <step_name> command...

Options:
    -f, --function      The name of the step is also the name of the function
                        to be executed. 
EOF
}

run() {
    local step=""
    local args=$(POSIXLY_CORRECT=1 getopt -o "$__RUN_SHORT_OPTS" -l "$__RUN_LONG_OPTS" -n "$__STEP_PROG" -- $@ )
    if [ $? -ne 0 ] ; then
	__run_usage
	exit 1
    fi

    eval set -- "$args"
    while true; do
	case "$1" in
	    -f|--function)
                # If this option is given, the name of the step is also the 
		# name of the function to be executed
		local is_function=true
		shift
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

    step="$1"
    shift
    if [ ! "$step" ] ; then
	__step_error "No step specified in run"
	__run_usage
	exit 1
    fi

    # Skip if only a specific step is to be run and this is not the step
    if [ "$__STEP_ONLY" ] && [ "$step" != "$__STEP_ONLY" ] ; then
        return 0
    fi

    # Start executing steps if this is the step listed in --from
    if [ "$step" == "$__STEP_FROM" ] ; then
        unset __STEP_DISABLED
    fi

    # Is this a step to be skipped?
    case "$__STEP_SKIPS" in
	*__STEP_SKIP_${step}*)
            __STEP_SKIPPED=1
	    __STEP_PREVIOUS_DISABLED=$__STEP_DISABLED
	    __STEP_DISABLED=1
	    ;;
    esac

    # Exit now if this step should not be run
    if [ "$__STEP_DISABLED" ] ; then
	if [ "$__STEP_SKIPPED" ] ; then
	    __STEP_DISABLED=$__STEP_PREVIOUS_DISABLED
	fi
        return 0
    fi

    __STEP_EXECUTED=1

    # Print banner if requested
    if [ "$__STEP_BANNER" ] ; then
	$STEP_BANNER $(basename "$0") $step
    fi

    # If just listing steps, show it now
    if [ "$__STEP_LIST" ] ; then
	echo "$step"
    else
	# If the --function option was used, the step name is also the
	# function to be executed
	local function=""
	if [ "$is_function" ] ; then
	    function="$step"
	fi

	# If printing commands...
	if [ "$__STEP_COMMAND" ] ; then
	    # If it is a function, let bash do the work
	    if [ "$is_function" ] ; then
		set -x
	    # If inline, print it out
	    else
		$STEP_COMMAND "$@"
	    fi
	fi

	# Execute
	$function "$@" 
	local return_code=$?
	# If --command was set, stop printing commands at this point
	set +x

	# Exit now if the step failed
	if [ $return_code -ne 0 ] ; then
	    exit $return_code
	fi
	if [ "$__STEP_DEBUG" ] ; then
	    # But turn command printing back on if in debug mode
	    set -x
	fi
    fi

    # If this is the final step specified by --to, don't execute any more
    # steps
    if [ "$step" == "$__STEP_TO" ] ; then
        __STEP_DISABLED=1
    fi
    return $return_code
}

# At the end, print out an error message if a step on the command line
# was not found.
__step_check_exit() {
    if [ "$__STEP_REQUESTED" ] && [ ! "$__STEP_EXECUTED" ] ; then
        __step_error "No such step: $__STEP_REQUESTED"
	exit 1
    fi
}

trap __step_check_exit EXIT
