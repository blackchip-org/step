===
run
===

-----------------------------------------------------
Runs a bash script and selects which steps to execute
-----------------------------------------------------

:Author: blackchip.org
:Date: September 14, 2013
:Copyright: 2013, blackchip.org
:Version: 2.0
:Manual section: 1
:Manual group: Utilities

SYNOPSIS
========

run [options] script [arguments...]

DESCRIPTION
===========
Executes a script and selects which steps to run. If no options are specified
with run, the entire script is executed. 

OPTIONS
=======
--after step, -a       Start execution of script after *step*. This is useful
                       when debugging a faulty step. Once the error with the
                       step has been fixed, this can be used to continue 
                       execution using the name of the faulty step without
                       having to look up the name of the next step.

--before step, -b      Run from the beginning of the script and and stop 
                       before *step*. This is useful when fixing an error in 
                       a step and verifying that all previous steps are still
                       valid.

--debug, -d            For each step, print out the command before execution.
                       If the step is a function, turn the x flag on to print
                       out the execution of each command.

--from step, -f        Start execution of the script at *step*.

--help, -h             Prints out usage information.

--list, -l             Lists all available steps.

--only step, -o        Skip all steps except for *step*. 

--skip step, -s        Execute script but skip over *step*. Can be specified
                       multiple times to select a set of steps to skip.

--to step, -t          Run script and stop after executing *step*.

--verbose, -v          Print out banners before each step.

--version              Prints the version of this package


SEE ALSO
========
step(7),
step-overview(7)


