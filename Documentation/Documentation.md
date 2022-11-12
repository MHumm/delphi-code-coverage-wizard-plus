# Delphi Code Coverage Wizard Plus

## What is Delphi Code Coverage Wizard Plus?
This is a GUI tool for creating projects to run code coverage tests
and even to run those.

Code coverage tests do check which of the lines a project's source code is actually 
reached by the unit tests run.

## Requirements
- A copy of Delphi 10.4 or newer
- DUnit or DUnitX unit tests for the project to analyze
- A detailed map file for the unit test project used. One can turn on map file generation
  in linker settings in project options dialog. This requires recompilation of the unit 
  test project afterwards.
- The source code of the project to run code coverage on

The installation instructions are already given in readme.md in the root directory of 
this project.

## Command line params
One can start the tool with these command line params:

-? : opens the about screen, which also contains a short descriptions of the available params
-O <FileName> : opens the specified project file (.DCCP) or if a dpr or dproj file is specified
   it checks and loads a DCCP file with the same name, if that exists in the same directory. 
-R <FileName> : opens and directly runs the specified project file (.DCCP) or if a dpr or dproj 
   file is specified it checks and loads a DCCP file with the same name, if that exists in the 
   same directory.   