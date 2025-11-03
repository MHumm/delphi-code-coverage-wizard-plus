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
///   Class for generating the batch file and any other required output files
///   needed for calling CodeCoverage
///   Author of original version: TridentT
/// </summary>
unit UScriptsGenerator;

interface

uses
  System.Classes,
  UProjectSettingsInterface;

type
  /// <summary>
  ///   Class for generating the batch file and any other required output files
  ///   needed for calling CodeCoverage
  /// </summary>
  TScriptsGenerator = class(TObject)
  private
    /// <summary>
    ///   Contents of the project
    /// </summary>
    FSettings        : IProjectSettings;
    /// <summary>
    ///   File name of the saved project
    /// </summary>
    FProjectFileName : string;

    /// <summary>
    ///   Generates the batch file to call code coverage
    /// </summary>
    procedure GenerateDCovExecuteBatchFile;
    /// <summary>
    ///   Generates the other required output files
    /// </summary>
    procedure GenerateDCovUnitsAndPathFiles;
    /// <summary>
    ///   Get the settings for the requested output formats in the correct form
    ///   needed for calling code coverage.
    /// </summary>
    function GetOutputFormatSwitches : string;
    /// <summary>
    ///   Returns either the absolute path of the path given or the relative one,
    ///   depending on the project settings for using relative paths
    /// </summary>
    /// <param name="APath">
    ///   Path for which to either return the absolute or relative path
    /// </param>
    /// <returns>
    ///   Relative path if that project setting is on, otherwise absolute path
    /// </returns>
    function GetPath(const APath : string) : string;
    /// <summary>
    ///   Saves all the strings contained in the list as one long string into the
    ///   batch file specified in project settings.
    /// </summary>
    /// <param name="BatchParts">
    ///   List with all the parameters etc. which shall be written into the
    ///   batch file
    /// </param>
    procedure SaveBatchPartsToFile(BatchParts: TStringList);
  public
    /// <summary>
    ///   Creates and initializes the instance
    /// </summary>
    /// <param name="ASettings">
    ///   Contents of the currently loaded/created project
    /// </param>
    /// <param name="AProjectFileName">
    ///   Name of the saved project file
    /// </param>
    constructor Create(const ASettings        : IProjectSettings;
                       const AProjectFileName : string); virtual;
    /// <summary>
    ///   Generates the output files
    /// </summary>
    procedure Generate;
  end;

implementation

uses
  System.SysUtils,
  System.IOUtils;

constructor TScriptsGenerator.Create(const ASettings        : IProjectSettings;
                                     const AProjectFileName : string);
begin
  Assert(Assigned(ASettings), 'Not created project contents object passed');

  inherited Create;

  FSettings        := ASettings;
  FProjectFileName := AProjectFileName;
end;

procedure TScriptsGenerator.Generate;
begin
  GenerateDCovExecuteBatchFile;
  GenerateDCovUnitsAndPathFiles;
end;

procedure TScriptsGenerator.GenerateDCovExecuteBatchFile;
var
  OutputPath    : string;
  LogFileName   : string;
  BatchParts    : TStringList;
  AddParamIndex : Integer;
begin
  // Create 'dcov_execute.bat'
  BatchParts := TStringList.Create;
  try
    OutputPath := GetPath(TPath.Combine(FSettings.ScriptsOutputPath,
                            TPath.GetFileNameWithoutExtension(
                             FProjectFileName)));

    LogFileName := GetPath(TPath.Combine(FSettings.ReportOutputPath,
                             TPath.GetFileNameWithoutExtension(FSettings.FileName) +
                             '_DelphiCodeCoverageDebug.log')).QuotedString('"');

    // Fill

    BatchParts.Add(GetPath(FSettings.CodeCoverageExePath).QuotedString('"'));
    BatchParts.Add('-e '   + GetPath(FSettings.ExecutableToAnalyze).QuotedString('"'));
    BatchParts.Add('-m '   + GetPath(FSettings.MapFile).QuotedString('"'));
    BatchParts.Add('-sd '  + GetPath(FSettings.ProgramSourceBasePath).QuotedString('"'));
    BatchParts.Add('-ife');

    if not FSettings.ProjectFileName.IsEmpty then
      BatchParts.Add('-dproj ' + GetPath(FSettings.ProjectFileName).QuotedString('"'));

    BatchParts.Add('-uf '  + (OutputPath + '_dcov_units.lst').QuotedString('"'));
    BatchParts.Add('-spf ' + (OutputPath + '_dcov_paths.lst').QuotedString('"'));
    BatchParts.Add('-od '  + GetPath(FSettings.ReportOutputPath).QuotedString('"'));
    BatchParts.Add('-v'); // verbose output

    if not FSettings.ExcludedFileMasks.IsEmpty then
      BatchParts.Add('-esm '  + FSettings.ExcludedFileMasks);

    if not FSettings.IncludedFileMasks.IsEmpty then
      BatchParts.Add('-ism '  + FSettings.IncludedFileMasks);

    if FSettings.LogToTextFile then
      BatchParts.Add('-lt '  + LogFileName);

    if FSettings.LogToOutputDebugString then
      BatchParts.Add('-lapi');

    if FSettings.PassTroughExitCode then
      BatchParts.Add('-tec');

    if FSettings.UseExeDirAsWorkDir then
      BatchParts.Add('-twd');

    if not FSettings.ExeCommandLineParams.IsEmpty then
      BatchParts.Add('-a ' + FSettings.ExeCommandLineParams);

    if (FSettings.CodePage > 0) then
      BatchParts.Add('-cp ' + FSettings.CodePage.ToString);

    BatchParts.Add(GetOutputFormatSwitches); // they start with a spcace

    if (FSettings.UseNumberOfLineExecutes) then
      BatchParts.Add('-lcl ' + FSettings.NumberOfLineExecutes.ToString);

