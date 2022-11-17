{*****************************************************************************
  The Delphi Code Coverage Wizzard team (see file NOTICE.txt) licenses this file
  to you under the Mozilla public License 1.1 (the
  "License"); you may not use this file except in compliance
  with the License. A copy of this licence is found in the root directory
  of this project in the file LICENCE.txt.

  Unless required by applicable law or agreed to in writing,
  software distributed under the License is distributed on an
  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
  KIND, either express or implied.  See the License for the
  specific language governing permissions and limitations
  under the License.
*****************************************************************************}

/// <summary>
///   Interface to some output settings of a project file
/// </summary>
unit UProjectSettingsInterface;

interface

uses
  System.SysUtils,
  System.Classes;

type
  /// <summary>
  ///   Possible output formats for the report, where Meta can only be used in
  ///   conjunction with ofEMMA
  /// </summary>
  TOutputFormat = (ofEMMA, ofEMMA21, ofMETA, ofXML, ofHTML);

  /// <summary>
  ///   Set of possible output formats
  /// </summary>
  TOutputFormatSet = set of TOutputFormat;

  /// <summary>
  ///   One entry in the lsit of source files to analyze
  /// </summary>
  IProgramSourceFileItem = interface(IInterface)
    /// <summary>
    ///   Returns the file name
    /// </summary>
    function GetFilename: string;
    /// <summary>
    ///   Returns whether the file is selected for analysis (true) or not
    /// </summary>
    function GetSelected: Boolean;
    /// <summary>
    ///   Sets the file name
    /// </summary>
    procedure SetFilename(const Value: string);
    /// <summary>
    ///   Sets whether the file is selected for analysis (true) or not
    /// </summary>
    procedure SetSelected(const Value: Boolean);

    /// <summary>
    ///   Name of a file from the soruce directory specified
    /// </summary>
    property Filename : string
      read   GetFilename
      write  SetFilename;
    /// <summary>
    ///   If true the file is selected for analysis. Otherwise it is not
    ///   analyzed. Directly after construction the entry is considered to
    ///   be selected.
    /// </summary>
    property Selected : Boolean
      read   GetSelected
      write  SetSelected;
  end;

  IProgramSourceFiles = interface;

  /// <summary>
  ///   Enumerator for the source files list
  /// </summary>
  TProgramSourceFilesEnumerator = class(TObject)
  private
    /// <summary>
    ///   Where within the list are we?
    /// </summary>
    FIndex: integer;
    /// <summary>
    ///   The list over which we enumerate
    /// </summary>
    FList : IProgramSourceFiles;
  public
    /// <summary>
    ///   Creates and initializes the instance
    /// </summary>
    constructor Create(aList: IProgramSourceFiles);
    /// <summary>
    ///   Returns the list item we're currently on
    /// </summary>
    function    GetCurrent: IProgramSourceFileItem;
    /// <summary>
    ///   Checks if we can move to the next list item and if yes, moves the
    ///   index to it
    /// </summary>
    function    MoveNext: Boolean;
    /// <summary>
    ///   Returns the list item we're currently on
    /// </summary>
    property    Current: IProgramSourceFileItem
      read      GetCurrent;
  end;

  /// <summary>
  ///   List of source files, relatively based on a specified base path
  /// </summary>
  IProgramSourceFiles = interface(IInterface)
    /// <summary>
    ///   Returns the number of files contained in the list
    /// </summary>
    function GetCount: Integer;
    /// <summary>
    ///   Returns the number of selected files contained in the list
    /// </summary>
    function GetSelectedCount: Integer;
    /// <summary>
    ///   Returns the root path for the files
    /// </summary>
    function GetBasePath: TFilename;
    /// <summary>
    ///   Updates the base path setting and if the value is really changed
    ///   updates the list of source files under that path.
    /// </summary>
    procedure SetBasePath(const Value: TFilename);

    /// <summary>
    ///   Adds a file to the list
    /// </summary>
    /// <param name="AItemFileName">
    ///   File name of a source file with absolute path. Will internally be
    ///   stored in relative form.
    /// </param>
    /// <param name="IsSelected">
    ///   When true the file is selected for analysis, otherwise it should not
    ///   be analyzed.
    /// </param>
    procedure AddFile(const AItemFilename : TFilename;
                      IsSelected          : Boolean);
    /// <summary>
    ///   Returns a list of all selected source files.
    /// </summary>
    /// <param name="ACheckedList">
    ///   List object to which only the selected source files are added.
    ///   The list is initially cleared.
    /// </param>
    procedure GetCheckedItemsList(const ACheckedList : TStrings);
    /// <summary>
    ///   Returns a list of all source files.
    /// </summary>
    /// <param name="AList">
    ///   List object to which all source files are added.
    ///   The list is initially cleared.
    /// </param>
    procedure GetItemsList(const AList : TStrings);
    /// <summary>
    ///   Replaces the list contents with the source files found under the
    ///   newly specified path. Exception: if the path only contains the
    ///   path delimiter char the list will be emptied, as otherwise all
    ///   source files in all directories somewhere will be found!
    /// </summary>
    procedure ReplaceSourceFilesList;
    /// <summary>
    ///   Determines all source files of the source path defined. Removes thos
    ///   in the list which are no longer found and adds those as unselected
    ///   which were not in the list yet. Exception: if the path only contains the
    ///   path delimiter char the list will be emptied, as otherwise all
    ///   source files in all directories somewhere will be found!
    /// </summary>
    procedure UpdateSourceFilesList;
    /// <summary>
    ///   Changes selected status of some item
    /// </summary>
    /// <param name="Index">
    ///   Index of the item for which to change selected status. Throws an
    ///   EIndexOutOfRange exception for a non existing index
    /// </param>
    /// <param name="Checked">
    ///   New checked status
    /// </param>
    procedure ChangeSelected(Index: Integer; Checked: Boolean);
    /// <summary>
    ///   Returns whether some source file is selected for analysis or not.
    /// </summary>
    /// <param name="Index">
    ///   Index of the entry to return the checked status of
    /// </param>
    /// <returns>
    ///   true if that file is checked, false if not
    /// </returns>
    function IsSelected(Index: Integer): Boolean;

    /// <summary>
    ///   Returns a single list entry. No exceptions are caught!
    /// </summary>
    /// <param name="Index">
    ///   Index of the entry to return
    /// </param>
    /// <returns>
    ///   The item.
    /// </returns>
    function GetItem(Index: Integer): IProgramSourceFileItem;

    /// <summary>
    ///   Returns an enumerator for iterating over the list elements
    /// </summary>
    function  GetEnumerator: TProgramSourceFilesEnumerator;

    /// <summary>
    ///   Specifies the base path to which all file names are stored relatively
    /// </summary>
    property BasePath : TFilename
      read   GetBasePath
      write  SetBasePath;

    /// <summary>
    ///   Returns the number of files contained in the list
    /// </summary>
    property Count : Integer
      read   GetCount;

    /// <summary>
    ///   Returns the number of selected files contained in the list
    /// </summary>
    property SelectedCount : Integer
      read   GetSelectedCount;

    /// <summary>
    ///   Provides read only access to the items
    /// </summary>
    property Items[Index: Integer]: IProgramSourceFileItem
      read   GetItem; default;
  end;

  /// <summary>
  ///   Interface to some output settings of a project file
  /// </summary>
  IProjectOutputSettingsReadOnly = interface(IInterface)
    /// <summary>
    ///   When true the generated EMMA file shall be displayed in an associated
    ///   external viewer
    /// </summary>
    function GetDisplayEMMAFileExt: Boolean;
    /// <summary>
    ///   When true the generated XML file shall be displayed in an associated
    ///   external viewer
    /// </summary>
    function GetDisplayXMLFileExt: Boolean;
    /// <summary>
    ///   When true the generated HTML file shall be displayed in an associated
    ///   external viewer
    /// </summary>
    function GetDisplayHTMLFileExt: Boolean;
    /// <summary>
    ///   Returns the name of the loaded or saved project file
    /// </summary>
    function GetFileName: string;
    /// <summary>
    ///   Returns the defined path where the generated reports will be saved to
    /// </summary>
    function GetReportOutputPath: TFilename;
    /// <summary>
    ///   Returns the name of the generated batch file
    /// </summary>
    function GetBatchFileName: TFileName;
    /// <summary>
    ///   Returns the selected output formats to create
    /// </summary>
    function GetOutputFormats: TOutputFormatSet;
    /// <summary>
    ///   When true the generated XML output file(s) will contain line numbers
    /// </summary>
    function GetAddLineNumbersToXML: Boolean;
    /// <summary>
    ///   When true combines lines coverage for multiple occurrences of the same
    ///  filename (especially usefull in case of generic classes)
    /// </summary>
    function GetCombineXMLCoverage: Boolean;
    /// <summary>
    ///   Generate XML output in the format generated by Java's Jacoco coverage
    ///   library
    /// </summary>
    function GetXMLJacocoFormat: Boolean;
    /// <summary>
    ///   When true, log texts are written to OutputDebugString
    /// </summary>
    function GetLogToOutputDebugString: Boolean;
    /// <summary>
    ///   When true, log messages are written to a textfile in report output folder
    /// </summary>
    function GetLogToTextFile: Boolean;
    /// <summary>
    ///   When true the exit code of the called application will be passed through
    /// </summary>
    function GetPassTroughExitCode: Boolean;

    /// <summary>
    ///   Displays the newly generated XML-file in the associated viewer
    ///   via ShellExecute
    /// </summary>
    property DisplayEMMAFileExt : Boolean
      read   GetDisplayEMMAFileExt;
    /// <summary>
    ///   Displays the newly generated XML-file in the associated viewer
    ///   via ShellExecute
    /// </summary>
    property DisplayXMLFileExt : Boolean
      read   GetDisplayXMLFileExt;
    /// <summary>
    ///   Displays the newly generated XML-file in the associated viewer
    ///   via ShellExecute
    /// </summary>
    property  DisplayHTMLFileExt : Boolean
      read    GetDisplayHTMLFileExt;
    /// <summary>
    ///   When true the generated XML output file(s) will contain line numbers
    /// </summary>
    property AddLineNumbersToXML: Boolean
      read   GetAddLineNumbersToXML;
    /// <summary>
    ///   When true combines lines coverage for multiple occurrences of the same
    ///  filename (especially usefull in case of generic classes)
    /// </summary>
    property CombineXMLCoverage : Boolean
      read   GetCombineXMLCoverage;
    /// <summary>
    ///   Generate XML output in the format generated by Java's Jacoco coverage
    ///   library
    /// </summary>
    property XMLJacocoFormat : Boolean
      read   GetXMLJacocoFormat;
    /// <summary>
    ///   Write log messages to textfile in report output folder
    /// </summary>
    property LogToTextFile        : Boolean
      read   GetLogToTextFile;
    /// <summary>
    ///   Write log texts to OutputDebugString
    /// </summary>
    property LogToOutputDebugString : Boolean
      read   GetLogToOutputDebugString;
    /// <summary>
    ///   Write log texts to OutputDebugString
    /// </summary>
    property PassTroughExitCode     : Boolean
      read   GetPassTroughExitCode;

    /// <summary>
    ///   Path and name of the loaded or saved project file. Empty if no file
    ///   has been loaded or saved yet.
    /// </summary>
    property FileName : string
      read   GetFileName;
    /// <summary>
    ///   Returns the name of the generated batch file
    /// </summary>
    property BatchFileName : TFileName
      read   GetBatchFileName;

    /// <summary>
    ///   Path where the report(s) will be output to.
    /// </summary>
    property ReportOutputPath : TFilename
      read   GetReportOutputPath;

    /// <summary>
    ///   Selected formats for the report output.
    /// </summary>
    property OutputFormats : TOutputFormatSet
      read   GetOutputFormats;
  end;

  /// <summary>
  ///   Interface for the complete project settings
  /// </summary>
  IProjectSettings = Interface(IProjectOutputSettingsReadOnly)
    /// <summary>
    ///   Returns the path to the executable to analyze. Absolutely encoded.
    /// </summary>
    function GetProgramToAnalyze: TFilename;
    /// <summary>
    ///   Returns the command line parameters to pass to the called exe file (if any)
    /// </summary>
    function GetExeCommandLineParams: string;
    /// <summary>
    ///   If true the working directory will be set to the directory the called
    ///   unit test exe is in
    /// </summary>
    function GetUseExeDirAsWorkDir: Boolean;
    /// <summary>
    ///   Path to the map file of the program to analyze. Absolutely encoded.
    /// </summary>
    function GetMapFile: TFilename;
    /// <summary>
    ///   Returns the base path of the source files to analyze.
    /// </summary>
    function GetProgramSourcePath: TFilename;
    /// <summary>
    ///   Sets the path to the executable to analyze. Absolutely encoded.
    ///   If the path/file name exists, it also checks if a map file of the
    ///   same name exists and if so, sets the name of the map file.
    /// </summary>
    procedure SetProgramToAnalyze(const Value: TFilename);
    /// <summary>
    ///   Sets the base path for the source files of the program to analyze.
    /// </summary>
    procedure SetProgramSourceBasePath(const Value: TFilename);
    /// <summary>
    ///   Sets the map file path and name
    /// </summary>
    procedure SetMapFile(const Value: TFilename);
    /// <summary>
    ///   Returns the defined path where the generated reports will be saved to
    /// </summary>
    function GetReportOutputPath: TFilename;
    /// <summary>
    ///   Defines the path where the generated reports will be saved to
    /// </summary>
    procedure SetReportOutputPath(const Value: TFilename);
    /// <summary>
    ///   Returns the list of defined source code files for analisys
    /// </summary>
    function GetProgramSourceFiles: IProgramSourceFiles;
    /// <summary>
    ///   Sets the list of defined source code files for analysis
    /// </summary>
    procedure SetProgramSourceFiles(const Value: IProgramSourceFiles);
    /// <summary>
    ///   Returns the path to which the batch file and the other files to be
    ///   generated will be written to
    /// </summary>
    function GetScriptsOutputPath: TFilename;
    /// <summary>
    ///   Sets the path to which the batch file and the other files to be
    ///   generated will be written to
    /// </summary>
    procedure SetScriptsOutputPath(const Value: TFilename);
    /// <summary>
    ///   Returns the path to the CodeCoverage.exe to run
    /// </summary>
    function GetCodeCoverageExePath: TFilename;
    /// <summary>
    ///   Sets the path to the CodeCoverage.exe to run
    /// </summary>
    procedure SeCodeCoverageExePath(const Value: TFilename);
    /// <summary>
    ///   When true all paths to files are relative
    /// </summary>
    function GetRelativeToScriptPath: Boolean;
    /// <summary>
    ///   Defines whether all paths to files are relative (true) or
    ///   absolute (false)
    /// </summary>
    procedure SetRelativeToScriptPath(const Value: Boolean);
    /// <summary>
    ///   Returns any additional parameters set
    /// </summary>
    function GetAdditionalParameter: string;
    /// <summary>
    ///   Defines any additional params to set
    /// </summary>
    procedure SetAdditionalParameter(const Value: string);
    /// <summary>
    ///   Defines whether EMMA files shall be displayed via ShellExecute
    /// </summary>
    procedure SetDisplayEMMAFileExt(const Value: Boolean);
    /// <summary>
    ///   Defines whether HTML files shall be displayed via ShellExecute
    /// </summary>
    procedure SetDisplayHTMLFileExt(const Value: Boolean);
    /// <summary>
    ///   Defines whether XML files shall be displayed via ShellExecute
    /// </summary>
    procedure SetDisplayXMLFileExt(const Value: Boolean);
    /// <summary>
    ///   When true the generated XML output file(s) will contain line numbers
    /// </summary>
    procedure SetAddLineNumbersToXML(const Value: Boolean);
    /// <summary>
    ///   When true combines lines coverage for multiple occurrences of the same
    ///  filename (especially usefull in case of generic classes)
    /// </summary>
    procedure SetCombineXMLCoverage(const Value: Boolean);
    /// <summary>
    ///   Generate XML output in the format generated by Java's Jacoco coverage
    ///   library
    /// </summary>
    procedure SetXMLJacocoFormat(const Value: Boolean);
    /// <summary>
    ///   Sets the selected output formats to create
    /// </summary>
    procedure SetOutputFormats(const Value: TOutputFormatSet);
    /// <summary>
    ///   Write log texts to OutputDebugString
    /// </summary>
    procedure SetLogToOutputDebugString(const Value: Boolean);
    /// <summary>
    ///   Write log messages to textfile in report output folder
    /// </summary>
    procedure SetLogToTextFile(const Value: Boolean);
    /// <summary>
    ///   When true the exit code of the called application will be passed through
    /// </summary>
    procedure SetPassTroughExitCode(const Value: Boolean);
    /// <summary>
    ///   Sets the command line parameters to pass to the called exe file (if any)
    /// </summary>
    procedure SetExeCommandLineParams(const Value: string);
    /// <summary>
    ///   If true the working directory will be set to the directory the called
    ///   unit test exe is in
    /// </summary>
    procedure SetUseExeDirAsWorkDir(const Value: Boolean);
    /// <summary>
    ///   Returns the code page selected for the source files. Only used if not 0.
    /// </summary>
    function GetCodePage: Integer;
    /// <summary>
    ///   Sets the code page to be used for the source files. Only used if not 0.
    /// </summary>
    procedure SetCodePage(const Value: Integer);

    /// <summary>
    ///   Checks whether both exe-file name and map-file name are defined.
    /// </summary>
    /// <returns>
    ///   true if set, false if at least one is not defined.
    /// </returns>
    function IsExeAndMapDefined: Boolean;
    /// <summary>
    ///   Checks whether some path for the source files to be analyzed is defined
    ///   and whether there are some source files selected for analysis.
    /// </summary>
    /// <returns>
    ///   true if set, false if at least one is not defined.
    /// </returns>
    function IsSourcePathAndFilesDefined: Boolean;

    /// <summary>
    ///   Checks whether the required output settings are defined.
    /// </summary>
    /// <returns>
    ///   true if output path is defined and at least one format set, false if
    ///   at least one oth these is missing
    /// </returns>
    function IsOutputSettingsDefined: Boolean;

    /// <summary>
    ///   Checks whether any setting of the project is already set
    /// </summary>
    /// <returns>
    ///   true if yes
    /// </returns>
    function IsAnyDataDefined: Boolean;

    /// <summary>
    ///   Returns the path passed as parameter in relative to the script path form.
    /// </summary>
    /// <param name="APath">
    ///   Path which shall be returned in relative form
    /// </param>
    /// <returns>
    ///   Relative path of the path specified as parameter.
    /// </returns>
    function GetRelativePath(const APath: string): string;

    /// <summary>
    ///   Returns path and file name of the "index" file of the HTML report
    ///   output in a form which can be used to call this in a webbrowser component.
    /// </summary>
    function GetReportOutputIndexURL: string;

    /// <summary>
    ///   Saves the project's data into an XML file
    /// </summary>
    /// <param name="FileName">
    ///   Path and name of the XML/DCCP file to create. Existing files will
    ///   be overwritten.
    /// </param>
    procedure SaveToXML(const FileName: TFileName);

    /// <summary>
    ///   Loads the project's data from an XML file
    /// </summary>
    /// <param name="FileName">
    ///   Path and name of the XML/DCCP file to load
    /// </param>
    procedure LoadFromXML(const FileName: string);

    /// <summary>
    ///   Path to the executable to analyze. Absolutely encoded.
    /// </summary>
    property ExecutableToAnalyze : TFilename
      read   GetProgramToAnalyze
      write  SetProgramToAnalyze;
    /// <summary>
    ///   Command line parameters to pass to the called unit test executable
    /// </summary>
    property ExeCommandLineParams : string
      read   GetExeCommandLineParams
      write  SetExeCommandLineParams;
    /// <summary>
    ///   When true the working dir will be set to the directory of the called
    ///   unit test application
    /// </summary>
    property UseExeDirAsWorkDir : Boolean
      read   GetUseExeDirAsWorkDir
      write  SetUseExeDirAsWorkDir;
    /// <summary>
    ///   Path to the map file of the program to analyze. Absolutely encoded.
    /// </summary>
    property MapFile : TFilename
      read   GetMapFile
      write  SetMapFile;
    /// <summary>
    ///   Base path for the source files of the program to analyze.
    /// </summary>
    property ProgramSourceBasePath : TFilename
      read   GetProgramSourcePath
      write  SetProgramSourceBasePath;
    /// <summary>
    ///   List of source files of the program to analyze including the
    ///   information which of those are actually selected for analysis.
    /// </summary>
    property ProgramSourceFiles : IProgramSourceFiles
      read   GetProgramSourceFiles
      write  SetProgramSourceFiles;
    /// <summary>
    ///   Code page for the source code files, only used if not 0
    /// </summary>
    property CodePage : Integer
      read   GetCodePage
      write  SetCodePage;
    /// <summary>
    ///   Path where the batch file to call the code coverage cmd line tool will
    ///   be stored.
    /// </summary>
    property ScriptsOutputPath : TFilename
      read   GetScriptsOutputPath
      write  SetScriptsOutputPath;
    /// <summary>
    ///   Path where the report(s) will be output to.
    /// </summary>
    property ReportOutputPath : TFilename
      read   GetReportOutputPath
      write  SetReportOutputPath;
    /// <summary>
    ///   Path to the application to analyze.
    /// </summary>
    property CodeCoverageExePath : TFilename
      read   GetCodeCoverageExePath
      write  SeCodeCoverageExePath;
    /// <summary>
    ///   When true, paths are relative to the script path where the batch file
    ///   is stored. Otherwise paths are absolute.
    /// </summary>
    property RelativeToScriptPath : Boolean
      read   GetRelativeToScriptPath
      write  SetRelativeToScriptPath;
    /// <summary>
    ///   Any "free form" parameters specified to be able to use params this
    ///   version doesn't implement (yet)
    /// </summary>
    property AdditionalParameter : string
      read   GetAdditionalParameter
      write  SetAdditionalParameter;

    /// <summary>
    ///   Path and name of the loaded or saved project file. Empty if no file
    ///   has been loaded or saved yet.
    /// </summary>
    property FileName : string
      read   GetFileName;

    /// <summary>
    ///   Displays the newly generated XML-file in the associated viewer
    ///   via ShellExecute
    /// </summary>
    property DisplayEMMAFileExt : Boolean
      read   GetDisplayEMMAFileExt
      write  SetDisplayEMMAFileExt;
    /// <summary>
    ///   Displays the newly generated XML-file in the associated viewer
    ///   via ShellExecute
    /// </summary>
    property DisplayXMLFileExt : Boolean
      read   GetDisplayXMLFileExt
      write  SetDisplayXMLFileExt;
    /// <summary>
    ///   Displays the newly generated XML-file in the associated viewer
    ///   via ShellExecute
    /// </summary>
    property DisplayHTMLFileExt : Boolean
      read   GetDisplayHTMLFileExt
      write  SetDisplayHTMLFileExt;
    /// <summary>
    ///   When true the generated XML output file(s) will contain line numbers
    /// </summary>
    property AddLineNumbersToXML: Boolean
      read   GetAddLineNumbersToXML
      write  SetAddLineNumbersToXML;
    /// <summary>
    ///   When true combines lines coverage for multiple occurrences of the same
    ///  filename (especially usefull in case of generic classes)
    /// </summary>
    property CombineXMLCoverage : Boolean
      read   GetCombineXMLCoverage
      write  SetCombineXMLCoverage;
    /// <summary>
    ///   Generate XML output in the format generated by Java's Jacoco coverage
    ///   library
    /// </summary>
    property XMLJacocoFormat : Boolean
      read   GetXMLJacocoFormat
      write  SetXMLJacocoFormat;
    /// <summary>
    ///   Write log messages to textfile in report output folder
    /// </summary>
    property LogToTextFile        : Boolean
      read   GetLogToTextFile
      write  SetLogToTextFile;
    /// <summary>
    ///   Write log texts to OutputDebugString
    /// </summary>
    property LogToOutputDebugString : Boolean
      read   GetLogToOutputDebugString
      write  SetLogToOutputDebugString;
    /// <summary>
    ///   Write log texts to OutputDebugString
    /// </summary>
    property PassTroughExitCode     : Boolean
      read   GetPassTroughExitCode
      write  SetPassTroughExitCode;

    /// <summary>
    ///   Path and name of the loaded or saved project file. Empty if no file
    ///   has been loaded or saved yet.
    /// </summary>
    property FileName : string
      read   GetFileName;

    /// <summary>
    ///   Path where the report(s) will be output to.
    /// </summary>
    property ReportOutputPath : TFilename
      read   GetReportOutputPath
      write  SetReportOutputPath;

    /// <summary>
    ///   Selected formats for the report output.
    /// </summary>
    property OutputFormats : TOutputFormatSet
      read   GetOutputFormats
      write  SetOutputFormats;
  end;

implementation

{ TProgramSourceFilesEnumerator }

constructor TProgramSourceFilesEnumerator.Create(aList: IProgramSourceFiles);
begin
  inherited Create;

  FList  := aList;
  FIndex := -1;
end;

function TProgramSourceFilesEnumerator.GetCurrent: IProgramSourceFileItem;
begin
  Result := FList[FIndex];
end;

function TProgramSourceFilesEnumerator.MoveNext: Boolean;
begin
  Result := FIndex < (FList.Count - 1);
  if Result then
    Inc(FIndex);
end;

end.
