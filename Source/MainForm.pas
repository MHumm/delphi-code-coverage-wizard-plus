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
///   User interface of the application
/// </summary>
unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
  Vcl.VirtualImageList, Vcl.StdCtrls, Vcl.WinXPanels, Vcl.ExtCtrls,
  Vcl.BaseImageCollection, Vcl.ImageCollection, Vcl.ComCtrls, Vcl.ButtonGroup,
  Vcl.CheckLst, USettings, UDataModuleIcons, UProjectSettings, Vcl.WinXCtrls,
  Winapi.WebView2, Winapi.ActiveX, Vcl.Edge, Vcl.OleCtrls, SHDocVw;

type
  /// <summary>
  ///   Main form with all GUI elements
  /// </summary>
  TFormMain = class(TForm)
    cp_Main: TCardPanel;
    crd_Start: TCard;
    ButtonNew: TButton;
    VirtualImageListButtons32: TVirtualImageList;
    ButtonOpen: TButton;
    ButtonRun: TButton;
    ButtonAbout: TButton;
    ListViewProjects: TListView;
    Label1: TLabel;
    ButtonOpenRecent: TButton;
    ButtonRunRecent: TButton;
    ButtonDeleteSelected: TButton;
    crd_EditSettings: TCard;
    cp_Wizard: TCardPanel;
    crd_UnitTestExecutable: TCard;
    p_WizardNavigation: TPanel;
    ButtonGroup1: TButtonGroup;
    PanelHeader: TPanel;
    PanelBottomNavigation: TPanel;
    LabelTop: TLabel;
    ButtonPrevious: TButton;
    ButtonNext: TButton;
    Label2: TLabel;
    Label3: TLabel;
    EditExeFile: TEdit;
    EditMapFile: TEdit;
    ButtonOpenExe: TButton;
    VirtualImageListButtons16: TVirtualImageList;
    ButtonOpenMap: TButton;
    ButtonCancel: TButton;
    crd_Source: TCard;
    Label4: TLabel;
    EditSourcePath: TEdit;
    ButtonSourcePath: TButton;
    CheckListBoxSource: TCheckListBox;
    crd_Output: TCard;
    Label5: TLabel;
    EditScriptOutputFolder: TEdit;
    ButtonScriptOutputFolder: TButton;
    EditReportOutputFolder: TEdit;
    ButtonReportOutputFolder: TButton;
    Label6: TLabel;
    CheckBoxEMMA: TCheckBox;
    CheckBoxMeta: TCheckBox;
    CheckBoxXML: TCheckBox;
    CheckBoxHTML: TCheckBox;
    Label7: TLabel;
    Bevel1: TBevel;
    crd_MiscSettings: TCard;
    Label8: TLabel;
    CheckBoxRelativePaths: TCheckBox;
    LabelPath: TLabel;
    MemoScriptPreview: TMemo;
    Label9: TLabel;
    crd_SaveAndRun: TCard;
    ButtonSave: TButton;
    ButtonWizardRun: TButton;
    FileOpenDialogProject: TFileOpenDialog;
    FileOpenDialogExe: TFileOpenDialog;
    FileOpenDialogMap: TFileOpenDialog;
    FileSaveDialogProject: TFileSaveDialog;
    FolderOpenDialog: TFileOpenDialog;
    Label10: TLabel;
    b_SelectAll: TButton;
    b_DeselectAll: TButton;
    b_RefreshSourceFiles: TButton;
    Label11: TLabel;
    EditCodeCoverageExe: TEdit;
    ButtonOpenCodeCoverage: TButton;
    FileOpenDialogCoverage: TFileOpenDialog;
    ButtonHome: TButton;
    FolderOpenDialogReport: TFileOpenDialog;
    FolderOpenDialogSource: TFileOpenDialog;
    crd_Run: TCard;
    Label12: TLabel;
    ActivityIndicator: TActivityIndicator;
    crd_Finished: TCard;
    ButtonHomeAfterRun: TButton;
    WebBrowser: TWebBrowser;
    ButtonBrowserBack: TButton;
    ButtonBrowserNext: TButton;
    procedure ButtonAboutClick(Sender: TObject);
    procedure ButtonNewClick(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure ButtonNextClick(Sender: TObject);
    procedure ButtonPreviousClick(Sender: TObject);
    procedure ButtonOpenExeClick(Sender: TObject);
    procedure ButtonOpenMapClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonOpenClick(Sender: TObject);
    procedure ButtonRunClick(Sender: TObject);
    procedure ButtonSourcePathClick(Sender: TObject);
    procedure ButtonScriptOutputFolderClick(Sender: TObject);
    procedure ButtonReportOutputFolderClick(Sender: TObject);
    procedure EditSourcePathChange(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonDeleteSelectedClick(Sender: TObject);
    procedure CheckBoxEMMAClick(Sender: TObject);
    procedure EditMapFileChange(Sender: TObject);
    procedure EditExeFileChange(Sender: TObject);
    procedure crd_UnitTestExecutableEnter(Sender: TObject);
    procedure crd_SourceEnter(Sender: TObject);
    procedure crd_OutputEnter(Sender: TObject);
    procedure crd_MiscSettingsEnter(Sender: TObject);
    procedure crd_SaveAndRunEnter(Sender: TObject);
    procedure CheckListBoxSourceClickCheck(Sender: TObject);
    procedure b_SelectAllClick(Sender: TObject);
    procedure b_DeselectAllClick(Sender: TObject);
    procedure b_RefreshSourceFilesClick(Sender: TObject);
    procedure ButtonScriptOutputFolderExit(Sender: TObject);
    procedure EditReportOutputFolderExit(Sender: TObject);
    procedure CheckBoxXMLClick(Sender: TObject);
    procedure CheckBoxHTMLClick(Sender: TObject);
    procedure CheckBoxMetaClick(Sender: TObject);
    procedure CheckBoxRelativePathsClick(Sender: TObject);
    procedure ButtonOpenCodeCoverageClick(Sender: TObject);
    procedure EditCodeCoverageExeChange(Sender: TObject);
    procedure EditScriptOutputFolderExit(Sender: TObject);
    procedure ButtonHomeClick(Sender: TObject);
    procedure ButtonWizardRunClick(Sender: TObject);
    procedure ButtonGroup1ButtonClicked(Sender: TObject; Index: Integer);
    procedure ButtonOpenRecentClick(Sender: TObject);
    procedure ListViewProjectsDblClick(Sender: TObject);
    procedure ButtonRunRecentClick(Sender: TObject);
    procedure ButtonBrowserBackClick(Sender: TObject);
    procedure ButtonBrowserNextClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    /// <summary>
    ///   Manages application settings
    /// </summary>
    FSettings : TSettings;

    /// <summary>
    ///   Manages project settings and loading/saving these from/to a file
    /// </summary>
    FProject  : TProjectSettings;

    /// <summary>
    ///   Checks whether both file names have been filled in and depending on the
    ///   outcome sets the tag of the exe file card to the index of the check
    ///   icon or to -1. Means: displays a check or no icon, depending on whether
    ///   both values are set or at least one is missing
    /// </summary>
    procedure DisplayExeMapInputStatus;
    /// <summary>
    ///   Positions the form as defined in the settings
    /// </summary>
    procedure SetFormPos;
    /// <summary>
    ///   Fills the list of recent projects with the data from settings
    /// </summary>
    procedure DisplayRecentProjects;
    /// <summary>
    ///   Displays the dialog for adding this tool to Delphi's Tools menu
    /// </summary>
    procedure DisplayAddToToolsMenu;
    /// <summary>
    ///   Sets the focus on the first WinControl on the active card of the new
    ///   project wizard.
    /// </summary>
    procedure SetFocusToFirstProjectCardControl;
    /// <summary>
    ///   Selects or deselects all files in the source file list box.
    /// </summary>
    procedure SelectDeselectAllSourceFIles(Selected: Boolean);
    /// <summary>
    ///   Displays all source files in the project's list of source files along
    ///   with their selection status in the checkbox list
    /// </summary>
    procedure DisplaySourceFiles;
    /// <summary>
    ///   Checks whether all required fields on the output settings screen have
    ///   been filled in and if yes displays the check icon on the menu item.
    /// </summary>
    procedure DisplayOutputSettingsStatus;
    /// <summary>
    ///   Sets the image index of the active card.
    /// </summary>
    /// <param name="ImageIndex">
    ///   Index of the image to display on the menu button for the currently
    ///   active card
    /// </param>
    procedure SetActiveWizardCardImageIndex(ImageIndex: Integer);
    /// <summary>
    ///   Checks whether the currently active wizard page is the one for the
    ///   misc settings and if, sets the check icon for that menu button since
    ///   there is no mandatory control on this page
    /// </summary>
    procedure SetMiscSettingsCheckIfActive;
    /// <summary>
    ///   Changes the set of selected output formats. Either adds the format
    ///   specified or removes it.
    /// </summary>
    /// <param name="Checked">
    ///   When true the format will be added as output format, otherwise it will
    ///   be removed.
    /// </param>
    /// <param name="OutputFormat">
    ///   Format to be added or removed.
    /// </param>
    procedure OutputFormatCheckStatusChanged(Checked      : Boolean;
                                             OutputFormat : TOutputFormat);
    /// <summary>
    ///   Loads the specified project file, displays its contents and jumps into
    ///   edit mode's save and run section.
    /// </summary>
    /// <param name="FileName">
    ///   Path and name of the file to load
    /// </param>
    procedure LoadProjectFile(const FileName: string);
    /// <summary>
    ///   Loads the file selected in the listview
    /// </summary>
    procedure LoadSelectedFileFromListView;
    /// <summary>
    ///   Updates all icons for all buttons in the left hand wizard navigation
    ///   with the image index stored in their CardPanel Card.
    /// </summary>
    procedure DisplayButtonIcons;
    /// <summary>
    ///   Displays the check icon on the left hand side button menu if the
    ///   fields on the source files card are properly filled.
    /// </summary>
    procedure DisplaySourceFilesStatus;
    /// <summary>
    ///   Runs the specified script as defined in the project settings
    /// </summary>
    procedure RunScript;
    /// <summary>
    ///   Event which is being called when a coverage test run has been finished
    /// </summary>
    procedure OnTestRunFinished(Sender: TObject);
    procedure AdjustWebBrowserSize;
  public
  end;

var
  FormMain: TFormMain;

implementation

uses
  System.UITypes,
  System.IOUtils,
  UScriptsGenerator,
  UScriptRunner,
  UManageToolsMenu,
  UUtils,
  MainFormTexts;

{$R *.dfm}

const
  /// <summary>
  ///   Index of the icon for the currently active wizzard page
  /// </summary>
  cImgActivePage    = 7;
  /// <summary>
  ///   Index of the icon for a completely filled in wizzard page
  /// </summary>
  cImgCompletedPage = 8;

procedure TFormMain.ButtonSaveClick(Sender: TObject);
var
  ScriptGenerator : TScriptsGenerator;
begin
  FileSaveDialogProject.FileName := FProject.FileName;
  if FileSaveDialogProject.Execute then
  begin
    try
      FProject.SaveToXML(FileSaveDialogProject.FileName);
      FSettings.AddRecentProject(FileSaveDialogProject.FileName);
      ListViewProjects.Items.Clear;
      DisplayRecentProjects;

      crd_SaveAndRun.Tag := cImgCompletedPage;

      ScriptGenerator := TScriptsGenerator.Create(FProject,
                                                  FileSaveDialogProject.FileName);
      try
        ScriptGenerator.Generate;
      finally
        ScriptGenerator.Free;
      end;
    except
      on e:exception do
        MessageDlg(Format(rSaveFileError,
                          [e.Message, FileSaveDialogProject.FileName]),
                   mtError, [mbOK], -1);
    end;
  end;
end;

procedure TFormMain.SetActiveWizardCardImageIndex(ImageIndex : Integer);
begin
  ButtonGroup1.Items[cp_Wizard.ActiveCardIndex].ImageIndex := ImageIndex;
end;

procedure TFormMain.ButtonScriptOutputFolderClick(Sender: TObject);
begin
  if EditScriptOutputFolder.Text <> '' then
    FolderOpenDialog.FileName := EditScriptOutputFolder.Text;

  if FolderOpenDialog.Execute then
    EditScriptOutputFolder.Text := FolderOpenDialog.FileName;
end;

procedure TFormMain.ButtonScriptOutputFolderExit(Sender: TObject);
begin
  FProject.ScriptsOutputPath := EditScriptOutputFolder.Text;
end;

procedure TFormMain.ButtonSourcePathClick(Sender: TObject);
begin
  if EditSourcePath.Text <> '' then
    FolderOpenDialogSource.FileName := EditSourcePath.Text;

  if FolderOpenDialogSource.Execute then
    EditSourcePath.Text := FolderOpenDialogSource.FileName;
end;

procedure TFormMain.ButtonWizardRunClick(Sender: TObject);
begin
  crd_SaveAndRun.Tag := cImgCompletedPage;
  RunScript;
end;

procedure TFormMain.b_SelectAllClick(Sender: TObject);
begin
  SelectDeselectAllSourceFiles(true);
end;

procedure TFormMain.SelectDeselectAllSourceFiles(Selected: Boolean);
begin
  try
    for var i := 0 to CheckListBoxSource.Items.Count - 1 do
      FProject.ProgramSourceFiles.ChangeSelected(i, Selected);

    if Selected then
      CheckListBoxSource.CheckAll(TCheckBoxState.cbChecked, false, false)
    else
      CheckListBoxSource.CheckAll(TCheckBoxState.cbUnchecked, false, false);
  except
    on e:exception do
      MessageDlg(Format(rSelectionError, [e.Message]), mtError, [mbOK], -1);
  end;
end;

procedure TFormMain.b_DeselectAllClick(Sender: TObject);
begin
  SelectDeselectAllSourceFiles(false);
end;

procedure TFormMain.b_RefreshSourceFilesClick(Sender: TObject);
begin
  FProject.ProgramSourceFiles.UpdateSourceFilesList;
  DisplaySourceFiles;
end;

procedure TFormMain.ButtonAboutClick(Sender: TObject);
begin
  MessageDlg('Delphi Code Coverage Wizard' + sLineBreak +
             '© 2022 Markus Humm' + sLineBreak +
             'based on the works of TridentT and ' + sLineBreak +
             'https://sourceforge.net/projects/delphicodecoverage/',
             mtInformation, [mbOK], -1);
end;

procedure TFormMain.ButtonBrowserBackClick(Sender: TObject);
begin
  try
    WebBrowser.GoBack;
  except
    // going back from the first page cannot be done, but there seems no way
    // to find out if we are on the first page
  end;
end;

procedure TFormMain.ButtonBrowserNextClick(Sender: TObject);
begin
  try
    WebBrowser.GoForward;
  except
    // going back from the first page cannot be done, but there seems no way
    // to find out if we are on the first page
  end;
end;

procedure TFormMain.ButtonCancelClick(Sender: TObject);
begin
  cp_Main.ActiveCard := crd_Start;
end;

procedure TFormMain.ButtonDeleteSelectedClick(Sender: TObject);
begin
  for var i := ListViewProjects.Items.Count - 1 downto 0 do
  begin
    if ListViewProjects.Items[i].Selected then
      FSettings.DeleteRecentProject(i);
  end;

  ListViewProjects.DeleteSelected;
end;

procedure TFormMain.ButtonGroup1ButtonClicked(Sender: TObject; Index: Integer);
begin
  SetActiveWizardCardImageIndex(cp_Wizard.Cards[cp_Wizard.ActiveCardIndex].Tag);

  case Index of
    0 : cp_Wizard.ActiveCard := crd_UnitTestExecutable;
    1 : cp_Wizard.ActiveCard := crd_Source;
    2 : cp_Wizard.ActiveCard := crd_Output;
    3 : begin
          cp_Wizard.ActiveCard := crd_MiscSettings;
          crd_MiscSettings.Tag := cImgCompletedPage;
          LabelPath.Caption    := FProject.ScriptsOutputPath;
        end;
    4 : cp_Wizard.ActiveCard := crd_SaveAndRun;
    else
      MessageDlg(Format(rUnknownMenu, [Index]), mtError, [mbOK], -1);
  end;

  SetActiveWizardCardImageIndex(cImgActivePage);
end;

procedure TFormMain.ButtonHomeClick(Sender: TObject);
begin
  cp_Main.ActiveCard := crd_Start;
end;

procedure TFormMain.ButtonNewClick(Sender: TObject);
begin
  cp_Main.ActiveCard        := crd_EditSettings;
  cp_Wizard.ActiveCardIndex := 0;
  ButtonPrevious.Enabled    := false;
  ButtonNext.Enabled        := true;
  ButtonPrevious.Enabled    := true;

  for var Item in ButtonGroup1.Items do
    (Item as TGrpButtonItem).ImageIndex := -1;

  ButtonGroup1.Items[0].ImageIndex := cImgActivePage;
end;

procedure TFormMain.ButtonNextClick(Sender: TObject);
begin
  if (cp_Wizard.ActiveCardIndex < cp_Wizard.CardCount-1) then
  begin
    SetActiveWizardCardImageIndex(cp_Wizard.Cards[cp_Wizard.ActiveCardIndex].Tag);

    cp_Wizard.ActiveCardIndex := cp_Wizard.ActiveCardIndex + 1;
    SetActiveWizardCardImageIndex(cImgActivePage);

    ButtonPrevious.Enabled := true;
    if (cp_Wizard.ActiveCardIndex = cp_Wizard.CardCount-1) then
      ButtonNext.Enabled := false;

    SetMiscSettingsCheckIfActive;
    SetFocusToFirstProjectCardControl;
  end;
end;

procedure TFormMain.SetMiscSettingsCheckIfActive;
begin
  if cp_Wizard.ActiveCard = crd_MiscSettings then
    crd_MiscSettings.Tag := cImgCompletedPage;
end;

procedure TFormMain.ButtonOpenClick(Sender: TObject);
begin
  if FileOpenDialogProject.Execute then
  begin
    LoadProjectFile(FileOpenDialogProject.FileName);
  end;
end;

procedure TFormMain.ListViewProjectsDblClick(Sender: TObject);
begin
  LoadSelectedFileFromListView;
end;

procedure TFormMain.LoadProjectFile(const FileName: string);
var
  OnChangeBackup : TNotifyEvent;
begin
  Assert(not FileName.IsEmpty, 'No file name given!');

  try
    FProject.LoadFromXML(FileName);

    EditExeFile.Text            := FProject.ExecutableToAnalyze;
    EditMapFile.Text            := FProject.MapFile;

    OnChangeBackup              := EditSourcePath.OnChange;
    EditSourcePath.OnChange     := nil;
    try
      EditSourcePath.Text       := FProject.ProgramSourceBasePath;
    finally
      EditSourcePath.OnChange := OnChangeBackup;
    end;

    EditScriptOutputFolder.Text := FProject.ScriptsOutputPath;
    EditReportOutputFolder.Text := FProject.ReportOutputPath;
    EditCodeCoverageExe.Text    := FProject.CodeCoverageExePath;

    CheckBoxEMMA.Checked          := ofEMMA in FProject.OutputFormats;
    CheckBoxMeta.Checked          := ofMeta in FProject.OutputFormats;
    CheckBoxXML.Checked           := ofXML  in FProject.OutputFormats;
    CheckBoxHTML.Checked          := ofHTML in FProject.OutputFormats;
    CheckBoxRelativePaths.Checked := FProject.RelativeToScriptPath;

    // Misc settings is always declared as completed
    crd_MiscSettings.Tag := cImgCompletedPage;
    LabelPath.Caption    := FProject.ScriptsOutputPath;

    ButtonGroup1.Items[0].ImageIndex := -1;
    DisplaySourceFiles;

    DisplayExeMapInputStatus;
    DisplaySourceFilesStatus;
    DisplayOutputSettingsStatus;

    DisplayButtonIcons;

    cp_Main.ActiveCard   := crd_EditSettings;
    cp_Wizard.ActiveCard := crd_SaveAndRun;
    SetActiveWizardCardImageIndex(cImgActivePage);
  except
    on e:exception do
      MessageDlg(Format(rLoadFileError, [e.Message, FileName]), mtError, [mbOK], -1);
  end;
end;

procedure TFormMain.DisplayButtonIcons;
begin
  ButtonGroup1.Items[0].ImageIndex := crd_UnitTestExecutable.Tag;
  ButtonGroup1.Items[1].ImageIndex := crd_Source.Tag;
  ButtonGroup1.Items[2].ImageIndex := crd_Output.Tag;
  ButtonGroup1.Items[3].ImageIndex := crd_MiscSettings.Tag;
  ButtonGroup1.Items[4].ImageIndex := crd_SaveAndRun.Tag;
end;

procedure TFormMain.ButtonOpenCodeCoverageClick(Sender: TObject);
begin
  if EditCodeCoverageExe.Text <> '' then
    FileOpenDialogCoverage.FileName := EditCodeCoverageExe.Text;

  if FileOpenDialogCoverage.Execute then
    EditCodeCoverageExe.Text := FileOpenDialogCoverage.FileName;
end;

procedure TFormMain.ButtonOpenExeClick(Sender: TObject);
begin
  if EditExeFile.Text <> '' then
    FileOpenDialogExe.FileName := EditExeFile.Text;

  if FileOpenDialogExe.Execute then
    EditExeFile.Text := FileOpenDialogExe.FileName;
end;

procedure TFormMain.ButtonOpenMapClick(Sender: TObject);
begin
  if EditMapFile.Text <> '' then
    FileOpenDialogMap.FileName := EditMapFile.Text;

  if FileOpenDialogMap.Execute then
    EditMapFile.Text := FileOpenDialogMap.FileName;
end;

procedure TFormMain.ButtonOpenRecentClick(Sender: TObject);
begin
  LoadSelectedFileFromListView;
end;

procedure TFormMain.LoadSelectedFileFromListView;
var
  Item : TListItem;
begin
  Item := ListViewProjects.Items[ListViewProjects.ItemIndex];

  if Assigned(Item) and (Item.SubItems.Count >= 1) and
     not Item.Caption.IsEmpty then
    LoadProjectFile(TPath.Combine(Item.Caption, Item.SubItems[0]));
end;

procedure TFormMain.ButtonPreviousClick(Sender: TObject);
begin
  if (cp_Wizard.ActiveCardIndex > 0) then
  begin
    SetActiveWizardCardImageIndex(cp_Wizard.Cards[cp_Wizard.ActiveCardIndex].Tag);

    cp_Wizard.ActiveCardIndex := cp_Wizard.ActiveCardIndex - 1;
    SetActiveWizardCardImageIndex(cImgActivePage);

    ButtonNext.Enabled := true;
    if (cp_Wizard.ActiveCardIndex = 0) then
      ButtonPrevious.Enabled := false;

    SetMiscSettingsCheckIfActive;
    SetFocusToFirstProjectCardControl;
  end;
end;

procedure TFormMain.ButtonReportOutputFolderClick(Sender: TObject);
begin
  if EditReportOutputFolder.Text <> '' then
    FolderOpenDialogReport.FileName := EditReportOutputFolder.Text;

  if FolderOpenDialogReport.Execute then
    EditReportOutputFolder.Text := FolderOpenDialogReport.FileName;
end;

procedure TFormMain.ButtonRunClick(Sender: TObject);
begin
  if FileOpenDialogProject.Execute then
  begin
    FProject.LoadFromXML(FileOpenDialogProject.FileName);
    RunScript;
  end;
end;

procedure TFormMain.ButtonRunRecentClick(Sender: TObject);
begin
  LoadSelectedFileFromListView;
  RunScript;
end;

procedure TFormMain.EditCodeCoverageExeChange(Sender: TObject);
begin
  FProject.CodeCoverageExePath := (Sender As TEdit).Text;
  DisplayExeMapInputStatus;
end;

procedure TFormMain.EditExeFileChange(Sender: TObject);
begin
  FProject.ExecutableToAnalyze := (Sender As TEdit).Text;
  EditMapFile.Text             := FProject.MapFile;

  DisplayExeMapInputStatus;
end;

procedure TFormMain.EditMapFileChange(Sender: TObject);
begin
  FProject.MapFile := (Sender As TEdit).Text;
  DisplayExeMapInputStatus;
end;

procedure TFormMain.EditReportOutputFolderExit(Sender: TObject);
begin
  FProject.ReportOutputPath := EditReportOutputFolder.Text;
  DisplayOutputSettingsStatus;
end;

procedure TFormMain.EditScriptOutputFolderExit(Sender: TObject);
begin
  FProject.ScriptsOutputPath := EditScriptOutputFolder.Text;
  DisplayOutputSettingsStatus;
end;

procedure TFormMain.EditSourcePathChange(Sender: TObject);
var
  OnChange : TNotifyEvent;
begin
  if (FProject.ProgramSourceFiles.Count > 0) then
  begin
    if (MessageDlg(rClearFileList, mtConfirmation,
                   [mbYes, mbNo], -1) = mrNo) then
    begin
      // restore old source path
      OnChange := EditSourcePath.OnChange;
      try
        EditSourcePath.OnChange := nil;
        EditSourcePath.Text := FProject.ProgramSourceBasePath;
      finally
        EditSourcePath.OnChange := OnChange;
      end;
      exit;
    end;
  end;

  // This not only updates the base path, but the list of source files as well
  // if the new path is really different
  FProject.ProgramSourceBasePath := (Sender as TEdit).Text;

  DisplaySourceFiles;
  DisplaySourceFilesStatus;
end;

procedure TFormMain.DisplaySourceFiles;
begin
  CheckListBoxSource.Items.Clear;
  FProject.ProgramSourceFiles.GetItemsList(CheckListBoxSource.Items);

  for var i := 0 to FProject.ProgramSourceFiles.Count - 1 do
    CheckListBoxSource.Checked[i] := FProject.ProgramSourceFiles.IsSelected(i);
end;

procedure TFormMain.DisplaySourceFilesStatus;
begin
  if FProject.IsSourcePathAndFilesDefined then
    crd_Source.Tag := cImgCompletedPage
  else
    crd_Source.Tag := -1;
end;

procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FSettings.XPos   := Left;
  FSettings.YPos   := Top;
  FSettings.Width  := ClientWidth;
  FSettings.Height := ClientHeight;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  FSettings := TSettings.Create;

  if Is64BitWindows then
    FProject  := TProjectSettings.Create('..\..\Coverage_x64.exe')
  else
    FProject  := TProjectSettings.Create('..\..\Coverage.exe');

  SetFormPos;
  DisplayRecentProjects;

  for var i := 0 to cp_Wizard.CardCount - 1 do
    cp_Wizard.Cards[i].Tag := -1;

  cp_Wizard.ActiveCardIndex := 0;
  cp_Main.ActiveCard := crd_Start;

  DisplayAddToToolsMenu;
end;

procedure TFormMain.SetFormPos;
begin
  Position     := poDesigned;

  if (FSettings.XPos + FSettings.Width - 10) > 0 then
    Left         := FSettings.XPos
  else
    Left := 0;

  if (FSettings.YPos + FSettings.Height - 10) > 0 then
   Top          := FSettings.YPos
  else
    Top := 0;

  if (FSettings.Width >= 624) then
    ClientWidth  := FSettings.Width;

  if (FSettings.Height >= 400) then
    ClientHeight := FSettings.Height;
end;

procedure TFormMain.DisplayAddToToolsMenu;
var
  ToolsMenuManager : TToolsMenuManager;
begin
  ToolsMenuManager := TToolsMenuManager.Create;
  try
    ToolsMenuManager.CheckAndSetIDEToolsEntry(self);
  finally
    ToolsMenuManager.Free;
  end;
end;

procedure TFormMain.DisplayRecentProjects;
var
  Item : TListItem;
begin
  for var i := 0 to FSettings.RecentProjectsCount - 1 do
  begin
    Item := ListViewProjects.Items.Add;
    Item.Caption := ExtractFilePath(FSettings.RecentProject[i]);
    Item.SubItems.Add(ExtractFileName(FSettings.RecentProject[i]));
  end;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  FSettings.Free;
  FProject.Free;
end;

procedure TFormMain.FormResize(Sender: TObject);
begin
  AdjustWebBrowserSize;
end;

procedure TFormMain.AdjustWebBrowserSize;
begin
  WebBrowser.Width := crd_Finished.Width-10;
  WebBrowser.Height := crd_Finished.Height-10-ButtonHomeAfterRun.Height;
end;

procedure TFormMain.CheckBoxEMMAClick(Sender: TObject);
begin
  OutputFormatCheckStatusChanged((Sender as TCheckBox).Checked, ofEMMA);
end;

procedure TFormMain.CheckBoxHTMLClick(Sender: TObject);
begin
  OutputFormatCheckStatusChanged((Sender as TCheckBox).Checked, ofHTML);
end;

procedure TFormMain.CheckBoxMetaClick(Sender: TObject);
begin
  OutputFormatCheckStatusChanged((Sender as TCheckBox).Checked, ofMETA);
end;

procedure TFormMain.CheckBoxRelativePathsClick(Sender: TObject);
begin
  FProject.RelativeToScriptPath := (Sender as TCheckBox).Checked;

  MemoScriptPreview.Clear;

  if FProject.RelativeToScriptPath then
  begin
    MemoScriptPreview.Lines.Add('DelphiCoverage.exe: '  +
      FProject.GetRelativePath(FProject.CodeCoverageExePath) + '');
    MemoScriptPreview.Lines.Add('Exe-file to analyze: ' +
      FProject.GetRelativePath(FProject.ExecutableToAnalyze) + '');
    MemoScriptPreview.Lines.Add('Map-file of the Exe: ' +
      FProject.GetRelativePath(FProject.MapFile) + '');
    MemoScriptPreview.Lines.Add('Source files path: '   +
      FProject.GetRelativePath(FProject.ProgramSourceBasePath) + '');
    MemoScriptPreview.Lines.Add('Report output path: '  +
      FProject.GetRelativePath(FProject.ReportOutputPath) + '');
  end
  else
  begin
    MemoScriptPreview.Lines.Add('DelphiCoverage.exe: '  +
      FProject.CodeCoverageExePath + '');
    MemoScriptPreview.Lines.Add('Exe-file to analyze: ' +
      FProject.ExecutableToAnalyze + '');
    MemoScriptPreview.Lines.Add('Map-file of the Exe: ' +
      FProject.MapFile + '');
    MemoScriptPreview.Lines.Add('Source files path: '   +
      FProject.ProgramSourceBasePath + '');
    MemoScriptPreview.Lines.Add('Report output path: '  +
      FProject.ReportOutputPath + '');
  end;
end;

procedure TFormMain.CheckBoxXMLClick(Sender: TObject);
begin
  OutputFormatCheckStatusChanged((Sender as TCheckBox).Checked, ofXML);
end;

procedure TFormMain.OutputFormatCheckStatusChanged(Checked      : Boolean;
                                                   OutputFormat : TOutputFormat);
begin
  if Checked then
    FProject.OutputFormats := FProject.OutputFormats + [OutputFormat]
  else
    FProject.OutputFormats := FProject.OutputFormats - [OutputFormat];

  DisplayOutputSettingsStatus;
end;

procedure TFormMain.CheckListBoxSourceClickCheck(Sender: TObject);
var
  lb : TCheckListBox;
begin
  try
    lb := Sender as TCheckListBox;
    FProject.ProgramSourceFiles.ChangeSelected(lb.ItemIndex,
                                               lb.Checked[lb.ItemIndex]);
  except
    on e:exception do
      MessageDlg(Format(rSelectionError, [e.Message]), mtError, [mbOK], -1);
  end;
end;

procedure TFormMain.crd_MiscSettingsEnter(Sender: TObject);
begin
  LabelTop.Caption := rMiscOptions;
end;

procedure TFormMain.crd_OutputEnter(Sender: TObject);
begin
  LabelTop.Caption := rOutputOptions;
end;

procedure TFormMain.crd_SaveAndRunEnter(Sender: TObject);
begin
  LabelTop.Caption := rSaveAndRun;
end;

procedure TFormMain.crd_SourceEnter(Sender: TObject);
begin
  LabelTop.Caption := rSourcePath;
end;

procedure TFormMain.crd_UnitTestExecutableEnter(Sender: TObject);
begin
  LabelTop.Caption := rUnitTestExe;
end;

procedure TFormMain.SetFocusToFirstProjectCardControl;
begin
  for var i := 0 to cp_Wizard.ActiveCard.ControlCount - 1 do
  begin
    if (cp_Wizard.ActiveCard.Controls[i] is TWinControl) then
    begin
      (cp_Wizard.ActiveCard.Controls[i] as TWinControl).SetFocus;
      break;
    end;
  end;
end;

procedure TFormMain.DisplayExeMapInputStatus;
begin
  if FProject.IsExeAndMapDefined then
    crd_UnitTestExecutable.Tag := cImgCompletedPage
  else
    crd_UnitTestExecutable.Tag := -1;
end;

procedure TFormMain.DisplayOutputSettingsStatus;
begin
  if FProject.IsOutputSettingsDefined then
    crd_Output.Tag := cImgCompletedPage
  else
    crd_Output.Tag := -1;
end;

procedure TFormMain.RunScript;
begin
  cp_Main.ActiveCard        := crd_Run;
  ActivityIndicator.Visible := true;
  ActivityIndicator.Animate := true;
  ActivityIndicator.Left    := (crd_Run.Width div 2) - (ActivityIndicator.Width div 2);
  ActivityIndicator.Top     := (crd_Run.Height div 2) - (ActivityIndicator.Height div 2);

  // Asynchronously runs the generated batch file
  RunBatchFile(FProject, OnTestRunFinished);
end;

procedure TFormMain.OnTestRunFinished(Sender: TObject);
begin
  if ofHTML in FProject.OutputFormats then
  begin
    cp_Main.ActiveCard := crd_Finished;
    AdjustWebBrowserSize;
    WebBrowser.Navigate(FProject.GetReportOutputIndexURL);
  end
  else
    cp_Main.ActiveCard := crd_Start;
end;

end.
