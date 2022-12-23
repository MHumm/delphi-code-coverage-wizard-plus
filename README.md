# Delphi Code Coverage Wizard Plus

## What is Delphi Code Coverage Wizard Plus?
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
The current version 2.0 is compatible with Delphi 11.x Alexandria and most
likely with 10.4.x Sydney.

## Where can I get further information? For example if I'd like to contribute?
In the root folder of the project you will find further files with information about 
this project like *NOTICE.txt*, *CONTRIBUTING.md*, *SECURITY.md*.

## Where is the Code Coverage command line tool from?
The command line tool used and included is the version of this one compiled at 2022/11/20:
https://github.com/DelphiCodeCoverage/DelphiCodeCoverage

If the CodeCoverage.exe did not really change any parameters one can replace it with 
a new version, if desired. Later updates of this wizard should contain updated versions 
as well.

## How to install?
If you want to use the built in display of HTML formatted rerports you might need 
EdgeView2SDK from Tools/GetIt package manager to be installed first.
Afterwards just open and run the project provided in the Source directory.
When run for the first time or when you installed another version of the IDE it will 
display a dialog you can use to add it to the Tools menus of all Delphi versions/profiles 
it finds on your computer. It will additionally ask if it shall associate the .DCCP project 
file extension with the tool so you can open these files directly from file Explorer.

## How to use it?

1. Make sure your project has detailed MAP-file generation turned on in linker settings.
2. Compile your project to get a MAP file created.
3. If not done yet, develop some DUnit/DUnitX unit tests for your project. If you set it
   up as a console project, you only need to press enter after the tests have run during 
   code coverage analysis later, otherwise you need to start them manually (when using 
   DUnit's GUI) each time when running code coverage. 
4. Run this tool and generate a code coverage project for your project. The tool provides
   a wizard for this.
5. Save the generated project.
6. Run the generated project. It should start your unit tests.
7. Run your unit tests and close the test runner.
8. The coverage report should be generated in the format(s) you specified in the wizard. 
   If you checked HTML format, the result will be displayed in code coverage wizard plus,
   but you can still open it in any browser outside this tool.
   
   Now: enjoy!
   
## Some impressions ##
![Start screen of the wizard](/Screenshots/Wizard1.PNG)

![Some screen of the wizard](/Screenshots/Wizard2.PNG)

![Start screen of the generated HTML output](/Screenshots/Output1.PNG)

![View of a unit (blue lines are not covered yet)](/Screenshots/Output2.PNG)   

![View of a unit 2 (top with the unit's summary)](/Screenshots/Output3.PNG)   