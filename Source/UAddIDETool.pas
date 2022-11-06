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

// Origin of this modified version: https://github.com/MHumm/AddIDETool

/// <summary>
///   Provides the adding of this tool to Delphi tools menu
/// </summary>
unit UAddIDETool;

interface

uses
  System.SysUtils,
  System.Win.Registry,
  System.Classes,
  Generics.Collections,
  Winapi.Windows;

type
  /// <summary>
  ///   Single entry for the IDE configuration/version list
  /// </summary>
  TIDEVersionRec = record
    /// <summary>
    ///   Either 'BDS' or one specified via -r command line parameter
    /// </summary>
    ConfigRootKey : string;
    /// <summary>
    ///   BDS version number
    /// </summary>
    BDSVersion    : string;

    /// <summary>
    ///   Returns the full registry key for the configuration
    /// </summary>
    function GetConfigKey: string;
    /// <summary>
    ///   Determines the "display name" of a BDS version
    /// </summary>
    /// <returns>
    ///   Display name for that version of if it is not known and empty string
    /// </returns>
    function GetIDEVersionName: string;
  end;

  /// <summary>
  ///   List of IDE configurations/versions
  /// </summary>
  TIDEVersionList = class(TList<TIDEVersionRec>)
    /// <summary>
    ///   Get a ; delimited list of all config keys found on the system
    /// </summary>
    function GetIDEVersionsString: string;
  end;

  /// <summary>
  ///   Class for adding something to or deleteing from the IDE's tools menu.
  /// </summary>
  TAddIDETool = class(TObject)
  strict private
    /// <summary>
    ///   Provides access to the Windows registry
    /// </summary>
    FRegistry   : TRegistry;
    /// <summary>
    ///   Key name for the Rad Studio subkeys under the Embarcadero node
    /// </summary>
    FBDSKeyName : string;

    /// <summary>
    ///   Search if a certain tool path is already listed under tools and if yes
    ///   returns the registry path of that registry entry
    /// </summary>
    /// <param name="Path">
    ///   Path to search for
    /// </param>
    /// <param name="RegPath">
    ///   Path to the registry key of the IDE version under which to search
    /// </param>
    /// <returns>
    ///   Registry path of the registry node for the tools entry which already
    ///   exists for the path or empty string if the path is not yet added as
    ///   tools entry
    /// </returns>
    function SearchForToolsPath(Path: string; const RegPath: string):string;
    /// <summary>
    ///   Adds a tool to the tools menu of selected Rad Studio IDEs
    /// </summary>
    /// <param name="Params">
    ///   Command line params the IDE shall pass to the tool
    /// </param>
    /// <param name="Path">
    ///   Path and file name of the tool
    /// </param>
    /// <param name="Title">
    ///   Name of the tool in the menu
    /// </param>
    /// <param name="WorkingDir">
    ///   Path which the IDE sets as working dir before calling the tool
    /// </param>
    /// <param name="RegPath">
    ///   Registry key name of the tools menu entries for the processed IDE version
    /// </param>
    procedure DoAddModifyTool(const Params, Path, Title, WorkingDir, RegPath: string);
  public
    /// <summary>
    ///   Initialize internal fields
    /// </summary>
    constructor Create;
    /// <summary>
    ///   Free internal fields
    /// </summary>
    destructor  Destroy; override;

    /// <summary>
    ///   Returns a list of all installed IDE versions
    /// </summary>
    /// <returns>
    ///   List of all installed IDE versions and configurations.
    ///   The list is always created even if no IDE is installed.
    /// </returns>
    function GetIDEVersionsList: TIDEVersionList;
    /// <summary>
    ///   Adds a tool to the tools menu of selected Rad Studio IDEs
    /// </summary>
    /// <param name="Params">
    ///   Command line params the IDE shall pass to the tool
    /// </param>
    /// <param name="Path">
    ///   Path and file name of the tool
    /// </param>
    /// <param name="Title">
    ///   Name of the tool in the menu
    /// </param>
    /// <param name="WorkingDir">
    ///   Path which the IDE sets as working dir before calling the tool
    /// </param>
    /// <param name="ConfigKeys">
    ///   List of IDE versions/configurations the tool shall get added to.
    ///   If the list contains versions not installed they will be ignored.
    ///   Best is to call GetIDEVersionsList and pass that one.
    /// </param>
    procedure AddTool(const Params, Path, Title, WorkingDir: string;
                      ConfigKeys: TIDEVersionList);
    /// <summary>
    ///   Remove a tools menu entry for a given tool
    /// </summary>
    /// <param name="Path">
    ///   Path and file name of the tool to remove, it will be referenced by that
    /// </param>
    /// <param name="ConfigKeys">
    ///   List of IDE versions the tool shall get deleted from. If the list contains
    ///   versions not installed they will be ignored. Best is to call
    ///   GetIDEVersionsList and pass that one.
    /// </param>
    procedure DeleteTool(const Path: string; ConfigKeys: TIDEVersionList);

    /// <summary>
    ///   Checks whether a certain application is listed in the tools menu of
    ///   a certain IDE version and configuration
    /// </summary>
    /// <param name="Path">
    ///   Path and file name of the tool to look for
    /// </param>
    /// <param name="ConfigKey">
    ///   Complete registry key for a configuration and version combination
    /// </param>
    /// <returns>
    ///   true if a tool with that path is listed under Tools menu for the
    ///   given IDE version/configuration
    /// </returns>
    function IsInMenu(const Path, ConfigKey: string):Boolean;

    /// <summary>
    ///   Name of the key under the Embarcadero key under which all Rad Studio
    ///   versions are stored in the registry
    /// </summary>
    property RadStudioKeyName : string
      read   FBDSKeyName
      write  FBDSKEyName;
  end;

