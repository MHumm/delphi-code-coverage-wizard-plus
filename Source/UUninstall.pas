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
///   Code for partially uninstalling this application. Removes the ini-file,
///   and some registry entries.
/// </summary>
unit UUninstall;

interface

  /// <summary>
  ///   Deletes the inifile and the directory it is in, the IDE Tools menu
  ///   registry entries and its own one where it stores which IDE configurations
  ///   it already knows (for offering Tools menu integration)
  /// </summary>
  procedure UninstallWizard;

implementation

uses
  System.SysUtils,
  Winapi.Windows,
  System.Win.Registry,
  Vcl.Forms,
  USettings,
  UAddIDETool,
  UUtils,
  UConsts;

resourcestring
  /// <summary>
  ///   Success message shown when everything works as expected
  /// </summary>
  rUninstallationCompleted = 'Deinstallation completed';
  /// <summary>
  ///   Message box caption
  /// </summary>
  rSuccess                 = 'Success';

procedure UninstallWizard;
var
  IDEToolsMgr : TAddIDETool;
  Registry    : TRegistry;
  IDEVersList : TIDEVersionList;
  FileTypeMgr : TFileTypeManager;
begin
  // Remove ini file
  try
    if FileExists(TSettings.GetIniFileName) then
      System.SysUtils.DeleteFile(TSettings.GetIniFileName);

    if DirectoryExists(TSettings.GetIniPath) then
      System.SysUtils.RemoveDir(TSettings.GetIniPath);
  except
    on e:Exception do
    begin
      OutputDebugString(PWideChar('Failure deleting ini file ' +
                                  TSettings.GetIniFileName + ': ' + e.Message));
      Halt(1);
    end;
  end;

  // Remove Tools menu entries (the default ones created)
  IDEToolsMgr := TAddIDETool.Create;
  try
    try
      IDEVersList := IDEToolsMgr.GetIDEVersionsList;
      try
        IDEToolsMgr.DeleteTool(Application.ExeName,
                               '-O $PROJECT',
                               IDEVersList);

        IDEToolsMgr.DeleteTool(Application.ExeName,
                               '-R $PROJECT',
                               IDEVersList);
      finally
        IDEVersList.Free;
      end;
    except
      on e:Exception do
      begin
        OutputDebugString(PWideChar('Failure removing tools menu integration ' +
                                    e.Message));
        Halt(2);
      end;
    end;
  finally
    IDEToolsMgr.Free;
  end;

  // Remove file type association
  FileTypeMgr := TFileTypeManager.Create;

  try
    FileTypeMgr.UnRegisterFileType(cProjectExtension, cProjectFileTypeName);
  finally
    FileTypeMgr.Free;
  end;

  // Remove registry entry
  Registry := TRegistry.Create;
  try
    try
      Registry.RootKey := HKEY_CURRENT_USER;
      if Registry.OpenKey('SOFTWARE', false) then
        Registry.DeleteKey('DelphiCodeCoverageWizard');
    except
      on e:Exception do
      begin
        OutputDebugString(PWideChar('Failure removing registry entries ' +
                                    e.Message));
        Halt(3);
      end;
    end;
  finally
    Registry.Free;
  end;

  Application.MessageBox(PChar(rUninstallationCompleted), PChar(rSuccess), MB_OK);
end;

end.
