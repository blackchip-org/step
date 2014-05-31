# step

Breaks bash scripts into steps.

This may only be useful for me. Your mileage may vary.

## Overview

Follow along with this overview by cloning the repository, changing to the 
`example` directory and adding it to your path:

```bash
export PATH=${PATH}:$(PWD)
```

This utility can be useful for creating processing steps in a bash script. For
example, let's say we would like to execute the following:

```bash
think --about life
think --about universe
think --about everything
analyze
compute
```

This can all be done by hand, but it is much easier to put this into a script
if it ever needs to be regenerated. The problem is that these operations can
take a long time and it is easy to make mistakes while creating this script.

With step, you can do this instead:

```bash
step life \
    think --about life
step universe \
    think --about universe
step everything \
    think --about everything
step analyze \
    analyze
step compute \
    compute
```

Call this script ``answer``. Run the script normally:

```bash
answer
```

And all commands are executed in order. But if the answer is 56, which is
incorrect, some debugging is necessary. If there is a problem with the 
universe step, fix it and check its output by only executing that 
step:

```bash
run --only universe answer
```

Once that is working, see if the output from all the thinking looks okay
before computing the answer:

```bash
run --to everything answer
```

Now finish it up:

```bash
run --from analyze answer
```

## Install

There are only two files:

* `run`: Place this file somewhere in the ``PATH`` or invoke it with an
absolute or relative path.
* `step`: Scripts to be broken up into steps should source this file.

Do what you want.

## Details

Creating a script that can be executed even if step is not installed can be
done easily by mocking out the step command:

```bash
[ -e "/path/to/step" ] || step() { shift; "$@"; }
```

``run`` simply controls the conditional execution of step commands. All other
commands in the script that do not use step are executed unconditionally.

Steps that involve more than one command are best placed in a function:

```bash
step1() {
     echo "command 1"
     echo "command 2"
}
step -f step1
```

When using step, an ``-f`` or ``--function`` option indicates that the name of the
step is also the name of the function to be executed.

Sometimes it us useful to create sections of steps. For example, if GIS data
needs to be clipped, reprojected, and dumped in various projections, a script
may look like this:

```bash
step clip-arctic ...
step proj-arctic ...
step dump-arctic ...

step clip-antarctic ...
step proj-antarctic ...
step dump-antarctic ...
```

Sections for the arctic and antarctic steps can be defined with `-s` or 
`--section` as follows:

```bash
step --section arctic
step clip-arctic ...
step proj-arctic ...
step dump-arctic ...

step --section antarctic
step clip-antarctic ...
step proj-antarctic ...
step dump-antarctic ...
```

The arctic section an be run by itself with:

```bash
run --only arctic ./the_script
```

## Examples

Given the following script, named `example`:

```bash
#!/bin/bash
. /path/to/step

step step1 \
    echo 1
step step2 \
    echo 2
step step3 \
    echo 3
step step4 \
    echo 4
```

The following prints out `3` and `4`:

```bash
run --from step3 example.sh
```

The following prints out `1` and `2`:

```bash
run --to step2 example.sh
```

The following prints out `2` and `3`:

```bash
run --from step2 --to step3 example.sh
```

The following prints out `1` and `3`:

```bash
run --skip step2 --skip step4 example.sh
```

List all steps with:

```bash
run --list example.sh
```

List can also be used as a dry-run to see what steps will be executed:

```bash
run --list --skip step2 --skip step4 example.sh
```

## Manual Page: run

### SYNOPSIS

```
run [options] script [arguments...]
```

### DESCRIPTION

Executes a script and selects which steps to run. If no options are specified 
with run, the entire script is executed.

### OPTIONS

`--after, -a STEP`

Start execution of script after `STEP`. This is useful when debugging a 
faulty step. Once the error with the step has been fixed, this can be used 
to continue execution using the name of the faulty step without having to 
look up the name of the next step.
    
`--before, -b STEP`

Run from the beginning of the script and and stop before STEP. This is 
useful when fixing an error in a step and verifying that all previous 
steps are still valid.
     
`--debug, -d`
	
For each step, print out the command before execution. If the step is a 
function, turn the `x` flag on to print out the execution of each command.

`--from, -f STEP`

Start execution of the script at `STEP`.

`--help, -h`

Prints out usage information.

`--list, -l`
Lists all available steps.

`--only, -o STEP`

Skip all steps except for `STEP`.

`--skip, -s STEP`

Execute script but skip over `STEP`. Can be specified multiple times to select 
a set of steps to skip.

`--to, -t STEP`	

Run script and stop after executing step.

`--verbose, -v`	

Print out banners before each step.

`--version`	
Prints the version of this program.

### BUGS

This relies on a sane `getopt` which Mac OS X does not have.

## Manual Page: step

#### SYNOPSIS

```bash
step NAME command [arguments...]
step -f FUNCTION
step -s SECTION
```

### DESCRIPTION

Marks a command, function, or section as a step.

### OPTIONS

`--function, -f`
	
When this option is used, the name of the step is also the name of the 
function to execute. Instead of being redundant with:

```bash
step foo foo args
```

This can be replaced with:

```bash
step -f foo args
```
