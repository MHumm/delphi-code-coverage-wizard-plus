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
///   Management of the code coverage project settings themselves.
///   Author of original version: TridentT
/// </summary>

{$M+} // Intentional because it's required for getting some property via RTTI
unit UProjectSettings;

interface

uses
  System.SysUtils,
  System.Classes,
  Generics.Collections,
  Xml.XMLIntf,
  UProjectSettingsInterface;

type
  /// <summary>
  ///   One entry in the lsit of source files to analyze
  /// </summary>
  TProgramSourceFileItem = class(TInterfacedObject, IProgramSourceFileItem)
  strict private
    /// <summary>
    ///   Name of a file from the soruce directory specified
    /// </summary>
    FFilename : string;
    /// <summary>
    ///   If true the file is selected for analysis. Otherwise it is not analyzed.
    /// </summary>
    FSelected : Boolean;

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
  public
    /// <summary>
    ///   Creates the instance and initializes its fields
    /// </summary>
    /// <param name="FileName">
    ///   Path and file name of a source file from the source folder
    /// </param>
    constructor Create(const AFilename : string);
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

  /// <summary>
  ///   List of all source files and their properties
  /// </summary>
  TProgramSourceFileItemList = TList<IProgramSourceFileItem>;

  /// <summary>
  ///   List of source files, relatively based on a specified base path
  /// </summary>
  TProgramSourceFiles = class(TInterfacedObject, IProgramSourceFiles)
  private
    /// <summary>
    ///   Base path to which all files names are relatively encoded
    /// </summary>
    FBasePath : TFilename;
    /// <summary>
    ///   List of all source files, selected and unselected ones. Paths are
    ///   stored in relatively encoded to FBasePath
    /// </summary>
    FItemList : TProgramSourceFileItemList;

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
    ///   Checks, whether the given file is in a path which contains one of the
    ///   folders to be excluded.
    /// </summary>
    /// <param name="FileName">
    ///   Path and name of the file to check.
    /// </param>
    /// <returns>
    ///   true, if there is either __history or __recovery in the path somewhere,
    ///   otherwise false is returned.
    /// </returns>
    function IsInExcludePath(FileName: string): Boolean;
    /// <summary>
    ///   Sorts the list items by file name ascending (ignoring string case)
    /// </summary>
    procedure Sort;
  public
    /// <summary>
    ///   Initializes internal data
    /// </summary>
    /// <param name="BasePath">
    ///   Root path under which all project source files are located
    /// </param>
    constructor Create(const BasePath: TFileName = '');
    /// <summary>
    ///   Frees the internal list
    /// </summary>
    destructor  Destroy; override;
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
  end;

  /// <summary>
  ///   Attribute for mapping settings to XML nodes
  /// </summary>
  SettingsAttribute = class(TCustomAttribute)
  strict private
    /// <summary>
    ///   Category in which the setting is
    /// </summary>
    FCategory : string;
    /// <summary>
    ///   Name of the actual setting
    /// </summary>
    FProperty : string;
  public
    /// <summary>
    ///   Initialize the object
    /// </summary>
    /// <param name="aCategory">
    ///   Category in which the setting is
    /// </param>
    /// <param name="aProperty">
    ///   Name of the actual setting
    /// </param>
    constructor Create(const aCategory, aProperty: string);

    /// <summary>
    ///   Category in which the setting is
    /// </summary>
    property Category : string
      read   FCategory;
    /// <summary>
    ///   Name of the actual setting
    /// </summary>
    property PropertyName : string
      read   FProperty;
  end;

  /// <summary>
  ///   Manages all settings of the project
  /// </summary>
  TProjectSettings = class(TInterfacedObject,
                           IProjectOutputSettingsReadOnly, IProjectSettings)
  private
    /// <summary>
    ///   Path to the executable to analyze. Absolutely encoded.
    /// </summary>
    FExecutableToAnalyze  : TFilename;
    /// <summary>
    ///   Path to the map file of the program to analyze. Absolutely encoded.
    /// </summary>
    FMapFile              : TFilename;
    /// <summary>
    ///   List of all source files for the program including the information
    ///   which ones are actually selected to be included in the analysis.
    /// </summary>
    FProgramSourceFiles   : IProgramSourceFiles;
    /// <summary>
    ///   Path where the batch file to call the code coverage cmd line tool will
    ///   be stored.
    /// </summary>
    FScriptsOutputPath    : TFilename;
    /// <summary>
    ///   Path where the report(s) will be output to.
    /// </summary>
    FReportOutputPath     : TFilename;
    /// <summary>
    ///   Path to the application to analyze.
    /// </summary>
    FCodeCoverageExePath  : TFilename;
    /// <summary>
    ///   Selected formats for the report output.
    /// </summary>
    FOutputFormats        : TOutputFormatSet;
    /// <summary>
    ///   Displays the newly generated EMMA-file in the associated viewer
    ///   via ShellExecute
    /// </summary>
    [SettingsAttribute('OutputSettings', 'DisplayEMMAExternally')]
    FDisplayEMMAFileExt   : Boolean;
    /// <summary>
    ///   Displays the newly generated XML-file in the associated viewer
    ///   via ShellExecute
    /// </summary>
    [SettingsAttribute('OutputSettings', 'DisplayXMLExternally')]
    FDisplayXMLFileExt    : Boolean;
    /// <summary>
    ///   Displays the newly generated XML-file in the associated viewer
    ///   via ShellExecute
    /// </summary>
    [SettingsAttribute('OutputSettings', 'DisplayHTMLExternally')]
    FDisplayHTMLFileExt   : Boolean;
    /// <summary>
    ///   When true, paths are relative to the script path where the batch file
    ///   is stored.
    /// </summary>
    [SettingsAttribute('MiscSettings', 'UseRelativePaths')]
    FRelativeToScriptPath : Boolean;

    /// <summary>
    ///   When true the generated XML output file(s) will contain line numbers
    /// </summary>
    [SettingsAttribute('OutputSettings', 'XMLLineNumbers')]
    FAddLineNumbersToXML  : Boolean;
    /// <summary>
    ///   When true combines lines coverage for multiple occurrences of the same
    ///  filename (especially usefull in case of generic classes)
    /// </summary>
    [SettingsAttribute('OutputSettings', 'XMLCombineLines')]
    FCombineXMLCoverage   : Boolean;
    /// <summary>
    ///   Generate XML output in the format generated by Java's Jacoco coverage
    ///   library
    /// </summary>
    [SettingsAttribute('OutputSettings', 'XMLJacocoFormat')]
    FXMLJacocoFormat      : Boolean;

    /// <summary>
    ///   Any "free form" parameters specified
    /// </summary>
    FAdditionalParameter  : string;
    /// <summary>
    ///   Name of the saved or loaded project file
    /// </summary>
    FFileName             : string;
    /// <summary>
    ///   Version of this application, which will be written into the saved
    ///   project file
    /// </summary>
    FProgramVersion       : string;

    /// <summary>
    ///   Returns the path to the executable to analyze. Absolutely encoded.
    /// </summary>
    function GetProgramToAnalyze: TFilename;
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
    ///   Returns the name of the generated batch file
    /// </summary>
    function GetBatchFileName: TFileName;
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
    ///   Returns the name of the loaded or saved project file
    /// </summary>
    function GetFileName: string;
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
    ///   Returns the selected output formats to create
    /// </summary>
    function GetOutputFormats: TOutputFormatSet;
    /// <summary>
    ///   Sets the selected output formats to create
    /// </summary>
    procedure SetOutputFormats(const Value: TOutputFormatSet);
    /// <summary>
    ///   Saves the values of all boolean fields which have the right attribute
    ///   defining where in the XML file to save it.
    /// </summary>
    procedure SaveBooleans(Document: IXMLDocument);

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
  public
    /// <summary>
    ///   Creates the instance and its internal objects and preinitializes the
    ///   path to the code coverage exe file so that even if no existing project
    ///   is loaded this path is predefined with the one supplied here.
    /// </summary>
    /// <param name="CodeCoverageExe">
    ///   Path and file name of the code coverage command line tool to use.
    ///   By default the one supplied with this project will be suggested.
    /// </param>
    /// <param name="Version">
    ///   Version information of the wizard's exe
    /// </param>
    constructor Create(const CodeCoverageExe : TFileName;
                       const Version         : string);
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
    ///   Returns the name of the generated batch file
    /// </summary>
    property BatchFileName : TFileName
      read   GetBatchFileName;
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
    property  DisplayHTMLFileExt : Boolean
      read    GetDisplayHTMLFileExt
      write   SetDisplayHTMLFileExt;

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
  published
    // Necessary to be able to use RTTI for this one

    /// <summary>
    ///   Selected formats for the report output.
    /// </summary>
    property OutputFormats : TOutputFormatSet
      read   GetOutputFormats
      write  SetOutputFormats;
  end;

