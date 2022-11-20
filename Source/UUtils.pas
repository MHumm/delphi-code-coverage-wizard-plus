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
unit UUtils;

interface

uses
  System.Win.Registry;

  /// <summary>
  ///   Checks whether we are running on a Windows 64 bit instance
  /// </summary>
  /// <returns>
  ///   true if yes
  /// </returns>
  function Is64BitWindows: Boolean;


type
  /// <summary>
  ///   Manages file type associations
  /// </summary>
  TFileTypeManager = class(TObject)
  strict private
    /// <summary>
    ///   Provides access to the registry
    /// </summary>
    FRegistry : TRegistry;
  private
    /// <summary>
    ///   Returns true if the question whether the DCCP file type should be
    ///   associated with this application has already been asked.
    /// </summary>
    function  GetFileTypeAssociationAsked: Boolean;
    /// <summary>
    ///   Sets or changes the flag defining whether the question to associate
    ///   the DCCP file type with this application has already been asked.
    ///   If true the question has been asked.
    /// </summary>
    procedure SetFileTypeAssociationAsked(const Value: Boolean);
  public
    /// <summary>
    ///   Initializes the class
    /// </summary>
    constructor Create;
    /// <summary>
    ///   Frees internal objects/data
    /// </summary>
    destructor  Destroy; override;

    /// <summary>
    ///   Registers a file type for the current user
    /// </summary>
    /// <param name="Extension">
    ///   file suffix to register, e.g. dccp, withlout the .
    /// </param>
    /// <param name="TypeName">
    ///   name of the file type like "DelphiCodeCoverageWizardPlus"
    /// </param>
    /// <param name="Description">
    ///   Description text, e.g. "Delphi Code Coverage Wizard Plus project file"
    /// </param>
    /// <param name="Application">
    ///   Absolute path and file name of the application to call, e.g.
    ///   "C:\WINDOWS\notepad.exe"
    /// </param>
    /// <param name="Param">
    ///   If not empty a command line parameter passed to the application before
    ///   the file name.
    /// </param>
    /// <param name="Verb">
    ///   Name of the action to perform, usually "open" but could be "print" as well etc.
    /// </param>
    procedure RegisterFileType(const Extension, TypeName, Description, Application,
                               Param: string;
                               const Verb: string = 'open');

    /// <summary>
    ///   De-registers a file type for the current user
    /// </summary>
    /// <param name="Extension">
    ///   file suffix to de-register, e.g. dccp, withlout the .
    /// </param>
    /// <param name="TypeName">
    ///   name of the file type like "DelphiCodeCoverageWizardPlus"
    /// </param>
    procedure UnRegisterFileType(const Extension, TypeName : string);

    /// <summary>
    ///   Returns true when the DCCP file extension is already associated
    /// </summary>
    function IsFileTypeAssociated : Boolean;

    /// <summary>
    ///   Finds out whether the question if the DCCP file type shall be associated
    ///   with this program has already been asked or not and can toggle this setting.
    /// </summary>
    property HasFileTypeAssociationBeenAsked : Boolean
      read   GetFileTypeAssociationAsked
      write  SetFileTypeAssociationAsked;
  end;

implementation

uses
  System.Classes,
  Winapi.Windows,
  Winapi.ShlObj,
  UConsts;

function Is64BitWindows: Boolean;
{$IFDEF WIN32}
type
  TIsWow64Process = function(Handle: THandle; var Res: BOOL): BOOL; stdcall;
var
  IsWOW64: BOOL;
  IsWOW64Process: TIsWow64Process;
{$ENDIF}
begin
{$IFDEF WIN32}
  // Try to load required function from kernel32
  IsWOW64Process := TIsWow64Process(GetProcAddress(GetModuleHandle('kernel32'),
                                                   'IsWow64Process'));
  if Assigned(IsWOW64Process) then
    begin
      // Function exists
      if not IsWOW64Process(GetCurrentProcess, IsWOW64) then
        Result:=False
      else
        Result:=IsWOW64;
    end
  else
    // Function not implemented: can't be running on Wow64
    Result := False;
{$ELSE} //if were running 64bit code, OS must be 64bit :)
   Result := True;
{$ENDIF}
end;

