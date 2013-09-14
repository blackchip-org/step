=============
step-overview
=============

-------------------------------
Breaks a bash script into steps
-------------------------------

:Author: blackchip.org
:Date: September 14, 2013
:Copyright: 2013, blackchip.org
:Version: 2.0
:Manual section: 7
:Manual group: Utilities

OVERVIEW
========

This utility can be useful for creating processing steps in a bash script.
For example, let's say we have the following script:

    |
    | think --about life
    | think --about universe
    | think --about everything
    | analyze
    | compute_answer

This can all be done by hand, but it is much easier to put this into a
script if it ever needs to be regenerated. The problem is that these
operations can take a long time and it is easy to make mistakes
while creating this script.

With step, you can do this instead:

    |
    | step life        think --about life
    | step universe    think --about universe
    | step everything  think --about everything
    | step analyze     analyze
    | step answer      compute_answer

Call this script answer.sh. Run the script normally:

    |
    | answer.sh

And all commands are executed in order. But the answer is 56 which
is incorrect. While debugging, there is a problem with the universe
step. Fix it and check its output by only executing that command:

    |
    | run --only universe answer.sh

Once that is working, see if the output from all the thinking looks
okay before computing the answer:

    |
    | run --to everything answer.sh

Now finish it up:

    | 
    | run --from analyze answer.sh


NOTES
=====

Scripts to be executed using step should source either /usr/share/step
or /usr/local/share/step depending on the installation location. This
provides the *step* command used for specifying a step.

Creating a script that can be executed even if step is not installed can
be done easily by mocking out the *step* command:

|
| [ -e /usr/share/step ] && . /usr/share/step || step() { shift; "$@"; }

*run* simply controls the conditional execution of *step* commands. All
other commands in the script that do not use *step* are executed
unconditionally. 

Steps that involve more than one command are best placed in a
function:

    |
    | step1() {
    |     echo "command 1"
    |     echo "command 2"
    | }
    | step -f step1

When using *step*, an *-f* or *--function* option indicates that
the name of the step is also the name of the function to be executed.

EXAMPLES
========

Given the following script, named example.sh:

    |
    | #!/bin/bash
    | . /usr/share/step
    |
    | step step1 echo 1
    | step step2 echo 2
    | step step3 echo 3
    | step step4 echo 4

The following prints out "3" and "4":

    |
    | run --from step3 example.sh

The following prints out "1" and "2": 

    |
    | run --to step2 example.sh

The following prints out "2" and "3": 

    |
    | run --from step2 --to step3 example.sh

The following prints out "2" and "4": 

    |
    | run --skip step2 --skip step4 example.sh
 
List all steps with:

    |
    | run --list example.sh

List can also be used as a dry-run to see what steps will be executed:

    |
    | run --list --skip step2 --skip step4 example.sh


SEE ALSO
========

run(1),
step(7)