implementation

uses
  System.Types,
  System.TypInfo,
  System.IOUtils,
  System.Generics.Defaults,
  System.Win.ComObj,
  System.Rtti,
  Xml.XMLDoc,
  UConsts;

{ TProjectSettings }

constructor TProjectSettings.Create(const CodeCoverageExe : TFileName;
                                    const Version         : string);
begin
  inherited Create;

  FProgramSourceFiles  := TProgramSourceFiles.Create;
  FCodeCoverageExePath := CodeCoverageExe;
  FProgramVersion      := Version;
end;

function TProjectSettings.GetAdditionalParameter: string;
begin
  Result := FAdditionalParameter;
end;

function TProjectSettings.GetAddLineNumbersToXML: Boolean;
begin
  Result := FAddLineNumbersToXML;
end;

function TProjectSettings.GetBatchFileName: TFileName;
begin
  Result := TPath.Combine(FScriptsOutputPath,
              TPath.GetFileNameWithoutExtension((FFileName)) +
              cBatchFileSuffix);
end;

function TProjectSettings.GetCodeCoverageExePath: TFilename;
begin
  Result := FCodeCoverageExePath;
end;

function TProjectSettings.GetCombineXMLCoverage: Boolean;
begin
  Result := FCombineXMLCoverage;
end;

