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
  Generics.Collections;

type
  /// <summary>
  ///   Possible output formats for the report
  /// </summary>
  TOutputFormat = (ofEMMA, ofMETA, ofXML, ofHTML);

  /// <summary>
  ///   One entry in the lsit of source files to analyze
  /// </summary>
  TProgramSourceFileItem = class(TObject)
  strict private
    /// <summary>
    ///   Name of a file from the soruce directory specified
    /// </summary>
    FFilename : string;
    /// <summary>
    ///   If true the file is selected for analysis. Otherwise it is not analyzed.
    /// </summary>
    FSelected : Boolean;
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
    property Filename : string read FFilename write FFilename;
    /// <summary>
    ///   If true the file is selected for analysis. Otherwise it is not
    ///   analyzed. Directly after construction the entry is considered to
    ///   be selected.
    /// </summary>
    property Selected : Boolean read FSelected write FSelected;
  end;

  /// <summary>
  ///   List of source files, relatively based on a specified base path
  /// </summary>
  TProgramSourceFiles = class(TObject)
  private
    /// <summary>
    ///   Base path to which all files names are relatively encoded
    /// </summary>
    FBasePath : TFilename;
    /// <summary>
    ///   List of all source files, selected and unselected ones. Paths are
    ///   stored in relatively encoded to FBasePath
    /// </summary>
    FItemList : TObjectList<TProgramSourceFileItem>;

    /// <summary>
    ///   Returns the number of files contained in the list
    /// </summary>
    function GetCount: Integer;
    /// <summary>
    ///   Returns the number of selected files contained in the list
    /// </summary>
    function GetSelectedCount: Integer;
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
    ///   frees internal data
    /// </summary>
    destructor Destroy; override;
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
    ///   Returns a list of all selected source files.
    /// </summary>
    /// <param name="ACheckedList">
    ///   List object to which all source files are added.
    ///   The list is initially cleared.
    /// </param>
    procedure GetItemsList(const ACheckedList : TStrings);
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
    ///   Specifies the base path to which all file names are stored relatively
    /// </summary>
    property BasePath : TFilename
      read   FBasePath
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
  ///   Manages all settings of the project
  /// </summary>
  TProjectSettings = class(TObject)
  public
    /// <summary>
    ///   Set of possible output formats
    /// </summary>
    type TOutputFormatSet = set of TOutputFormat;
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
    FProgramSourceFiles   : TProgramSourceFiles;
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
    ///   When true, paths are relative to the script path where the batch file
    ///   is stored.
    /// </summary>
    FRelativeToScriptPath : Boolean;
    /// <summary>
    ///   Name of the saved or loaded project file
    /// </summary>
    FFileName             : string;

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
  public
    /// <summary>
    ///   Creates the instance and its internal objects and preinitializes the
    ///   path to the code coverage exe file so that even if no existing project
    ///   is loaded this path is predefined with the one supplied here.
    /// </summary>
    constructor Create(const CodeCoverageExe : TFileName);
    /// <summary>
    ///   Frees internally created objects.
    /// </summary>
    destructor Destroy; override;
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
    procedure LoadFromXML(const FileName: TFileName);

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
      write  FMapFile;
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
    property ProgramSourceFiles : TProgramSourceFiles
      read   FProgramSourceFiles
      write  FProgramSourceFiles;
    /// <summary>
    ///   Path where the batch file to call the code coverage cmd line tool will
    ///   be stored.
    /// </summary>
    property ScriptsOutputPath : TFilename
      read   FScriptsOutputPath
      write  FScriptsOutputPath;
    /// <summary>
    ///   Path where the report(s) will be output to.
    /// </summary>
    property ReportOutputPath : TFilename
      read   FReportOutputPath
      write  FReportOutputPath;
    /// <summary>
    ///   Path to the application to analyze.
    /// </summary>
    property CodeCoverageExePath : TFilename
      read   FCodeCoverageExePath
      write  FCodeCoverageExePath;
    /// <summary>
    ///   When true, paths are relative to the script path where the batch file
    ///   is stored. Otherwise paths are absolute.
    /// </summary>
    property RelativeToScriptPath : Boolean
      read   FRelativeToScriptPath
      write  FRelativeToScriptPath;

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
      read   FFileName;
  published
    // Necessary to be able to use RTTI for this one

    /// <summary>
    ///   Selected formats for the report output.
    /// </summary>
    property OutputFormats : TOutputFormatSet
      read   FOutputFormats
      write  FOutputFormats;
  end;

implementation

uses
  System.Types,
  System.TypInfo,
  System.IOUtils,
  System.Generics.Defaults,
  System.Win.ComObj,
  Xml.XMLIntf,
  Xml.XMLDoc;

{ TProjectSettings }

constructor TProjectSettings.Create(const CodeCoverageExe : TFileName);
begin
  inherited Create;

  FProgramSourceFiles  := TProgramSourceFiles.Create;
  FCodeCoverageExePath := CodeCoverageExe;
end;

destructor TProjectSettings.Destroy;
begin
  FreeAndNil(FProgramSourceFiles);
  inherited;
end;

function TProjectSettings.GetBatchFileName: TFileName;
begin
  Result := TPath.Combine(FScriptsOutputPath,
              TPath.GetFileNameWithoutExtension((FFileName)) +
              '_dcov_execute.bat');
end;

function TProjectSettings.GetMapFile: TFilename;
begin
  Result := FMapFile;
end;

