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
///   Provides the adding of this tool to Delphi tools menu
/// </summary>
unit UManageToolsMenu;

interface

uses
  Registry,
  System.Classes,
  VCL.Dialogs;

type
  /// <summary>
  ///   Class for managing this tool's "Tools" menu entry in the IDE
  /// </summary>
  TToolsMenuManager = class(TObject)
  private
    /// <summary>
    ///   Provide access to Windows registry
    /// </summary>
    FReg: TRegistry;

    /// <summary>
    ///   Checks, whether the wizard already checked if it is integrated
    ///   into tools menu or not and if, returns a list of known configurations
    ///   so we can check if any new configurations appeared.
    /// </summary>
    /// <param name="KnownConfigurations">
    ///   If we found that there are Tools menu integration settings for this
    ///   tool already, this string returns a ; separated list of IDE
    ///   configurations known at the time we did that setting.
    /// </param>
    /// <returns>
    ///   true, if there's already a setting, false if not.
    /// </returns>
    function GetKnownConfigurations(var KnownConfigurations: string):Boolean;
    /// <summary>
    ///   Stores the list of known IDE configurations into the registry so
    ///   we can check later whether that changed and we might need to reask
    /// </summary>
    procedure SetKnownConfigurations(const KnownConfigurations: string);
    /// <summary>
    ///   Checks, whether the user opted to never ask about adding the tool to
    ///   tools menu
    /// </summary>
    /// <returns>
    ///   true if the user opted to never again as whether to add it to tools
    ///   menu, false if he agreed to be asked again or if he wasn't asked this
    ///   yet
    /// </returns>
    function GetNeverAskSet: Boolean;
    /// <summary>
    ///   Sets the never ask again setting
    /// </summary>
    /// <param name="Value">
    ///   New value for the setting
    /// </param>
    procedure SetNeverAsk(Value: Boolean);
  public
    /// <summary>
    ///   Allocate internal ressources
    /// </summary>
    constructor Create;
    /// <summary>
    ///   Free internal ressources
    /// </summary>
    destructor Destroy; override;

    /// <summary>
    ///   Checks if there is a IDE/Tools entry for this one already and
    ///   adds it on request of the user.
    /// </summary>
    /// <param name="AOwner">
    ///   If we need to show the dialog for managing the configurations we want
    ///   this tool to integrate, this parameter will be the owner of that form
    /// </param>
    procedure CheckAndSetIDEToolsEntry(AOwner: TComponent);
  end;

implementation

uses
  System.UITypes,
  System.SysUtils,
  WinApi.Windows,
  UAddIDETool,
  ConfigurationSelectionForm;

{ TToolsMenuManager }

procedure TToolsMenuManager.CheckAndSetIDEToolsEntry(AOwner: TComponent);
var
  KnownConfigurations : string;
  IDEToolManager      : TAddIDETool;
  IDEVersionList      : TIDEVersionList;
  IDEVersions         : string;
  ConfigSelectionForm : TConfigSelectionForm;
begin
  // user has not opted to be never asked again
  if not GetNeverAskSet then
  begin
    IDEToolManager := TAddIDETool.Create;
    try
      IDEVersionList := IDEToolManager.GetIDEVersionsList;
      IDEVersions    := IDEVersionList.GetIDEVersionsString;

      try
        GetKnownConfigurations(KnownConfigurations);

        // Are there new IDE verisions/configurations?
        if (KnownConfigurations <> IDEVersions) then
          // if yes remember so we do not ask the next time this tool was started
          SetKnownConfigurations(IDEVersions);

        // did the available IDE configuratons change? If yes we need to ask
        // whether the user wants to add them to tools menu
        if (KnownConfigurations <> IDEVersions) and
           (Length(IDEVersions) > Length(KnownConfigurations)) then
        begin
          if (MessageDlg('You are either running this program for the first time '+
                         'or new IDE versions/configurations have been added to '+
                         'the system. Would you like to manage IDE "Tools" menu ' +
                         'integration of Delphi Code Coverage Wizard now? ' +
                         '(available in Tools menu after next IDE restart)',
                         mtConfirmation, [mbYes, mbNo], -1, mbYes) = mrYes) then
          begin
            ConfigSelectionForm := TConfigSelectionForm.Create(AOwner,
                                                               'Open in Code Coverage Wizard',
                                                               '-O $PROJECT',
                                                               'Run with Code Coverage Wizard',
                                                               '-R $PROJECT',
                                                               ParamStr(0),
                                                               System.SysUtils.ExtractFilePath(ParamStr(0)));

            try
              ConfigSelectionForm.ShowModal;
            finally
              ConfigSelectionForm.Free;
            end;
          end
          else
          begin
            if (MessageDlg('Never ask about IDE "Tools" menu integration again?',
                           mtConfirmation, [mbYes, mbNo], -1, mbYes) = mrYes) then
              SetNeverAsk(true);
          end;
        end;
      finally
        IDEVersionList.Free;
      end;
    finally
      IDEToolManager.Free;
    end;
  end;
end;

constructor TToolsMenuManager.Create;
begin
  inherited;

  FReg         := TRegistry.Create;
  FReg.RootKey := HKEY_CURRENT_USER;
end;

destructor TToolsMenuManager.Destroy;
begin
  FReg.Free;

  inherited;
end;

function TToolsMenuManager.GetKnownConfigurations(var KnownConfigurations: string): Boolean;
begin
  Result := false;

  if FReg.OpenKey('SOFTWARE\DelphiCodeCoverageWizard', false) then
  begin
    if FReg.ValueExists('KnownConfigurations') then
    begin
      KnownConfigurations := FReg.ReadString('KnownConfigurations');
      Result := true;
    end;

    FReg.CloseKey;
  end;
end;

function TToolsMenuManager.GetNeverAskSet: Boolean;
begin
  Result := false;

  if FReg.OpenKey('SOFTWARE\DelphiCodeCoverageWizard', false) then
  begin
    if FReg.ValueExists('NeverAsk') then
      Result := FReg.ReadBool('NeverAsk');

    FReg.CloseKey;
  end;
end;

procedure TToolsMenuManager.SetKnownConfigurations(const KnownConfigurations: string);
begin
  if FReg.OpenKey('SOFTWARE\DelphiCodeCoverageWizard', true) then
  begin
    FReg.WriteString('KnownConfigurations', KnownConfigurations);
    FReg.CloseKey;
  end;
end;

procedure TToolsMenuManager.SetNeverAsk(Value: Boolean);
begin
  if FReg.OpenKey('SOFTWARE\DelphiCodeCoverageWizard', true) then
  begin
    FReg.WriteBool('NeverAsk', Value);
    FReg.CloseKey;
  end;
end;

end.