implementation

const
  /// <summary>
  ///   Root path for EMBT products
  /// </summary>
  IDERootKey       = 'SOFTWARE\Embarcadero\';
  /// <summary>
  ///   Default root key for Rad Studio
  /// </summary>
  DefaultBDSName   = 'BDS';
  /// <summary>
  ///   Tools subkey
  /// </summary>
  ToolsKey         = 'Transfer';
  /// <summary>
  ///   Separates the individual configurations in the string containing all of them
  /// </summary>
  ConfigSeparator  = '§';
  /// <summary>
  ///   Separates the individual parts of a configuraiton within the string
  /// </summary>
  PartSeperator    = '#';

{ TAddIDETool }

procedure TAddIDETool.AddTool(const Params, Path, Title, WorkingDir: string;
  ConfigKeys: TIDEVersionList);
var
  IDEVersion      : TIDEVersionRec;
  ExistingRegPath : string;
  RegPath         : string;
begin
  Assert(Assigned(ConfigKeys), 'Not created list of IDE versions has been passed');
  Assert(Path <> '', 'Empty path/file name has been specified');
  Assert(Title <> '', 'Empty title has been specified');

  for IDEVersion in ConfigKeys do
  begin
    // Skip versions older than D2009
    if (StrToFloat(IDEVersion.BDSVersion, TFormatSettings.Create('en-US'))  >= 6.0) then
    begin
      // if registry path to the tools menu list exists
      RegPath := IDEVersion.GetConfigKey + '\' + ToolsKey;
      if FRegistry.OpenKey(RegPath, false) then
      begin
        FRegistry.CloseKey;
        // Check if that path is already listed
        ExistingRegPath := SearchForToolsPath(Path, RegPath);

        if (ExistingRegPath = '') then
        begin
          RegPath := RegPath + '\' + Title;
          DoAddModifyTool(Params, Path, Title, WorkingDir, RegPath);
        end
        else
          DoAddModifyTool(Params, Path, Title, WorkingDir, ExistingRegPath);
      end;
    end;
  end;
end;

constructor TAddIDETool.Create;
begin
  inherited;

  FRegistry         := TRegistry.Create;
  FRegistry.RootKey := HKEY_CURRENT_USER;
  FBDSKeyName       := DefaultBDSName;
end;

procedure TAddIDETool.DeleteTool(const Path: string; ConfigKeys: TIDEVersionList);
var
  IDEVersion      : TIDEVersionRec;
  ExistingRegPath : string;
  RegPath         : string;
begin
  Assert(Assigned(ConfigKeys), 'Not created list of IDE versions has been passed');
  Assert(Path <> '', 'Empty path/file name has been specified');

  for IDEVersion in ConfigKeys do
  begin
    // Skip versions older than D2009
    if (StrToFloat(IDEVersion.BDSVersion, TFormatSettings.Create('en-US'))  >= 6.0) then
    begin
      // if registry path to the tools menu list exists
      RegPath := IDEVersion.GetConfigKey + '\' + ToolsKey;
      if FRegistry.OpenKey(RegPath, false) then
      begin
        FRegistry.CloseKey;
        // Check if that path is already listed
        ExistingRegPath := SearchForToolsPath(Path, RegPath);

        if (ExistingRegPath <> '') then
          FRegistry.DeleteKey(ExistingRegPath);
      end;
    end;
  end;
end;

destructor TAddIDETool.Destroy;
begin
  FRegistry.Free;

  inherited;
end;

procedure TAddIDETool.DoAddModifyTool(const Params, Path, Title, WorkingDir,
  RegPath: string);
begin
  if FRegistry.OpenKey(RegPath, true) then
  begin
    try
      FRegistry.WriteString('Params', Params);
      FRegistry.WriteString('Path', Path);
      FRegistry.WriteString('Title', Title);
      FRegistry.WriteString('WorkingDir', WorkingDir);
    finally
      FRegistry.CloseKey;
    end;
  end;
end;

function TAddIDETool.GetIDEVersionsList: TIDEVersionList;
var
  ConfigKeys  : TStringList;
  VersionKeys : TStringList;
  Keys        : TStringList;
  ConfigKey   : string;
  VersionKey  : string;
  d           : Double;
  Version     : TIDEVersionRec;