function TProjectSettings.GetProgramSourcePath: TFilename;
begin
  Result := FProgramSourceFiles.FBasePath;
end;

function TProjectSettings.GetProgramToAnalyze: TFilename;
begin
  Result := FExecutableToAnalyze;
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

procedure TProjectSettings.LoadFromXML(const FileName: TFileName);
var
  LDocument: IXMLDocument;
  LUnitTestFiles, LSourceFiles, LOutput, LMisc, LNode: IXMLNode;
  SourceFileName : string;
  IsSelected      : Boolean;
begin
  Assert(FileName <> '', 'No file name for the XML file specified');

  FFileName         := FileName;

  LDocument         := TXMLDocument.Create(nil);
  LDocument.Active  := true;
  LDocument.Options := [doNodeAutoIndent];

  LDocument.LoadFromFile(FFileName);

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
      FProgramSourceFiles.Free;
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
  end;

  // Misc. Settings
  LMisc := LDocument.DocumentElement.ChildNodes['MiscSettings'];
  if Assigned(LMisc) then
  begin
    LNode := LMisc.ChildNodes.FindNode('UseRelativePaths');
    if Assigned(LNode) then
      FRelativeToScriptPath := StrToBool(LNode.Text);
  end;
end;

procedure TProjectSettings.SetProgramSourceBasePath(const Value: TFilename);
begin
  if (FProgramSourceFiles.BasePath <> Value) then
    FProgramSourceFiles.BasePath := Value;
end;

procedure TProjectSettings.SetProgramToAnalyze(const Value: TFilename);
var
  PossibleMappingFilename : TFilename;
begin
  FExecutableToAnalyze := Value;
  // test EXE file exists
  if (FileExists(Value)) then
  begin
    PossibleMappingFilename := ChangeFileExt(Value, '.map');
    if (FileExists(PossibleMappingFilename)) then
      FMapFile := PossibleMappingFilename;
  end;
end;

function TProjectSettings.GetRelativePath(const APath: string): string;
begin
  // Extract path relative to scripts relative
  Result := ExtractRelativepath(FScriptsOutputPath, APath);
end;

function TProjectSettings.GetReportOutputIndexURL: string;
begin
  Result := Format('file:///%:0s/CodeCoverage_summary.html',
             [string(FReportOutputPath).Replace('\', '/', [rfReplaceAll]).
              Replace(' ', '%20', [rfReplaceAll])])
end;

procedure TProjectSettings.SaveToXML(const FileName: TFileName);
var
  LDocument: IXMLDocument;
  LUnitTestFiles, LSourceFiles, LOutput, LMisc, LNodeElement: IXMLNode;
begin
  Assert(FileName <> '', 'No file name for the XML file specified');

  FFileName         := FileName;

  LDocument         := TXMLDocument.Create(nil);
  LDocument.Active  := true;
  LDocument.Options := [doNodeAutoIndent];

  LDocument.DocumentElement := LDocument.CreateNode('DCCProject', ntElement, '');
  LDocument.DocumentElement.Attributes['xmlns'] := '';

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

  for var SourceFileItem in FProgramSourceFiles.FItemList do
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
  LNodeElement      := LMisc.AddChild('UseRelativePaths', -1);
  LNodeElement.Text := BoolToStr(FRelativeToScriptPath, true);

  LDocument.SaveToFile(FFileName);
end;

{ TProgramSourceFiles }

procedure TProgramSourceFiles.AddFile(const AItemFilename : TFilename;
                                      IsSelected          : Boolean);
var
  NewItem             : TProgramSourceFileItem;
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

  FItemList := TObjectList<TProgramSourceFileItem>.Create(true);
  FBasePath := BasePath;
end;

destructor TProgramSourceFiles.Destroy;
begin
  FreeAndNil(FItemList);
end;

procedure TProgramSourceFiles.GetCheckedItemsList(const ACheckedList: TStrings);
var
  SourceFileItem: TProgramSourceFileItem;
begin
  Assert(Assigned(ACheckedList), 'Non assigned list specified!');

  ACheckedList.Clear;
  ACheckedList.BeginUpdate;
  try
    for SourceFileItem in FItemList do
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

procedure TProgramSourceFiles.GetItemsList(const ACheckedList: TStrings);
var
  SourceFileItem: TProgramSourceFileItem;
begin
  Assert(Assigned(ACheckedList), 'Non assigned list specified!');

  ACheckedList.Clear;
  ACheckedList.BeginUpdate;
  try
    for SourceFileItem in FItemList do
      ACheckedList.Add(SourceFileItem.Filename);
  finally
    ACheckedList.EndUpdate;
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
  Item     : TProgramSourceFileItem;
begin
  FItemList.Clear;

  if (FBasePath <> System.SysUtils.PathDelim) then
  begin
    FileList := TDirectory.GetFiles(FBasePath, '*.pas', TSearchOption.soAllDirectories);

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
  Item     : TProgramSourceFileItem;
  Exists   : Boolean;
  n        : Integer;
begin
  FItemList.Clear;

  // exit if no proper path is specified as otherwise all pas files in all
  // folders on disk would be found or something like this...
  if (FBasePath = System.SysUtils.PathDelim) then
    exit;

  FileList := TDirectory.GetFiles(FBasePath, '*.pas', TSearchOption.soAllDirectories);

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
  FItemList.Sort(TComparer<TProgramSourceFileItem>.Construct(
                    function (const L, R: TProgramSourceFileItem): integer
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

end.