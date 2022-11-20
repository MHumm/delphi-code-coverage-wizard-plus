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

  /// <summary>
  ///   Checks whether we are running on a Windows 64 bit instance
  /// </summary>
  /// <returns>
  ///   true if yes
  /// </returns>
  function Is64BitWindows: Boolean;

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
                             Param, Verb: string);

implementation

uses
  Winapi.Windows,
  Winapi.ShlObj,
  System.Win.Registry;

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

procedure RegisterFileType(const Extension, TypeName, Description, Application, Param, Verb: string);
var
  Registry    : TRegistry;
  ParamIntern : string;
begin
  Assert(Extension <> '', 'No file extension specified');

  Registry := TRegistry.Create;
  try
    Registry.RootKey := HKEY_CURRENT_USER;
    if Registry.OpenKey('\Software\Classes\.' + Extension, true) then
      Registry.WriteString('', TypeName);
    if Registry.OpenKey('\Software\Classes\' + TypeName, true) then
      Registry.WriteString('', Description);
    if Registry.OpenKey('\Software\Classes\' + TypeName + '\DefaultIcon', true) then
      Registry.WriteString('', Application);

    ParamIntern := Param;
    if ParamIntern <> '' then
      ParamIntern := ' ' + ParamIntern;

    if Registry.OpenKey('\Software\Classes\' + TypeName + '\shell\' + Verb + '\command',
               true) then
      Registry.WriteString('', Application + ParamIntern + ' "%1"');
  finally
    Registry.Free;
  end;
  SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, nil, nil);
end;

end.