begin
  Result := TIDEVersionList.Create;

  if FRegistry.OpenKey(IDERootKey, false) then
  begin
    try
      // fetch the list of all subkeys of the Embarcadero one
      ConfigKeys := TStringList.Create;
      try
        FRegistry.GetKeyNames(ConfigKeys);
        FRegistry.CloseKey;

        for ConfigKey in ConfigKeys do
        begin
          // fetch all potential version keys below that config key
          if FRegistry.OpenKey(IDERootKey + ConfigKey, false) then
          begin
            VersionKeys := TStringList.Create;

            try
              FRegistry.GetKeyNames(VersionKeys);
              FRegistry.CloseKey;

              for VersionKey in VersionKeys do
              begin
                // if s is a valid floating point number the key is a BDS version
                // else we skip it
                if not System.SysUtils.TryStrToFloat(VersionKey, d, TFormatSettings.Create('en-US')) then
                  Continue;

                // we have a valid BDS version, but only if it contains a transfer key
                if FRegistry.OpenKey(IDERootKey + ConfigKey + '\' + VersionKey, false) then
                begin
                  Keys := TStringList.Create;

                  try
                    FRegistry.GetKeyNames(Keys);
                    FRegistry.CloseKey;

                    if (Keys.IndexOf(ToolsKey) >= 0) then
                    begin
                      Version.ConfigRootKey := ConfigKey;
                      Version.BDSVersion    := VersionKey;
                      Result.Add(Version);
                    end;
                  finally
                    Keys.Free;
                  end;
                end;
              end;
            finally
              VersionKeys.Free;
            end;
          end;
        end;
      finally
        ConfigKeys.Free;
      end;

    except
      On e:exception do
        OutputDebugString(PWideChar('Failure retrieving all installed IDE '+
                                    'versions: ' + e.Message));
    end;
  end;
end;

function TAddIDETool.IsInMenu(const Path, ConfigKey: string): Boolean;
begin
  Result := SearchForToolsPath(Path, ConfigKey+'\'+ToolsKey) <> '';
end;

function TAddIDETool.SearchForToolsPath(Path: string;
                                        const RegPath: string): string;
var
  ToolsKeys : TStringList;
  Registry  : TRegistry;
  Tool      : string;
  ReadPath  : string;
begin
  Assert(Path <> '', 'Empty path specified');
  Assert(RegPath <> '', 'Empty registry path specified');

  Result := '';
  Path   := UpperCase(Path);

  ToolsKeys := TStringList.Create;
  Registry  := TRegistry.Create;
  Registry.RootKey := HKEY_CURRENT_USER;
  try
    if Registry.OpenKey(RegPath, false) then
    begin
      Registry.GetKeyNames(ToolsKeys);
      Registry.CloseKey;

      for Tool in ToolsKeys do
      begin
        if Registry.OpenKey(RegPath + '\' + Tool, false) then
        begin
          ReadPath := UpperCase(Registry.ReadString('Path'));
          Registry.CloseKey;
          if (ReadPath = Path) then
          begin
            Result := RegPath + '\' + Tool;
            Break;
          end;
        end;
      end;
    end;
  finally
    ToolsKeys.Free;
    Registry.Free;
  end;
end;

{ TIDEVersionRec }

function TIDEVersionRec.GetConfigKey: string;
begin
  Result := IDERootKey + ConfigRootKey + '\' + BDSVersion;
end;

function TIDEVersionRec.GetIDEVersionName: string;
begin
  Result := '';

  if (BDSVersion = '22.0') then
    Exit('11.0 Alexandria');

  if (BDSVersion = '21.0') then
    Exit('10.4 Sydney');
  if (BDSVersion = '20.0') then
    Exit('10.3 Rio');
  if (BDSVersion = '19.0') then
    Exit('10.2 Tokyo');
  if (BDSVersion = '18.0') then
    Exit('10.1 Berlin');
  if (BDSVersion = '17.0') then
    Exit('10.0 Seattle');
  if (BDSVersion = '16.0') then
    Exit('XE8');
  if (BDSVersion = '15.0') then
    Exit('XE7');
  if (BDSVersion = '14.0') then
    Exit('XE6');
  if (BDSVersion = '12.0') then
    Exit('XE5');
  if (BDSVersion = '11.0') then
    Exit('XE4');
  if (BDSVersion = '10.0') then
    Exit('XE3');
  if (BDSVersion = '9.0') then
    Exit('XE2');
  if (BDSVersion = '8.0') then
    Exit('XE');
  if (BDSVersion = '7.0') then
    Exit('2010');
  if (BDSVersion = '6.0') then
    Exit('2009');
  if (BDSVersion = '5.0') then
    Exit('2007');
  if (BDSVersion = '4.0') then
    Exit('2006');
  if (BDSVersion = '3.0') then
    Exit('2005');
  if (BDSVersion = '2.0') then
    Exit('8.0 for .net');
end;

{ TIDEVersionList }

function TIDEVersionList.GetIDEVersionsString: string;
var
  IDEVersion : TIDEVersionRec;
begin
  Result := '';

  for IDEVersion in self do
    Result := Result + IDEVersion.GetConfigKey + ';';
end;

end.
