program DelphiCodeCoverageWizard;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {FormMain},
  USettings in 'USettings.pas',
  UManageToolsMenu in 'UManageToolsMenu.pas',
  ConfigurationSelectionForm in 'ConfigurationSelectionForm.pas' {ConfigSelectionForm},
  UAddIDETool in 'UAddIDETool.pas',
  UDataModuleIcons in 'UDataModuleIcons.pas' {dm_Icons: TDataModule},
  UProjectSettings in 'UProjectSettings.pas',
  MainFormTexts in 'MainFormTexts.pas',
  UUtils in 'UUtils.pas',
  UScriptsGenerator in 'UScriptsGenerator.pas',
  UScriptRunner in 'UScriptRunner.pas',
  AboutForm in 'AboutForm.pas' {FormAbout},
  MainFormLogic in 'MainFormLogic.pas',
  UProjectSettingsInterface in 'UProjectSettingsInterface.pas',
  UConsts in 'UConsts.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdm_Icons, dm_Icons);
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