{ TODO : Since this is a multiline setting we need to test it with multiline data }
    if (not FSettings.ExcludedClassPrefixes.IsEmpty) then
      BatchParts.Add('-ecp ' + FSettings.ExcludedClassPrefixes);

{ TODO : Not tested yet }
    if FSettings.IncludeFileExtension then
      BatchParts.Add('-ife')
    else
      BatchParts.Add('-efe');

    AddParamIndex := FSettings.AdditionalParIndex;
    if AddParamIndex >= BatchParts.Count then
      AddParamIndex := BatchParts.Count;

    BatchParts.Insert(AddParamIndex, FSettings.AdditionalParameter);

    SaveBatchPartsToFile(BatchParts);
  finally
    FreeAndNil(BatchParts);
  end;
end;

procedure TScriptsGenerator.SaveBatchPartsToFile(BatchParts: TStringList);
var
  StringStream : TStringStream;
begin
  StringStream := TStringStream.Create;
  try
    for var i := 0 to BatchParts.Count - 1 do
    begin
      // separate the individual params by a blank, unless its the first one
      if i > 0 then
        StringStream.WriteString(' ');

      StringStream.WriteString(BatchParts[i]);
    end;

    StringStream.SaveToFile(FSettings.BatchFileName);
  finally
    FreeAndNil(StringStream);
  end;
end;

procedure TScriptsGenerator.GenerateDCovUnitsAndPathFiles;
var
  DCovUnitsText   : TStringList;
  DCovPathsText   : TStringList;
  CheckedUnitList : TStrings;
  UnitFilename    : string;
  FileName        : string;
  Path            : string;
begin
  // Create 'dcov_execute.bat'
  DCovUnitsText := TStringList.Create;
  try
    DCovUnitsText.Sorted := True;
    DCovUnitsText.Duplicates := dupIgnore;

    DCovPathsText := TStringList.Create;
    try
      DCovPathsText.Sorted := True;
      DCovPathsText.Duplicates := dupIgnore;

      // Get Checked unit list
      CheckedUnitList := TStringList.Create;
      try
        FSettings.ProgramSourceFiles.GetCheckedItemsList(CheckedUnitList);

        for UnitFilename in CheckedUnitList do
        begin
          // Add Unit name
          FileName := ChangeFileExt(ExtractFileName(UnitFilename), '').Trim;
          if not FileName.IsEmpty then
          begin
            DCovUnitsText.Add(FileName);
            // Add unit path
            Path := ExtractFilePath(UnitFilename).Trim;
            if not Path.IsEmpty then
              DCovPathsText.Add(Path);
          end;
        end;

        // Save
        DCovUnitsText.SaveToFile(
          TPath.Combine(FSettings.ScriptsOutputPath,
                        TPath.GetFileNameWithoutExtension(FProjectFileName) +
                        '_dcov_units.lst'));

        DCovPathsText.SaveToFile(
          TPath.Combine(FSettings.ScriptsOutputPath,
                        TPath.GetFileNameWithoutExtension(FProjectFileName) +
                        '_dcov_paths.lst'));
      finally
        FreeAndNil(CheckedUnitList);
      end;
    finally
      FreeAndNil(DCovPathsText);
    end;
  finally
    FreeAndNil(DCovUnitsText);
  end;
end;

function TScriptsGenerator.GetOutputFormatSwitches: string;
begin
  Result := '';
  if(ofEMMA in FSettings.OutputFormats)   then Result := Result + ' -emma';
  if(ofEMMA21 in FSettings.OutputFormats) then Result := Result + ' -emma21';
  if(ofMETA in FSettings.OutputFormats)   then Result := Result + ' -meta';
  if(ofXML  in FSettings.OutputFormats)   then Result := Result + ' -xml';
  if(ofHTML in FSettings.OutputFormats)   then Result := Result + ' -html';

  if FSettings.AddLineNumbersToXML then Result := Result + ' -xmllines';
  if FSettings.CombineXMLCoverage  then Result := Result + ' -xmlgenerics';
  if FSettings.XMLJacocoFormat     then Result := Result + ' -jacoco';

  Result := Result.TrimLeft;
end;

function TScriptsGenerator.GetPath(const APath: string): string;
var
  ScriptPath : string;
begin
  if FSettings.RelativeToScriptPath then
  begin
    // Extract path relative to scripts relative
    ScriptPath := FSettings.ScriptsOutputPath;
    if not ScriptPath.EndsWith(System.SysUtils.PathDelim) then
      ScriptPath := ScriptPath + System.SysUtils.PathDelim;
    Result := ExtractRelativepath(ScriptPath, APath);
  end
  else
    Result := APath;
end;

end.
