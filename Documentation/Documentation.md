# Delphi Code Coverage Wizard Plus

## What is Delphi Code Coverage Wizard Plus?
This is a GUI tool for creating projects to run code coverage tests
and even to run those.

Code coverage tests do check which of the lines a project's source code are actually 
reached by the unit tests run. It creates a report in one or more of several formats 
provided and if HTML as report format is selected that will automatically get displayed
in the wizard itsself. For all formats one can opt that they are opened with their associated
viewers after the test run completed.

In the HTML report you can see exactly for each of your units which lines have been executed
(green) and which not (blue). Yellow lines have not been cosidered because they are definitions,
like class or other type definitions.

## Requirements
- A copy of Delphi 10.4 or newer
- EdgeView2SDK, a Delphi Add-On you can install via Tools/GetIt package manager
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
-UNINSTALL: removes all entries to the registry including Delphi Tools menu integration and DCCP 
 file association, each for the current user only. Deletes the ini file. It does not delete
 the application and its source code.
 
 ## Shell integration
 On first start the application asks whether you want to associate the DCCP project file extension
 with this application. If you do so, you can open any DCCP project file via douple click from Explorer.
 In addition it will create a "verb" named "run". When right clicking on the .DCCP file you can select 
 "run" from the context menu and Delphi Code Coverage Wizard Plus will load the .DCCP file and 
 automatically run the associated batch file .