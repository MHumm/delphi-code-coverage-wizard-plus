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
///   Buisiness logic for the main form
/// </summary>
unit MainFormLogic;

interface

uses
  System.SysUtils,
  System.Classes,
  Winapi.Windows,
  UProjectSettingsInterface;

type
  /// <summary>
  ///   Possible action which can be started from the command line
  ///   paOpen: open the project file specified
  ///   paRun: open and directly run the project file specified
  /// </summary>
  TParamAction = (paOpen, paRun, paHelp);

  /// <summary>
  ///   An event of this type is called, if a corresponding command line parameter
  ///   is passed.
  /// </summary>
  TComandLineActionEvent = reference to procedure(Action: TParamAction;
                                                  const FileName: string);

  /// <summary>
  ///   Details for a command line param
  /// </summary>
  TActionParamRec = record
    /// <summary>
    ///   Action specified with the param
    /// </summary>
    Action         : TParamAction;
    /// <summary>
    ///   Index of the command line argument containing the file name the action
    ///   should act on
    /// </summary>
    FileParamIndex : Integer;
  end;

  /// <summary>
  ///   An event of this type is called if a failure happened when processing
  ///   command line params.
  /// </summary>
  TCommandLineError = reference to procedure(const FailureMessage: string);

  /// <summary>
  ///   Deletes an entry from the list of recent projects
  /// </summary>
  /// <param name="Index">
  ///   Index of the entry to be deleted. Throws an index out of range exception
  ///   if an invalid index is specified. See RecentProjectsCount for the
  ///   upper limit.
  /// </param>
  TDeleteRecentProject = reference to procedure (Index: Integer);

  /// <summary>
  ///   Buisiness logic for the main form
  /// </summary>
  TMainFormLogic = class(TObject)
  strict private
  private
    /// <summary>
    ///   Returns the data for the specified command line action, unless it is
    ///   -?
    /// </summary>
    /// <returns>
    ///   Action to run and file name to run it on
    /// </returns>
    function GetCommandLineAction : TActionParamRec;
  public
    /// <summary>
    ///   Processes the specified command line parameters and if valid ones are
    ///   found the matching action is carried out. As of now there can only be
    ///   one valid parameter at any given time, so specifying -? and -O <FileName>
    ///   will only call the about dialog!
    /// </summary>
    /// <param name="Action">
    ///   Event called to carry out the action specified via command line.
    ///   The event receives the action to call and if it is a file based one
    ///   the file name (with DCCP suffix). File based actions are only called
    ///   if the specified file name actually exists.
    /// </param>
    /// <param name="OnError">
    ///   Event called if there's something wrong with the command line params
    /// </param>
    procedure ProcessCmdLineParams(OnAction : TComandLineActionEvent;
                                   OnError  : TCommandLineError = nil);

    /// <summary>
    ///   Retrieves the file version from the version ressources
    /// </summary>
    /// <param name="FileName">
    ///   Name of the exe/dll to retrieve the version from
    /// </param>
    /// <returns>
    ///   Version information in the form of V<Major>.<Minor>.<Release> build <Build>
    /// </returns>
    function GetFileVersion(const FileName: TFileName): string;

    /// <summary>
    ///   Calls an external application via ShellExecute
    /// </summary>
    /// <param name="Handle">
    ///   Handle of the calling window
    /// </param>
    /// <param name="Operation">
    ///   Operation to carry out, e.g. 'open' or 'print'
    /// </param>
    /// <param name="Param">
    ///   Parameters to pass to the external application, e.g. file name to open
    /// </param>
    /// <param name="ShowCmd">
    ///   How to display the external application's window?
    ///   See SW_XXX constants from Winapi.Windows unit.
    /// </param>
    /// <returns>
    ///   Empty string on success, otherwise failure message for the failure code
    ///   returned from ShellExecute.
    /// </returns>
    function CallShellExecute(Handle          : HWND;
                              const Operation : string;
                              const Param     : string;
                              ShowCmd         : Integer):string;

    /// <summary>
    ///   Checks if the project is configured to open any of the generated
    ///   files in an external viewer and performs that action.
    /// </summary>
    /// <param name="Handle">
    ///   Handle of the window calling the external application
    /// </param>
    /// <param name="ProjectOutputSettings">
    ///   Interface to the relevant output settings of the loaded project
    /// </param>
    /// <returns>
    ///   Empty string if successfull, otherwise failure message of failed
    ///   ShellExecute calls.
    /// </returns>
    function CallExternalViewers(Handle: HWND;
                                 ProjectOutputSettings : IProjectOutputSettingsReadOnly):string;

    /// <summary>
    ///   Checks if all projects in the list still exist and deletes those
    ///   from the list which no longer exist.
    /// </summary>
    /// <param name="Projects">
    ///   List of file names to check
    /// </param>
    /// <param name="DeleteProc">
    ///   Method for deleting them from the internal data
    /// </param>
    procedure DeleteNonExistingRecentProjects(Projects: TStrings;
                                              DeleteProc: TDeleteRecentProject);
  end;

