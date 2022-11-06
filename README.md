# Delphi Code Coverage Wizard

## What is Delphi Code Coverage Wizard?
Delphi Code Coverage Wizard is a GUI which makes running the command line based 
code coverage tool easier. 

If you have any DUnit or DUnitX unit tests for your project (which you should have
to be able to automatically test your project and thus ensure its quality!) you
also might want to know whether these tests cover all of your code or if there
are any code paths which are not exectued by these tests.

Sometimes it is really hard to cover some specific paths, but in most cases it is
not too hard to add further tests to cover code parts which are currently not yet
covered by your unit tests. Doing so will increase your test coverage and thus lets
you sleep better. This tool helps you to find out what's not covered yet. You can
create a project you can run (it actually runs your unit tests) to create a report 
which shows you which lines were executed by your tests and which were not run.

You would add further unit tests then and re-run the coverage report project 
generated with this tool to update your test coverage report. You would run this
until you either have covered all lines of your code by unit tests or have only
those lines missing which would be really hard to cover.

## Which Delphi versions are compatible?
The current version 1.0 is compatible with Delphi 11.0 Alexandria and most
likely with 10.4 Sydney.

## What is the current status of this project?
Development just started.

## Where can I get further information? For example if I'd like to contribute?
In the root folder of the project you will find further files with information about 
this project like *NOTICE.txt*, *CONTRIBUTING.md*, *SECURITY.md*.

## How to install?
Just run the installer provided in the Install\Output directory.
Run the ??? from the installation directory where you installed the tool.
When run for the first time it will display a dialog you can use to add it to the Tools
menus of all Delphi versions/profiles it finds on your computer.

## How to use it?

1. Make sure your project has MAP-file generation turned on in linker settings.
2. If not done yet develop some DUnit/DUnitX unit tests for your peoject.
3. Run the tool and generate a code coverage project for your project. The tool provides
   a wizzard for this.
4. Save the generated project.
5. Run the generated project. It should start your unit tests.
6. Run your unit testsand close the test runner.
7. The coverage report should be generated in the format(s) you specified in the wizard