function TProjectSettings.GetDisplayEMMAFileExt: Boolean;
begin
  Result := FDisplayEMMAFileExt;
end;

function TProjectSettings.GetDisplayHTMLFileExt: Boolean;
begin
  Result := FDisplayHTMLFileExt;
end;

function TProjectSettings.GetDisplayXMLFileExt: Boolean;
begin
  Result := FDisplayXMLFileExt;
end;

function TProjectSettings.GetFileName: string;
begin
  Result := FFileName;
end;

function TProjectSettings.GetMapFile: TFilename;
begin
  Result := FMapFile;
end;

function TProjectSettings.GetOutputFormats: TOutputFormatSet;
begin
  Result := FOutputFormats;
end;

function TProjectSettings.GetProgramSourceFiles: IProgramSourceFiles;
begin
  Result := FProgramSourceFiles;
end;

function TProjectSettings.GetProgramSourcePath: TFilename;
begin
  Result := FProgramSourceFiles.BasePath;
end;

function TProjectSettings.GetProgramToAnalyze: TFilename;
begin
  Result := FExecutableToAnalyze;
end;

function TProjectSettings.IsAnyDataDefined: Boolean;
begin
  Result := IsExeAndMapDefined or //IsSourcePathAndFilesDefined or
            IsOutputSettingsDefined or FRelativeToScriptPath; // or
            //(FCodeCoverageExePath <> '');
end;

function TProjectSettings.IsExeAndMapDefined: Boolean;
begin
  Result := (FExecutableToAnalyze <> '') and (FMapFile <> '');
end;

function TProjectSettings.IsOutputSettingsDefined: Boolean;
begin
  Result := (FReportOutputPath <> '') and (FScriptsOutputPath <> '') and
            (FOutputFormats <> []);
end;

