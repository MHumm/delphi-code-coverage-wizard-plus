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
  System.Classes,
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
  OutputPath      : string;
  LogFileName     : string;
  StringStream    : TStringStream;
begin
  // Create 'dcov_execute.bat'
  StringStream := TStringStream.Create;
  try
    OutputPath := GetPath(TPath.Combine(FSettings.ScriptsOutputPath,
                            TPath.GetFileNameWithoutExtension(
                             FProjectFileName)));

    LogFileName := GetPath(TPath.Combine(FSettings.ReportOutputPath,
                             TPath.GetFileNameWithoutExtension(FSettings.FileName) +
                             '_DelphiCodeCoverageDebug.log')).QuotedString('"');

    // Fill

    StringStream.WriteString(GetPath(FSettings.CodeCoverageExePath).QuotedString('"'));
    StringStream.WriteString(' -e '   + GetPath(FSettings.ExecutableToAnalyze).QuotedString('"'));
    StringStream.WriteString(' -m '   + GetPath(FSettings.MapFile).QuotedString('"'));
    StringStream.WriteString(' -sd '  + GetPath(FSettings.ProgramSourceBasePath).QuotedString('"'));
    StringStream.WriteString(' -uf '  + (OutputPath + '_dcov_units.lst').QuotedString('"'));
    StringStream.WriteString(' -spf ' + (OutputPath + '_dcov_paths.lst').QuotedString('"'));
    StringStream.WriteString(' -od '  + GetPath(FSettings.ReportOutputPath).QuotedString('"'));

    if FSettings.LogToTextFile then
      StringStream.WriteString(' -lt '  + LogFileName);

    if FSettings.LogToOutputDebugString then
      StringStream.WriteString(' -lapi');

    if FSettings.PassTroughExitCode then
      StringStream.WriteString(' -tec');

    if FSettings.UseExeDirAsWorkDir then
      StringStream.WriteString(' -twd');

    if not FSettings.ExeCommandLineParams.IsEmpty then
      StringStream.WriteString(' -a ' + FSettings.ExeCommandLineParams);

    StringStream.WriteString(' '      + FSettings.AdditionalParameter);
    StringStream.WriteString(GetOutputFormatSwitches); // they start with a spcace

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
end;

function TScriptsGenerator.GetPath(const APath: string): string;
begin
  if FSettings.RelativeToScriptPath then
    // Extract path relative to scripts relative
    Result := ExtractRelativepath(FSettings.ScriptsOutputPath , APath)
  else
    Result := APath;
end;

end.
