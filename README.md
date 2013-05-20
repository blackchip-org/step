step
====

This is still a work in progress!

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

    run life \
        think --about life
    run universe \
        think --about universe
    run everything \
        think --about everything
    run analyze \
        analyze
    run answer \
        compute_answer

Call this script answer.sh. Run the script normally:

    ./answer.sh

And all operations are executed in order. But the answer is 56 which
is incorrect. While debugging, there is a problem with the universe
step. Fix it and check its output by only executing that command:

    step --only universe ./answer.sh

Once that is working, see if the output from all the thinking looks
okay before computing the answer:

    step --to everything ./answer.sh

Now finish it up:

    step --from analyze ./answer.sh

Usage is as follows:

    Usage: step [options] command...

    Options:
        -d, --debug          Set x flag after arguments have been processed
        -f, --from STEP      Start exection of command at STEP
        -h, --help           Prints this usage
        -l, --list           List available steps
        -o, --only STEP      Only run STEP in command
        -s, --skip STEP      Run command and skip STEP. This option can be
                             specified multiple times to skip additional steps
        -t, --to STEP        Run command and stop at STEP
        --version            Prints the version of this command

    Notes:
        If no options are specified, all steps in command are executed.


Have fun!