function TProjectSettings.IsSourcePathAndFilesDefined: Boolean;
begin
  Result := (FProgramSourceFiles.BasePath <> '') and
            (FProgramSourceFiles.SelectedCount > 0);
end;

procedure TProjectSettings.LoadFromXML(const FileName: string);
var
  LDocument: IXMLDocument;
  LUnitTestFiles, LSourceFiles, LOutput, LMisc, LNode: IXMLNode;
  SourceFileName : string;
  IsSelected      : Boolean;
begin
  Assert(FileName <> '', 'No file name for the XML file specified');

  FFileName         := FileName;

  LDocument         := TXMLDocument.Create(FFileName);
  try
    LDocument.Options := [doNodeAutoIndent];
    LDocument.Active  := true;

    // unit test exe to run and map file for that
    LUnitTestFiles := LDocument.DocumentElement.ChildNodes['UnitTestFiles'];
    if Assigned(LUnitTestFiles) then
    begin
      LNode := LUnitTestFiles.ChildNodes.FindNode('ExecutableToAnalyze');
      if Assigned(LNode) then
        FExecutableToAnalyze := LNode.Text;

      LNode := LUnitTestFiles.ChildNodes.FindNode('MapFile');
      if Assigned(LNode) then
        FMapFile             := LNode.Text;

      LNode := LUnitTestFiles.ChildNodes.FindNode('CodeCoverageExe');
      if Assigned(LNode) then
        FCodeCoverageExePath := LNode.Text;
    end;

    // Source code files
    LSourceFiles := LDocument.DocumentElement.ChildNodes['SourceCodeFiles'];
    if Assigned(LSourceFiles) then
    begin
      LNode := LSourceFiles.ChildNodes.FindNode('SourceBasePath');
      if Assigned(LNode) then
      begin
        FProgramSourceFiles := nil;
        FProgramSourceFiles := TProgramSourceFiles.Create(LNode.Text);
      end;

      LNode := LSourceFiles.ChildNodes.FindNode('SourceFile');
      while Assigned(LNode) do
      begin
        SourceFileName := LNode.Text;
        if LNode.HasAttribute('Selected') then
          IsSelected := StrToBool(LNode.Attributes['Selected'])
        else
          IsSelected := false;

        FProgramSourceFiles.AddFile(SourceFileName, IsSelected);

        LNode := LNode.NextSibling;
      end;
    end;

    // OutputSettings
    LOutput := LDocument.DocumentElement.ChildNodes['OutputSettings'];
    if Assigned(LOutput) then
    begin
      LNode := LOutput.ChildNodes.FindNode('ScriptOutputPath');
      if Assigned(LNode) then
        FScriptsOutputPath := LNode.Text;

      LNode := LOutput.ChildNodes.FindNode('ReportOutputPath');
      if Assigned(LNode) then
        FReportOutputPath := LNode.Text;

      LNode := LOutput.ChildNodes.FindNode('ReportOutputFormats');
      if Assigned(LNode) then
        System.TypInfo.SetSetProp(self, 'OutputFormats', LNode.Text);

      LNode := LOutput.ChildNodes.FindNode('DisplayEMMAExternally');
      if Assigned(LNode) then
        FDisplayEMMAFileExt := StrToBool(LNode.Text);

      LNode := LOutput.ChildNodes.FindNode('DisplayXMLExternally');
      if Assigned(LNode) then
        FDisplayXMLFileExt := StrToBool(LNode.Text);

      LNode := LOutput.ChildNodes.FindNode('DisplayHTMLExternally');
      if Assigned(LNode) then
        FDisplayHTMLFileExt := StrToBool(LNode.Text);

      LNode := LOutput.ChildNodes.FindNode('XMLLineNumbers');
      if Assigned(LNode) then
        FAddLineNumbersToXML := StrToBool(LNode.Text);

      LNode := LOutput.ChildNodes.FindNode('XMLCombineLines');
      if Assigned(LNode) then
        FCombineXMLCoverage := StrToBool(LNode.Text);

      LNode := LOutput.ChildNodes.FindNode('XMLJacocoFormat');
      if Assigned(LNode) then
        FXMLJacocoFormat := StrToBool(LNode.Text);
    end;

    // Misc. Settings
    LMisc := LDocument.DocumentElement.ChildNodes['MiscSettings'];
    if Assigned(LMisc) then
    begin
      LNode := LMisc.ChildNodes.FindNode('AdditionalParams');
      if Assigned(LNode) then
        FAdditionalParameter := LNode.Text;

      LNode := LMisc.ChildNodes.FindNode('UseRelativePaths');
      if Assigned(LNode) then
        FRelativeToScriptPath := StrToBool(LNode.Text);
    end;