constructor TFileTypeManager.Create;
begin
  inherited Create;

  FRegistry         := TRegistry.Create;
  FRegistry.RootKey := HKEY_CURRENT_USER;
end;

destructor TFileTypeManager.Destroy;
begin
  FRegistry.Free;

  inherited;
end;

function TFileTypeManager.GetFileTypeAssociationAsked: Boolean;
begin
  Result := FRegistry.KeyExists('SOFTWARE\DelphiCodeCoverageWizard');
  if Result then
  begin
    if FRegistry.OpenKey('SOFTWARE\DelphiCodeCoverageWizard', false) then
    begin
      if FRegistry.ValueExists('DCCPQuestionAsked') then
        Result := FRegistry.ReadBool('DCCPQuestionAsked')
      else
        Result := false;

      FRegistry.CloseKey;
    end;
  end;
end;

function TFileTypeManager.IsFileTypeAssociated: Boolean;
begin
  Result := FRegistry.KeyExists('\Software\Classes\.' + cProjectExtension);
end;

procedure TFileTypeManager.RegisterFileType(const Extension, TypeName, Description,
                                            Application, Param, Verb: string);
var
  ParamIntern : string;
begin
  Assert(Extension   <> '', 'No file extension specified');
  Assert(TypeName    <> '', 'No type name specified');
  Assert(Application <> '', 'No application specified');
  Assert(Verb        <> '', 'No verb specified');

  try
    if FRegistry.OpenKey('\Software\Classes\.' + Extension, true) then
      FRegistry.WriteString('', TypeName);
    if FRegistry.OpenKey('\Software\Classes\' + TypeName, true) then
      FRegistry.WriteString('', Description);
    if FRegistry.OpenKey('\Software\Classes\' + TypeName + '\DefaultIcon', true) then
      FRegistry.WriteString('', Application);

    ParamIntern := Param;
    if ParamIntern <> '' then
      ParamIntern := ' ' + ParamIntern;

    if FRegistry.OpenKey('\Software\Classes\' + TypeName + '\shell\' + Verb + '\command',
               true) then
      FRegistry.WriteString('', Application + ParamIntern + ' "%1"');

    FRegistry.CloseKey;
  finally
    SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, nil, nil);
  end;
end;

procedure TFileTypeManager.SetFileTypeAssociationAsked(const Value: Boolean);
begin
  if FRegistry.OpenKey('SOFTWARE\DelphiCodeCoverageWizard', true) then
  begin
    FRegistry.WriteBool('DCCPQuestionAsked', Value);
    FRegistry.CloseKey;
  end;
end;

procedure TFileTypeManager.UnRegisterFileType(const Extension, TypeName: string);
var
  KeyNames : TStringList;
begin
  try
    // un-register all verbs
    if FRegistry.OpenKey('\Software\Classes\' + TypeName + '\shell', false) then
    begin
      KeyNames := TStringList.Create;

      try
        FRegistry.GetKeyNames(KeyNames);

        for var s in KeyNames do
        begin
          FRegistry.DeleteKey('\Software\Classes\' + TypeName + '\shell' + s +
                              '\command');
          FRegistry.DeleteKey('\Software\Classes\' + TypeName + '\shell' + s);
        end;
      finally
        KeyNames.Free;
      end;

      // un-register icon association and type name
      FRegistry.DeleteKey('\Software\Classes\' + TypeName + '\DefaultIcon');
      FRegistry.DeleteKey('\Software\Classes\' + TypeName);

      // un-register file extension
      FRegistry.DeleteKey('\Software\Classes\.' + Extension);
      FRegistry.DeleteKey('SOFTWARE\Microsoft\Windows\CurrentVersion\' +
                          'Explorer\FileExts\.' + Extension);
    end;

  finally
    SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, nil, nil);
  end;
end;

end.