implementation

uses
  System.IOUtils,
  WinApi.ShellAPI,
  MainFormTexts,
  UConsts;

function TMainFormLogic.GetCommandLineAction: TActionParamRec;
begin
  // Find out the action to be called and which param must contain the file name
  if (ParamStr(1).ToUpper = '-O') or (ParamStr(1).ToUpper <> '-R') then
  begin
    Result.Action := paOpen;
    if (ParamStr(1).ToUpper = '-O') then
      Result.FileParamIndex := 2
    else
      Result.FileParamIndex := 1;
  end
  else
    if (ParamStr(1).ToUpper = '-R') then
    begin
      Result.Action         := paRun;
      Result.FileParamIndex := 2;
    end;
end;

procedure TMainFormLogic.ProcessCmdLineParams(OnAction : TComandLineActionEvent;
                                              OnError  : TCommandLineError);
var
  ActionDetails : TActionParamRec;
  FileName, FN  : string;
begin
  Assert(Assigned(OnAction), 'Mandatory OnAction event not assigned');

  if (ParamCount < 1) then
    exit;

  // find out if the first argument is -O (= open), -R (= run) or -? (Help)
  // and if it is, the 2nd argument must be the file, either directly the
  // DCCP one or the dpr, dproj. In the latter case try to find out if a
  // matching DCCP file exists on the same path
  if (ParamStr(1).ToUpper = '-?') then
    OnAction(TParamAction.paHelp, '')
  else
  begin
    try
      ActionDetails := GetCommandLineAction;

      FileName := ParamStr(ActionDetails.FileParamIndex);

      FN       := FileName.ToUpper;
      if not FN.EndsWith('DCCP') then
      begin
        if FN.EndsWith('dpr') or FN.EndsWith('dproj') then
          FileName := TPath.ChangeExtension(FileName, 'DCCP')
        else
          raise Exception.Create(Format(rWrongExtension, [FileName]));
      end;

      if FileExists(FileName) then
        OnAction(ActionDetails.Action, FileName)
      else
        raise Exception.Create(Format(rFileNotExists, [FileName]));
    except
      on e:Exception do
        if Assigned(OnError) then
          OnError(e.Message);
    end;
  end;
end;

function TMainFormLogic.CallExternalViewers(Handle: HWND;
  ProjectOutputSettings: IProjectOutputSettingsReadOnly): string;
var
  FileName : string;
  ErrorMsg : string;