//    LDocument.Active := false;
  finally
    LUnitTestFiles := nil;
    LSourceFiles   := nil;
    LOutput        := nil;
    LMisc          := nil;
    LNode          := nil;
  end;
end;

procedure TProjectSettings.SeCodeCoverageExePath(const Value: TFilename);
begin
  FCodeCoverageExePath := Value;
end;

procedure TProjectSettings.SetAdditionalParameter(const Value: string);
begin
  FAdditionalParameter := Value;
end;

procedure TProjectSettings.SetAddLineNumbersToXML(const Value: Boolean);
begin
  FAddLineNumbersToXML := Value;
end;

procedure TProjectSettings.SetCombineXMLCoverage(const Value: Boolean);
begin
  FCombineXMLCoverage := Value;
end;

procedure TProjectSettings.SetDisplayEMMAFileExt(const Value: Boolean);
begin
  FDisplayEMMAFileExt := Value;
end;

procedure TProjectSettings.SetDisplayHTMLFileExt(const Value: Boolean);
begin
  FDisplayHTMLFileExt := Value;
end;

procedure TProjectSettings.SetDisplayXMLFileExt(const Value: Boolean);
begin
  FDisplayXMLFileExt := Value;
end;

procedure TProjectSettings.SetMapFile(const Value: TFilename);
begin
  FMapFIle := Value;
end;

procedure TProjectSettings.SetOutputFormats(const Value: TOutputFormatSet);
begin
  FOutputFormats := Value;
end;

procedure TProjectSettings.SetProgramSourceBasePath(const Value: TFilename);
begin
  if (FProgramSourceFiles.BasePath <> Value) then
    FProgramSourceFiles.BasePath := Value;
end;

procedure TProjectSettings.SetProgramSourceFiles(const Value: IProgramSourceFiles);
begin
  FProgramSourceFiles := Value;
end;

procedure TProjectSettings.SetProgramToAnalyze(const Value: TFilename);
var
  PossibleMappingFilename : TFilename;
begin
  FExecutableToAnalyze := Value;
  // test EXE file exists
  if (FileExists(Value)) then
  begin
    PossibleMappingFilename := ChangeFileExt(Value, cMapFileExt);
    if (FileExists(PossibleMappingFilename)) then
      FMapFile := PossibleMappingFilename;
  end;
end;

procedure TProjectSettings.SetRelativeToScriptPath(const Value: Boolean);
begin
  FRelativeToScriptPath := Value;
end;

procedure TProjectSettings.SetReportOutputPath(const Value: TFilename);
begin
  FReportOutputPath := Value;
end;

procedure TProjectSettings.SetScriptsOutputPath(const Value: TFilename);
begin
  FScriptsOutputPath := Value;
end;

procedure TProjectSettings.SetXMLJacocoFormat(const Value: Boolean);
begin
  FXMLJacocoFormat := Value;
end;

function TProjectSettings.GetRelativePath(const APath: string): string;
begin
  // Extract path relative to scripts relative
  Result := ExtractRelativepath(FScriptsOutputPath, APath);
end;

function TProjectSettings.GetRelativeToScriptPath: Boolean;
begin
  Result := FRelativeToScriptPath;
end;

