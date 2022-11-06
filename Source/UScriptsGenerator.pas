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
  UProjectSettings;

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
    FSettings        : TProjectSettings;
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
    constructor Create(const ASettings        : TProjectSettings;
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

constructor TScriptsGenerator.Create(const ASettings        : TProjectSettings;
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
const
  // Application path to CodeCoverage.exe,  ExeToAnalyze,  MapFile,  ReportPath
  DCOV_EXECUTE_FORMAT = '"%0:s" -e "%1:s" -m "%2:s" -uf %3:s_dcov_units.lst ' +
                        '-spf %4:s_dcov_paths.lst -od "%5:s" -lt';
var
  DCovExecuteText : TStringList;
begin
  // Create 'dcov_execute.bat'
  DCovExecuteText := TStringList.Create;
  // Fill
  DCovExecuteText.Add(Format(DCOV_EXECUTE_FORMAT,
                      [GetPath(FSettings.CodeCoverageExePath),
                       GetPath(FSettings.ExecutableToAnalyze),
                       GetPath(FSettings.MapFile),
                       GetPath(TPath.Combine(FSettings.ScriptsOutputPath,
                               TPath.GetFileNameWithoutExtension(FProjectFileName))),
                       GetPath(TPath.Combine(FSettings.ScriptsOutputPath,
                               TPath.GetFileNameWithoutExtension(FProjectFileName))),
                       GetPath(FSettings.ReportOutputPath)]) +
                       GetOutputFormatSwitches());
  // Save
  DCovExecuteText.SaveToFile(FSettings.BatchFileName);
  FreeAndNil(DCovExecuteText);
end;

procedure TScriptsGenerator.GenerateDCovUnitsAndPathFiles;
var
  DCovUnitsText   : TStringList;
  DCovPathsText   : TStringList;
  CheckedUnitList : TStrings;
  UnitFilename    : string;
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
          DCovUnitsText.Add(ChangeFileExt(ExtractFileName(UnitFilename), ''));
          // Add unit path
          DCovPathsText.Add(ExtractFilePath(UnitFilename));
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
  if(ofEMMA in FSettings.OutputFormats) then Result := Result + ' -emma';
  if(ofMETA in FSettings.OutputFormats) then Result := Result + ' -meta';
  if(ofXML  in FSettings.OutputFormats) then Result := Result + ' -xml';
  if(ofHTML in FSettings.OutputFormats) then Result := Result + ' -html';
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