begin
  Result := '';

  if (ofHTML in ProjectOutputSettings.OutputFormats) and
     ProjectOutputSettings.DisplayHTMLFileExt then
  begin
    FileName := TPath.Combine(ProjectOutputSettings.ReportOutputPath,
                              cHTMLOutputBaseFileName);
    Result := CallShellExecute(Handle, 'open', FileName, SW_SHOW);

    if not Result.IsEmpty then
      Result := Format(rExtCallFailed, [FileName, Result]);
  end;

  if (ofXML in ProjectOutputSettings.OutputFormats) and
     ProjectOutputSettings.DisplayXMLFileExt then
  begin
    FileName := TPath.Combine(ProjectOutputSettings.ReportOutputPath,
                              cXMLOutputBaseFileName);
    ErrorMsg := CallShellExecute(Handle, 'open', FileName, SW_SHOW);

    if not ErrorMsg.IsEmpty then
    begin
      if not Result.IsEmpty then
        Result := Result + sLineBreak;

      Result := Result + sLineBreak + Format(rExtCallFailed, [FileName, ErrorMsg]);
    end;

    if ProjectOutputSettings.XMLJacocoFormat then
    begin
      FileName := TPath.Combine(ProjectOutputSettings.ReportOutputPath,
                                cXMLJacocoOutputFileName);
      ErrorMsg := CallShellExecute(Handle, 'open', FileName, SW_SHOW);

      if not ErrorMsg.IsEmpty then
      begin
        if not Result.IsEmpty then
          Result := Result + sLineBreak;

        Result := Result + sLineBreak + Format(rExtCallFailed, [FileName, ErrorMsg]);
      end;
    end;
  end;

  if (ofEMMA in ProjectOutputSettings.OutputFormats) and
     ProjectOutputSettings.DisplayEMMAFileExt then
  begin
    FileName := TPath.Combine(ProjectOutputSettings.ReportOutputPath,
                              cEMMAOutputBaseFileName);
    ErrorMsg := CallShellExecute(Handle, 'open', FileName, SW_SHOW);

    if not ErrorMsg.IsEmpty then
    begin
      if not Result.IsEmpty then
        Result := Result + sLineBreak;

      Result := Result + sLineBreak + Format(rExtCallFailed, [FileName, ErrorMsg]);
    end;
  end;

  Result := Result.TrimLeft([#10, #13]);
end;

function TMainFormLogic.CallShellExecute(Handle: HWND;
                                         const Operation, Param: string;
                                         ShowCmd: Integer): string;
var
  FailureCode : NativeInt;
begin
  Result := '';

  FailureCode := ShellExecute(Handle, PWideChar(Operation), PWideChar(Param),
                              nil, nil, ShowCmd);
  if FailureCode < 33 then
    case FailureCode of
       0 : Result := rShellExecErr0;
       2 : Result := rShellExecErr2;
       3 : Result := rShellExecErr3;
       5 : Result := rShellExecErr5;
       8 : Result := rShellExecErr8;
      10 : Result := rShellExecErr10;
      11 : Result := rShellExecErr11;
      12 : Result := rShellExecErr12;
      13 : Result := rShellExecErr13;
      15 : Result := rShellExecErr15;
      16 : Result := rShellExecErr16;
      19 : Result := rShellExecErr19;
      20 : Result := rShellExecErr20;
      26 : Result := rShellExecErr26;
      27 : Result := rShellExecErr27;
      28 : Result := rShellExecErr28;
      29 : Result := rShellExecErr29;
      30 : Result := rShellExecErr30;
      31 : Result := rShellExecErr31;
      32 : Result := rShellExecErr32;
      else
        Result := Format(rShellExecErr, [FailureCode]);
    end;
end;

procedure TMainFormLogic.DeleteNonExistingRecentProjects(Projects: TStrings;
                                                         DeleteProc: TDeleteRecentProject);
var
  i : Integer;
begin
  Assert(Assigned(Projects), 'List passed is not created!');

  i := 0;
  while (i < Projects.Count) do
  begin
    if not FileExists(Projects[i]) then
    begin
      DeleteProc(i);
      Projects.Delete(i);
    end
    else
      inc(i);
  end;
end;

function TMainFormLogic.GetFileVersion(const FileName: TFileName): string;
var
  VerInfoSize: Cardinal;
  VerValueSize: Cardinal;
  Dummy: Cardinal;
  PVerInfo: Pointer;
  PVerValue: PVSFixedFileInfo;
begin
  Result   := '';
  PVerInfo := nil;

  VerInfoSize := GetFileVersionInfoSize(PChar(FileName), Dummy);
  try
    GetMem(PVerInfo, VerInfoSize);
    try
      if GetFileVersionInfo(PChar(FileName), 0, VerInfoSize, PVerInfo) then
        if VerQueryValue(PVerInfo, '\', Pointer(PVerValue), VerValueSize) then
          with PVerValue^ do
            Result := Format('V%d.%d.%d build %d', [
              HiWord(dwFileVersionMS), //Major
              LoWord(dwFileVersionMS), //Minor
              HiWord(dwFileVersionLS), //Release
              LoWord(dwFileVersionLS)]); //Build
    except
     on e:Exception do
      Result := 'Failure: ' + e.Message;
    end;
  finally
    if Assigned(PVerInfo) then
      FreeMem(PVerInfo, VerInfoSize);
  end;
end;

end.