function TProjectSettings.GetReportOutputIndexURL: string;
begin
  Result := Format('file:///%:0s/' + cHTMLOutputBaseFileName,
             [string(FReportOutputPath).Replace('\', '/', [rfReplaceAll]).
              Replace(' ', '%20', [rfReplaceAll])])
end;

function TProjectSettings.GetReportOutputPath: TFilename;
begin
  Result := FReportOutputPath;
end;

function TProjectSettings.GetScriptsOutputPath: TFilename;
begin
  Result := FScriptsOutputPath;
end;

function TProjectSettings.GetXMLJacocoFormat: Boolean;
begin
  Result := FXMLJacocoFormat;
end;

procedure TProjectSettings.SaveToXML(const FileName: TFileName);
var
  LDocument: IXMLDocument;
  LVersion, LUnitTestFiles, LSourceFiles, LOutput, LMisc, LNodeElement: IXMLNode;
begin
  Assert(FileName <> '', 'No file name for the XML file specified');

  FFileName         := FileName;

  LDocument         := TXMLDocument.Create(nil);
  LDocument.Active  := true;
  LDocument.Options := [doNodeAutoIndent];

  LDocument.DocumentElement := LDocument.CreateNode('DCCProject', ntElement, '');
  LDocument.DocumentElement.Attributes['xmlns'] := '';

  // Store application version
  LVersion          := LDocument.DocumentElement.AddChild('VersionInfo', -1);
  LNodeElement      := LVersion.AddChild('ApplicationVersion', -1);
  LNodeElement.Text := FProgramVersion;

  // Store file format version
  LNodeElement      := LVersion.AddChild('FileFormatVersion', -1);
  LNodeElement.Text := cFileFormatVersion.ToString;

  // unit test exe to run and map file for that
  LUnitTestFiles    := LDocument.DocumentElement.AddChild('UnitTestFiles', -1);
  LNodeElement      := LUnitTestFiles.AddChild('ExecutableToAnalyze', -1);
  LNodeElement.Text := FExecutableToAnalyze;

  LNodeElement      := LUnitTestFiles.AddChild('MapFile', -1);
  LNodeElement.Text := FMapFile;

  LNodeElement      := LUnitTestFiles.AddChild('CodeCoverageExe', -1);
  LNodeElement.Text := FCodeCoverageExePath;

  // Source code to analyze
  LSourceFiles      := LDocument.DocumentElement.AddChild('SourceCodeFiles', -1);
  LNodeElement      := LSourceFiles.AddChild('SourceBasePath', -1);
  LNodeElement.Text := FProgramSourceFiles.BasePath;

  for var SourceFileItem in FProgramSourceFiles do
  begin
    LNodeElement      := LSourceFiles.AddChild('SourceFile', -1);
    LNodeElement.Text := SourceFileItem.Filename;
    LNodeElement.SetAttribute('Selected', BoolToStr(SourceFileItem.Selected, true));
  end;

  // Output options
  LOutput           := LDocument.DocumentElement.AddChild('OutputSettings', -1);
  LNodeElement      := LOutput.AddChild('ScriptOutputPath', -1);
  LNodeElement.Text := FScriptsOutputPath;

  LNodeElement      := LOutput.AddChild('ReportOutputPath', -1);
  LNodeElement.Text := FReportOutputPath;

  LNodeElement      := LOutput.AddChild('ReportOutputFormats', -1);
  LNodeElement.Text := System.TypInfo.GetSetProp(self, 'OutputFormats', false);

  // Miscelleanous settings
  LMisc             := LDocument.DocumentElement.AddChild('MiscSettings', -1);
  LNodeElement      := LMisc.AddChild('AdditionalParams', -1);
  LNodeElement.Text := FAdditionalParameter;

  SaveBooleans(LDocument);

  LDocument.SaveToFile(FFileName);
end;

procedure TProjectSettings.SaveBooleans(Document: IXMLDocument);
var
  Context    : TRTTIContext;
  ClassRTTI  : TRttiType;
  Fields     : TArray<TRttiField>;
  Field      : TRttiField;
  Attributes : TArray<TCustomAttribute>;
  Attribute  : TCustomAttribute;
  CategoryNode, PropertyNode: IXMLNode;
begin
  ClassRTTI := Context.GetType(TProjectSettings.ClassInfo);
  Fields   := ClassRTTI.GetFields;
  for Field in Fields do
  begin
    Attributes := Field.GetAttributes;

    for Attribute in Attributes do
      if Attribute is SettingsAttribute then
      begin
        CategoryNode := Document.ChildNodes.FindNode('DCCProject').
                          ChildNodes.FindNode(
                            (Attribute as SettingsAttribute).Category);

        // Only create parent/category node if necessary
        if not Assigned(CategoryNode) then
          CategoryNode := Document.DocumentElement.AddChild(
                            (Attribute as SettingsAttribute).Category, -1);

        PropertyNode      := CategoryNode.AddChild(
                              (Attribute as SettingsAttribute).PropertyName, -1);
        PropertyNode.Text := BoolToStr(Field.GetValue(self).AsBoolean, true);
      end;
  end;
end;

{ TProgramSourceFiles }

procedure TProgramSourceFiles.AddFile(const AItemFilename : TFilename;
                                      IsSelected          : Boolean);
var
  NewItem             : IProgramSourceFileItem;
  NewItemRelativePath : TFilename;
begin
  NewItemRelativePath := ExtractRelativePath(FBasePath, AItemFilename);
  NewItem             := TProgramSourceFileItem.Create(NewItemRelativePath);
  NewItem.Selected    := IsSelected;
  FItemList.Add(NewItem);
end;

procedure TProgramSourceFiles.ChangeSelected(Index: Integer; Checked: Boolean);
begin
  FItemList[Index].Selected := Checked;
end;

constructor TProgramSourceFiles.Create(const BasePath: TFileName);
begin
  inherited Create;

  FItemList := TProgramSourceFileItemList.Create;
  FBasePath := BasePath;
end;

destructor TProgramSourceFiles.Destroy;
begin
  FItemList.Free;

  inherited;
end;

function TProgramSourceFiles.GetBasePath: TFilename;
begin
  Result := FBasePath;
end;

procedure TProgramSourceFiles.GetCheckedItemsList(const ACheckedList: TStrings);
var
  SourceFileItem: IProgramSourceFileItem;
begin
  Assert(Assigned(ACheckedList), 'Non assigned list specified!');

  ACheckedList.Clear;
  ACheckedList.BeginUpdate;
  try
    for SourceFileItem in self do //FItemList do
    begin
      if (SourceFileItem.Selected) then
        ACheckedList.Add(SourceFileItem.Filename);
    end;
  finally
    ACheckedList.EndUpdate;
  end;
end;

function TProgramSourceFiles.GetCount: Integer;
begin
  Result := FItemList.Count;
end;

function TProgramSourceFiles.GetEnumerator: TProgramSourceFilesEnumerator;
begin
  Result := TProgramSourceFilesEnumerator.Create(self);
end;

function TProgramSourceFiles.GetItem(Index: Integer): IProgramSourceFileItem;
begin
  Result := FItemList[Index];
end;

procedure TProgramSourceFiles.GetItemsList(const AList: TStrings);
var
  SourceFileItem: IProgramSourceFileItem;
begin
  Assert(Assigned(AList), 'Non assigned list specified!');

  AList.Clear;
  AList.BeginUpdate;
  try
    for SourceFileItem in FItemList do
      AList.Add(SourceFileItem.Filename);
  finally
    AList.EndUpdate;
  end;
end;

function TProgramSourceFiles.GetSelectedCount: Integer;
begin
  Result := 0;
  for var i := 0 to FItemList.Count - 1 do
    if FItemList[i].Selected then
      inc(Result);
end;

function TProgramSourceFiles.IsSelected(Index: Integer): Boolean;
begin
  Result := FItemList[Index].Selected;
end;

procedure TProgramSourceFiles.ReplaceSourceFilesList;
var
  FileList : TStringDynArray;
  Item     : IProgramSourceFileItem;
begin
  FItemList.Clear;

  if (FBasePath <> System.SysUtils.PathDelim) then
  begin
    FileList := TDirectory.GetFiles(FBasePath,
                                    cSourceExt,
                                    TSearchOption.soAllDirectories);

    for var FileName in FileList do
    begin
      Item := TProgramSourceFileItem.Create(FileName);
      FItemList.Add(Item);
      if IsInExcludePath(FileName) then
        Item.Selected := false;
    end;

    Sort;
  end;
end;

procedure TProgramSourceFiles.SetBasePath(const Value: TFilename);
var
  NewValue : TFileName;
begin
  NewValue := Value;

  if not string(NewValue).EndsWith(System.SysUtils.PathDelim) then
    NewValue := NewValue + System.SysUtils.PathDelim;

  if (FBasePath <> NewValue) then
  begin
    FBasePath := NewValue;
    ReplaceSourceFilesList;
  end;
end;

procedure TProgramSourceFiles.UpdateSourceFilesList;
var
  FileList : TStringDynArray;
  Item     : IProgramSourceFileItem;
  Exists   : Boolean;
  n        : Integer;
begin
  FItemList.Clear;

  // exit if no proper path is specified as otherwise all pas files in all
  // folders on disk would be found or something like this...
  if (FBasePath = System.SysUtils.PathDelim) then
    exit;

  FileList := TDirectory.GetFiles(FBasePath,
                                  cSourceExt,
                                  TSearchOption.soAllDirectories);

  // remove all files no longer on disk
  n := 0;
  while (n < FItemList.Count) do
  begin
    Item   := FItemList[n];
    Exists := false;
    for var i := 0 to High(FileList) do
    begin
      if (Item.Filename = FileList[i]) then
      begin
        Exists := true;
        break;
      end;
    end;

    if Exists then
      inc(n)
    else
      FItemList.Delete(n);
  end;

  // add all files to the list which are on disk but not in the list yet
  n := 0;
  while (n < length(FileList)) do
  begin
    Exists := false;
    for var i := 0 to FItemList.Count - 1 do
    begin
      if (FItemList[i].Filename = FileList[n]) then
      begin
        Exists := true;
        break;
      end;
    end;

    if not Exists then
    begin
      Item := TProgramSourceFileItem.Create(FileList[n]);
      FItemList.Add(Item);

      if IsInExcludePath(FileList[n]) then
        Item.Selected := false;
    end;

    inc(n);
  end;

  // List must be sorted to match the sorted checklist box in which it will
  // be displayed
  Sort;
end;

function TProgramSourceFiles.IsInExcludePath(FileName: string): Boolean;
begin
  Result := FileName.Contains(System.SysUtils.PathDelim +
                              '__history' +
                              System.SysUtils.PathDelim) or
            FileName.Contains(System.SysUtils.PathDelim +
                              '__recovery' +
                              System.SysUtils.PathDelim);
end;

procedure TProgramSourceFiles.Sort;
begin
  FItemList.Sort(TComparer<IProgramSourceFileItem>.Construct(
                    function (const L, R: IProgramSourceFileItem): integer
                    begin
                      Result := CompareText(L.Filename, R.Filename);
                    end
                 ));
end;

{ TProgramSourceFileItem }

constructor TProgramSourceFileItem.Create(const AFilename: string);
begin
  inherited Create;

  FFilename := AFilename;
  FSelected := True;
end;

function TProgramSourceFileItem.GetFilename: string;
begin
  Result := FFilename;
end;

function TProgramSourceFileItem.GetSelected: Boolean;
begin
  Result := FSelected;
end;

procedure TProgramSourceFileItem.SetFilename(const Value: string);
begin
  FFilename := Value;
end;

procedure TProgramSourceFileItem.SetSelected(const Value: Boolean);
begin
  FSelected := Value;
end;

{ SettingsAttribute }

constructor SettingsAttribute.Create(const aCategory, aProperty: string);
begin
  inherited Create;

  FCategory := aCategory;
  FProperty := aProperty;
end;

end.
