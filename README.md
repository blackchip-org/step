step
====

Breaks up bash scripts into steps.

This can be useful for creating processing steps in which each step
could take a long time to execute. For example, let say we have the
following script:

    think --about life
    think --about universe
    think --about everything
    analyze
    compute_answer

This can all be done by hand, but it is much easier to put this into a
script if it ever needs to be regenerated. The problem is that these
operations can take a long time and it can be easy to make mistakes while
creating this script. 

With step, you can do this instead:

    . /usr/share/step

    step life \
        think --about life
    step universe \
        think --about universe
    step everything \
        think --about everything
    step analyze \
        analyze
    step answer \
        compute_answer

Call this script answer.sh. Run the script normally:

    ./answer.sh

And all operations are executed in order. But the answer is 56 which
is incorrect. While debugging, there is a problem with the universe
step. Fix it and check its output by only executing that command:

    ./answer.sh --only universe

Once that is working, see if the output from all the thinking looks
okay before computing the answer:

    ./answer.sh --end everything

Now finish it up:

    ./answer.sh --start analyze

Usage:

    -o, --only STEP    Only run the given step.
    -s, --start STEP   Start at the given step and run to completion.
    -e, --end STEP     Start at the beginning and stop after the given
                       step has completed.
    -l, --list STEP    List all steps in the script

Don't like the command line arguments? Then change them:

    STEP_ONLY_SHORT="a"
    STEP_ONLY_LONG="aonly"
    STEP_START_SHORT="b"
    STEP_START_LONG="bstart"
    STEP_END_SHORT="c"
    STEP_END_LONG="cend"

    . /usr/share/step

[Full Example](https://github.com/blackchip-org/bmng-proc/blob/master/EPSG_3995.sh)

Have fun!




