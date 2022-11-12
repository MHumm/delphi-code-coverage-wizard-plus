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
  end;

implementation

uses
  System.SysUtils,
  System.IOUtils,
  MainFormTexts;

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


end.
