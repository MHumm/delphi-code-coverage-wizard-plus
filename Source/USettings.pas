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
///   Settings related to the application, like screen position and list of
///   recent projects
/// </summary>
unit USettings;

interface

uses
  System.IniFiles,
  System.Classes;

type
  /// <summary>
  ///   Settings related to the application, like screen position and list of
  ///   recent projects
  /// </summary>
  TSettings = class(TObject)
  strict private
    /// <summary>
    ///   List of recent files with full path
    /// </summary>
    FRecentProjects : TStringList;

    /// <summary>
    ///   X-pos of the screen in pixel
    /// </summary>
    FXPos         : Integer;
    /// <summary>
    ///   X-pos of the screen in pixel
    /// </summary>
    FYPos         : Integer;
    /// <summary>
    ///   Width of the main form in pixel
    /// </summary>
    FWidth        : Integer;
    /// <summary>
    ///   Height of the main form in pixel
    /// </summary>
    FHeight       : Integer;
    /// <summary>
    ///   When true the DCCP file extension is already registered for "open"
    /// </summary>
    FIsFileExtReg : Boolean;

    /// <summary>
    ///   True if any settings were changed
    /// </summary>
    FChanged     : Boolean;

    /// <summary>
    ///   Loads the settings from the ini-file.
    /// </summary>
    procedure LoadSettings;
    /// <summary>
    ///   Saves the settings into the ini-file.
    /// </summary>
    procedure SaveSettings;
  private
    /// <summary>
    ///   Stores the Height of the main form in pixel
    /// </summary>
    procedure SetHeight(const Value: Integer);
    /// <summary>
    ///   Stores the Width of the main form in pixel
    /// </summary>
    procedure SetWidth(const Value: Integer);
    /// <summary>
    ///   Stores the X-pos of the main form in pixel
    /// </summary>
    procedure SetXPos(const Value: Integer);
    /// <summary>
    ///   Stores the Y-pos of the main form in pixel
    /// </summary>
    procedure SetYPos(const Value: Integer);
    /// <summary>
    ///   Returns the number of entries in the recent projects list
    /// </summary>
    function  GetRecentCount: Integer;
    /// <summary>
    ///   Provides read access to the list of recently used projects
    /// </summary>
    /// <param name="Index">
    ///   Index of the element to return. If invalid a EListIndexOutOfBounds
    ///   exception will be thrown.
    /// </param>
    function  GetRecentProject(Index: Integer): string;

    /// <summary>
    ///   Returns the path to the ini-file where the settings are stored in
    /// </summary>
    function GetIniPath:string;
    procedure SetIsFileExtReg(const Value: Boolean);
  public
    /// <summary>
    ///   Initialization and loading of the settings
    /// </summary>
    constructor Create;
    /// <summary>
    ///   Saving of the settings if any of them changed and freeing of
    ///   internal ressources.
    /// </summary>
    destructor Destroy; override;

    /// <summary>
    ///   Adds the specified file name to the list of recently used projects,
    ///   if it is not already in the list.
    /// </summary>
    /// <param name="FileName">
    ///   Path and file name of the project file
    /// </param>
    procedure AddRecentProject(FileName: string);
    /// <summary>
    ///   Deletes an entry from the list of recent projects
    /// </summary>
    /// <param name="Index">
    ///   Index of the entry to be deleted. Throws an index out of range exception
    ///   if an invalid index is specified. See RecentProjectsCount for the
    ///   upper limit.
    /// </param>
    procedure DeleteRecentProject(Index: Integer);

    /// <summary>
    ///   X-pos of the main form in pixel
    /// </summary>
    property XPos        : Integer
      read   FXPos
      write  SetXPos;
    /// <summary>
    ///   Y-pos of the main form in pixel
    /// </summary>
    property YPos        : Integer
      read   FYPos
      write  SetYPos;
    /// <summary>
    ///   Width of the main form in pixel
    /// </summary>
    property Width       : Integer
      read   FWidth
      write  SetWidth;
    /// <summary>
    ///   Height of the main form in pixel
    /// </summary>
    property Height      : Integer
      read   FHeight
      write  SetHeight;

    /// <summary>
    ///   When true the DCCP file extension is already registered for "open"
    /// </summary>
    property IsFileExtReg : Boolean
      read   FIsFileExtReg
      write  SetIsFileExtReg;

    /// <summary>
    ///   Returns the number of entries in the recent projects list
    /// </summary>
    property RecentProjectsCount : Integer
      read   GetRecentCount;

    /// <summary>
    ///   Provides read access to the list of recently used projects
    /// </summary>
    /// <param name="Index">
    ///   Index of the element to return. If invalid a EListIndexOutOfBounds
    ///   exception will be thrown.
    /// </param>
    property RecentProject[Index: Integer]: string
      read   GetRecentProject;
  end;

