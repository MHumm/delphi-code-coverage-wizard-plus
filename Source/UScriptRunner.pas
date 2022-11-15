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
///   Implements running and displaying of the script output
/// </summary>
unit UScriptRunner;

interface

uses
  System.Classes,
  UProjectSettingsInterface;

type
  /// <summary>
  ///   Event called when the calling of the command line tool finished
  /// </summary>
  /// <param name="ResultCode">
  ///   Return value of the external program execution
  /// </param>
  TOnProgramRunFinished = reference to procedure(ResultCode: UInt32);

  /// <summary>
  ///   Asynchronously runs the batch file generated
  /// </summary>
  /// <param name="AProjectSettings">
  ///   Settings of the loaded/created project
  /// </param>
  /// <param name="AOnFinished">
  ///   Event for reporting that the coverage run has finished. The event is
  ///   called synchronized so performing GUI updates in it is safe
  /// </param>
  procedure RunBatchFile(AProjectSettings : IProjectOutputSettingsReadOnly;
                         AOnFinished      : TOnProgramRunFinished);

implementation

uses
  System.SysUtils,
  System.Threading,
  Winapi.ShellAPI,
  Winapi.Windows;

function RunProcess(FileName: string; ShowCmd: DWORD; wait: Boolean; ProcID: PCardinal): UInt32;
var
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
begin
  FillChar(StartupInfo, SizeOf(StartupInfo), #0);
  StartupInfo.cb := SizeOf(StartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW or STARTF_FORCEONFEEDBACK;
  StartupInfo.wShowWindow := ShowCmd;
  if not CreateProcess(nil,
    @Filename[1],
    nil,
    nil,
    False,
    CREATE_NEW_CONSOLE or
    NORMAL_PRIORITY_CLASS,
    nil,
    nil,
    StartupInfo,
    ProcessInfo)
    then
      Result := WAIT_FAILED
  else
  begin
    try
      if not wait then
      begin
        if ProcID <> nil then ProcID^ := ProcessInfo.dwProcessId;
        Result := S_OK;
        exit;
      end;
      WaitForSingleObject(ProcessInfo.hProcess, INFINITE);
      GetExitCodeProcess(ProcessInfo.hProcess, Result);
    finally
      CloseHandle(ProcessInfo.hProcess);
      CloseHandle(ProcessInfo.hThread);
    end;
  end;
end;

procedure RunBatchFile(AProjectSettings : IProjectOutputSettingsReadOnly;
                       AOnFinished      : TOnProgramRunFinished);
var
  aTask      : ITask;
  ProcID     : UInt32;
  CallResult : UInt32;
begin
  Assert(Assigned(AProjectSettings), 'Not created project contents object passed');
  Assert(Assigned(AOnFinished),      'No OnFinished event passed');

  aTask := TTask.Create(
    procedure
    begin
      CallResult := RunProcess(AProjectSettings.BatchFileName,
                               SW_NORMAL, true, @ProcID);

      TThread.Synchronize(TThread.Current,
        procedure
        begin
          AOnFinished(CallResult);
        end);
    end);
    aTask.Start;
end;

end.
