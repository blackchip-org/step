====
step
====

---------------------------------
Breaks up bash scripts into steps
---------------------------------

:Author: blackchip.org
:Date: August 10, 2013
:Copyright: 2013, blackchip.org
:Version: 1.0
:Manual section: 1
:Manual group: Utilities

SYNOPSIS
========

step [options] command...

DESCRIPTION
===========

This can be useful for creating processing steps in which each step
could take a long time to execute. For example, let's say we have the
following script:

    |
    | think --about life
    | think --about universe
    | think --about everything
    | analyze
    | compute_answer

This can all be done by hand, but it is much easier to put this into a
script if it ever needs to be regenerated. The problem is that these
operations can take a long time and it can be easy to make mistakes
while creating this script.

With step, you can do this instead:

    |
    | run life        think --about life
    | run universe    think --about universe
    | run everything  think --about everything
    | run analyze     analyze
    | run answer      compute_answer

Call this script answer.sh. Run the script normally:

    |
    | answer.sh

And all operations are executed in order. But the answer is 56 which
is incorrect. While debugging, there is a problem with the universe
step. Fix it and check its output by only executing that command:

    |
    | step --only universe answer.sh

Once that is working, see if the output from all the thinking looks
okay before computing the answer:

    |
    | step --to everything answer.sh

Now finish it up:

    | 
    | step --from analyze answer.sh

OPTIONS
=======

--banner, -b      Print out a banner before running each step. The
                  banner will be in the format of::
 
                       ===== prog: step

                  where *prog* is the name of the program being exceuted
                  and *step* is the name of the step.
 
--command, -c     Print out the commands of each step as they are
                  executed. If run with the --function option, the
                  x bash option is set while the function is
                  executing.

--from STEP, -f   Start execution of commands starting with *STEP*.

--help, -h        Prints out a summary of usage for this command.

--list, -l        Prints out a list of available steps. This can also
                  used to perform a dry-run of which steps will be
                  executed. 

--only STEP, -o   Only run the specified *STEP* and skip all others.

--skip STEP, -s   Execute all steps execpt for the specified
                  *STEP*. This option can be listed multiple times on
		  the command line to skip more than one step.
 
--to STEP, -t     Stop execution of commands after *STEP*.

--verbose, -v     The same as using the *--banner* and *--command*
                  options.

--version         Prints the version number of this command

NOTES
=====

Scripts to be executed using step should source either /usr/share/step
or /usr/local/share/step depending on the installation location. This
provides the *run* command used for specifying a step.

Step simply controls the conditional execution of *run* commands. All
other commands in the script that do not use *run* are executed
unconditionally. 

Steps that involve more than one command are best placed in a
function:

    |
    | step1() {
    |     echo "command 1"
    |     echo "command 2"
    | }
    | run -f step1

When using *run*, using an *-f* or *--function* option indicates that
the name of the step is also the name of the function to be executed.

EXAMPLES
========

Given the following script, named example.sh:

    |
    | run step1 echo 1
    | run step2 echo 2
    | run step3 echo 3
    | run step4 echo 4

The following prints out "3" and "4":

    |
    | step --from step3 example.sh

The following prints out "1" and "2": 

    |
    | step --to step2 example.sh

The following prints out "2" and "3": 

    |
    | step --from step2 --to step3 example.sh

The following prints out "2" and "4": 

    |
    | step --skip step2 --skip step4 example.sh
 
Dry run the above command with:

    |
    | step --list --skip step2 --skip step4 example.sh