implementation

uses
  System.IOUtils,
  System.SysUtils;

{ TSettings }

procedure TSettings.AddRecentProject(FileName: string);
begin
  // Only add file to the list if it's not already in the list
  if (FRecentProjects.IndexOf(FileName) < 0) then
  begin
    FRecentProjects.Add(FileName);
    FChanged := true;
  end;
end;

constructor TSettings.Create;
begin
  inherited;

  FChanged     := false;
  FRecentProjects := TStringList.Create;

  LoadSettings;
end;

procedure TSettings.DeleteRecentProject(Index: Integer);
begin
  FRecentProjects.Delete(Index);
  FChanged := true;
end;

destructor TSettings.Destroy;
begin
  if FChanged then
    SaveSettings;

  FRecentProjects.Free;

  inherited;
end;

function TSettings.GetIniPath: string;
begin
  Result := TPath.Combine(TPath.GetSharedDocumentsPath,
                          TPath.Combine('DelphiCodeCoverageWizard',
                                        'DelphiCodeCoverageWizard.ini'));
end;

function TSettings.GetRecentCount: Integer;
begin
  Result := FRecentProjects.Count;
end;

function TSettings.GetRecentProject(Index: Integer): string;
begin
  Result := FRecentProjects[Index];
end;

procedure TSettings.LoadSettings;
var
  ini : TIniFile;
begin
  ini := TIniFile.Create(GetIniPath);
  try
    FXPos       := ini.ReadInteger('Position', 'X', 0);
    FYPos       := ini.ReadInteger('Position', 'Y', 0);
    FWidth      := ini.ReadInteger('Position', 'Width', 624);
    FHeight     := ini.ReadInteger('Position', 'Height', 400);

    FRecentProjects.Capacity := ini.ReadInteger('RecentProjects',
                                                'Count', 1);

    for var i := 0 to FRecentProjects.Capacity - 1 do
      FRecentProjects.Add(ini.ReadString('RecentProjects', 'Project' + i.ToString, ''));

    FIsFileExtReg := ini.ReadBool('FileExtension', 'RegisteredOpen', false);
  finally
    ini.Free;
  end;
end;

procedure TSettings.SaveSettings;
var
  ini : TIniFile;
begin
  ini := TIniFile.Create(GetIniPath);
  try
    ini.WriteInteger('Position', 'X', FXPos);
    ini.WriteInteger('Position', 'Y', FYPos);
    ini.WriteInteger('Position', 'Width',  FWidth);
    ini.WriteInteger('Position', 'Height', FHeight);

    ini.EraseSection('RecentProjects');

    ini.WriteInteger('RecentProjects', 'Count', FRecentProjects.Count);

    for var i := 0 to FRecentProjects.Count - 1 do
      ini.WriteString('RecentProjects', 'Project' + i.ToString, FRecentProjects[i]);

      ini.WriteBool('FileExtension', 'RegisteredOpen', FIsFileExtReg);
  finally
    ini.Free;
  end;
end;

procedure TSettings.SetHeight(const Value: Integer);
begin
  if (Value <> FHeight) then
  begin
    FHeight  := Value;
    FChanged := true;
  end;
end;

procedure TSettings.SetIsFileExtReg(const Value: Boolean);
begin
  if (Value <> FIsFileExtReg) then
  begin
    FIsFileExtReg := Value;
    FChanged      := true;
  end;
end;

procedure TSettings.SetWidth(const Value: Integer);
begin
  if (Value <> FWidth) then
  begin
    FWidth   := Value;
    FChanged := true;
  end;
end;

procedure TSettings.SetXPos(const Value: Integer);
begin
  if (Value <> FXPos) then
  begin
    FXPos    := Value;
    FChanged := true;
  end;
end;

procedure TSettings.SetYPos(const Value: Integer);
begin
  if (Value <> FYPos) then
  begin
    FYPos    := Value;
    FChanged := true;
  end;
end;

end.
