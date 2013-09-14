====
step
====

----------------------------------
Marks command as an execution step
----------------------------------

:Author: blackchip.org
:Date: September 14, 2013
:Version: 2.0
:Manual section: 7
:Manual group: Utilities

SYNOPSIS
========

step [options] name command [arguments...]

DESCRIPTION
===========
Marks the *command* as a step with *name*.

OPTIONS
=======

--function, -f       When this option is used, the name of the step is 
                     also the name of the function to execute. Instead of
                     being redundant with:
 
                         |
                         | step foo foo args

                     This can be replaced with:

                         |
                         | step -f foo args 

SEE ALSO
========
run(1),
step-overview(7)
