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
  Vcl.CheckLst, USettings, UDataModuleIcons, Vcl.WinXCtrls, Vcl.Menus,
  Winapi.WebView2, Winapi.ActiveX, Vcl.Edge, Vcl.OleCtrls, SHDocVw,
  MainFormLogic, UProjectSettings, UProjectSettingsInterface, Vcl.NumberBox;

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
    LabelRecentProjectsCaption: TLabel;
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
    LabelUnitTestExe: TLabel;
    LabelUnitTestMap: TLabel;
    EditExeFile: TEdit;
    EditMapFile: TEdit;
    ButtonOpenExe: TButton;
    VirtualImageListButtons16: TVirtualImageList;
    ButtonOpenMap: TButton;
    ButtonCancel: TButton;
    crd_Source: TCard;
    LabelSourceFilesPath: TLabel;
    EditSourcePath: TEdit;
    ButtonSourcePath: TButton;
    CheckListBoxSource: TCheckListBox;
    crd_Output: TCard;
    LabelScriptOutputPath: TLabel;
    EditScriptOutputFolder: TEdit;
    ButtonScriptOutputFolder: TButton;
    EditReportOutputFolder: TEdit;
    ButtonReportOutputFolder: TButton;
    LabelReportOutputPath: TLabel;
    CheckBoxEMMA: TCheckBox;
    CheckBoxMeta: TCheckBox;
    CheckBoxXML: TCheckBox;
    CheckBoxHTML: TCheckBox;
    LabelOutputFormatsCaption: TLabel;
    Bevel1: TBevel;
    crd_MiscSettings: TCard;
    LabelMiscSettingsNote: TLabel;
    CheckBoxRelativePaths: TCheckBox;
    LabelPath: TLabel;
    MemoScriptPreview: TMemo;
    LabelScriptPreviewCaption: TLabel;
    crd_SaveAndRun: TCard;
    ButtonSave: TButton;
    ButtonWizardRun: TButton;
    FileOpenDialogProject: TFileOpenDialog;
    FileOpenDialogExe: TFileOpenDialog;
    FileOpenDialogMap: TFileOpenDialog;
    FileSaveDialogProject: TFileSaveDialog;
    FolderOpenDialog: TFileOpenDialog;
    LabelSourceFilesCaption: TLabel;
    b_SelectAll: TButton;
    b_DeselectAll: TButton;
    b_RefreshSourceFiles: TButton;
    LabelCodeCoveragePath: TLabel;
    EditCodeCoverageExe: TEdit;
    ButtonOpenCodeCoverage: TButton;
    FileOpenDialogCoverage: TFileOpenDialog;
    ButtonHome: TButton;
    FolderOpenDialogReport: TFileOpenDialog;
    FolderOpenDialogSource: TFileOpenDialog;
    crd_Run: TCard;
    LabelRunDescription: TLabel;
    ActivityIndicator: TActivityIndicator;
    crd_Finished: TCard;
    ButtonHomeAfterRun: TButton;
    ButtonBrowserBack: TButton;
    ButtonBrowserNext: TButton;
    EdgeBrowser: TEdgeBrowser;
    PopupMenuRecentProjects: TPopupMenu;
    PMOpenSelected: TMenuItem;
    PMRunselected: TMenuItem;
    PMRemoveselected: TMenuItem;
    ScrollBoxOutputSettings: TScrollBox;
    CheckBoxEMMA21: TCheckBox;
    CheckBoxOpenEMMAFileExtern: TCheckBox;
    CheckBoxOpenXMLFileExtern: TCheckBox;
    CheckBoxOpenHTMLFileExtern: TCheckBox;
    CheckBoxXMLLines: TCheckBox;
    CheckBoxXMLCombineMultiple: TCheckBox;
    LabelAdditioalParams: TLabel;
    EditAdditionalParameter: TEdit;
    CheckBoxXMLJacocoFormat: TCheckBox;
    ScrollBoxMisc: TScrollBox;
    Label1: TLabel;
    CheckBoxLogToFile: TCheckBox;
    CheckBoxLogPerAPI: TCheckBox;
    CheckBoxPassThroughExitCode: TCheckBox;
    CheckBoxUseApplicationWorkingDir: TCheckBox;
    Label2: TLabel;
    EditCommandLineParams: TEdit;
    ScrollBoxUnitTestExecutable: TScrollBox;
    ButtonSaveAs: TButton;
    LabelCodePage: TLabel;
    EditCodePage: TEdit;
    PMRemoveInexisting: TMenuItem;
    TimerSourcePath: TTimer;
    Label3AdditionalParamIndex: TLabel;
    EditAdditionalParamIndex: TEdit;
    BalloonHintMap: TBalloonHint;
    LabelEdgeSDK: TLabel;
    ButtonBackToProject: TButton;
    ButtonRunAgain: TButton;
    CheckBoxLimitNumberOfExecutionTime: TCheckBox;
    Label3: TLabel;
    NumberBoxLineExecutionCount: TNumberBox;
    crd_ClassPrefixExcludes: TCard;
    b_SelectAllClassPrefixExcluded: TButton;
    b_DeselectAllClassPrefixExcluded: TButton;
    b_DeleteSelectedClassExclusionMasks: TButton;
    MemoClassPrefixExcluded: TMemo;
    CheckBoxIncludeFileExtension: TCheckBox;
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
    procedure FormShow(Sender: TObject);
    procedure EdgeBrowserCreateWebViewCompleted(Sender: TCustomEdgeBrowser;
      AResult: HRESULT);
    procedure EdgeBrowserHistoryChanged(Sender: TCustomEdgeBrowser);
    procedure CheckBoxOpenXMLFileExternClick(Sender: TObject);
    procedure CheckBoxOpenHTMLFileExternClick(Sender: TObject);
    procedure CheckBoxOpenEMMAFileExternClick(Sender: TObject);
    procedure CheckBoxEMMA21Click(Sender: TObject);
    procedure EditAdditionalParameterChange(Sender: TObject);
    procedure CheckBoxXMLLinesClick(Sender: TObject);
    procedure CheckBoxXMLCombineMultipleClick(Sender: TObject);
    procedure CheckBoxXMLJacocoFormatClick(Sender: TObject);
    procedure CheckBoxLogToFileClick(Sender: TObject);
    procedure CheckBoxLogPerAPIClick(Sender: TObject);
    procedure CheckBoxPassThroughExitCodeClick(Sender: TObject);
    procedure CheckBoxUseApplicationWorkingDirClick(Sender: TObject);
    procedure EditCommandLineParamsChange(Sender: TObject);
    procedure ButtonSaveAsClick(Sender: TObject);
    procedure EditCodePageChange(Sender: TObject);
    procedure PMRemoveInexistingClick(Sender: TObject);
    procedure TimerSourcePathTimer(Sender: TObject);
    procedure EditAdditionalParamIndexChange(Sender: TObject);
    procedure ButtonBackToProjectClick(Sender: TObject);
    procedure CheckBoxLimitNumberOfExecutionTimeClick(Sender: TObject);
    procedure NumberBoxLineExecutionCountChangeValue(Sender: TObject);
    procedure b_SelectAllClassPrefixExcludedClick(Sender: TObject);
    procedure b_DeselectAllClassPrefixExcludedClick(Sender: TObject);
    procedure b_DeleteSelectedClassExclusionMasksClick(Sender: TObject);
    procedure MemoClassPrefixExcludedChange(Sender: TObject);
    procedure crd_ClassPrefixExcludesEnter(Sender: TObject);
    procedure CheckBoxIncludeFileExtensionClick(Sender: TObject);
  private
    /// <summary>
    ///   Manages application settings
    /// </summary>
    FSettings      : TSettings;

    /// <summary>
    ///   Manages project settings and loading/saving these from/to a file
    /// </summary>
    FProject       : IProjectSettings;

    /// <summary>
    ///   Buisiness logic for the main form
    /// </summary>
    FLogic         : TMainFormLogic;

    /// <summary>
    ///   Buffered entered new source file base path. Needed because processing
    ///   has been deferred via some timer.
    /// </summary>
    FNewSourcePath : string;

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
    ///   Fills the list of recent projects with the data from settings. Clears
    ///   the list first.
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
    /// <param name="CallResult">
    ///   Result code of the external program called 
    /// </param>
    procedure OnTestRunFinished(CallResult: UInt32);
    /// <summary>
    ///   Displays the paths used in the generated script in the memo
    /// </summary>
    procedure DisplayScriptOutputPaths;
    /// <summary>
    ///   Prepare display of all dynamic contents on the misc. settings page
    /// </summary>
    procedure PrepareScriptOutputPathDisplay;
    /// <summary>
    ///   Preinitializes the path to the code coverage command line tool with the
    ///   one shipping with this wizard.
    /// </summary>
    procedure PreInitCodeCoverageExe;
    /// <summary>
    ///   Resets all wizard fields to initial or empty values
    /// </summary>
    procedure ClearWizardFields;
    /// <summary>
    ///   Sets the value of the source path edit without automatically updating
    ///   the list of source files.
    /// </summary>
    /// <param name="ANewPath">
    ///   New value for the source path edit
    /// </param>
    procedure SetSourcePathWithoutFileList(const ANewPath: string);
    /// <summary>
    ///   Processes the command line params
    /// </summary>
    procedure ProcessCmdLineParams;
    /// <summary>
    ///   Updates enabled state of the forward/back buttons for the integrated
    //    HTML view
    /// </summary>
    procedure UpdateBrowserNavigationButtons;
    /// <summary>
    ///   Changes enabled state of the EMMA specific checkboxes (meta data and
    ///   display in external viewer) based on whether the format is enabled or not
    /// </summary>
    procedure UpdateEMMACheckBoxEnableStates;
    /// <summary>
    ///   Changes enabled state of the XML specific checkboxes (lines, display in
    ///   external viewer and combine) based on whether the format is enabled or not
    /// </summary>
    procedure UpdateXMLCheckBoxEnableStates;
    /// <summary>
    ///   Changes enabled state of the HTML specific checkboxes (display in
    ///   external viewer) based on whether the format is enabled or not
    /// </summary>
    procedure UpdateHTMLCheckBoxEnableStates;
    /// <summary>
    ///   Displays the Save and Run card of the wizard and disables the next button
    /// </summary>
    procedure DisplaySaveAndRunScreen;
    /// <summary>
    ///   Initializes the project data management instance
    /// </summary>
    procedure CreateProjectSettings;
    /// <summary>
    ///   Generates the directories, the lst files and the batch file to run
    ///   CodeCoverage.exe
    /// </summary>
    procedure GenerateDirectoriesAndBatchFile;
    /// <summary>
    ///   Adds a project to the list of recent projects, if it's not already in
    ///   that list and refreshes list display
    /// </summary>
    /// <param name="FileName">
    ///   Path and name of the file to add
    /// </param>
    procedure AddAndUpdateRecentProjects(const FileName: string);
    /// <summary>
    ///   Asks if the file list may be changed if its not empty or the source
    ///   path should be reverted to the old path and if it shall be changed
    ///   updates the file list
    /// </summary>
    /// <param name="NewSourcePath">
    ///   New source file base path
    /// </param>
    procedure DoSourcePathChange(const NewSourcePath: string);
    /// <summary>
    ///   Checks if the question about registering the DCCP file extension has
    ///   already been asked and if not asks it and adds the extension if requested
    /// </summary>
    procedure DisplayAddFileExtension;
  public
  end;

var
  FormMain: TFormMain;

implementation

uses
  System.UITypes,
  System.IOUtils,
  System.TypInfo,
  System.Threading,
  UScriptsGenerator,
  UScriptRunner,
  UManageToolsMenu,
  UUtils,
  MainFormTexts,
  AboutForm;

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

procedure TFormMain.ButtonSaveAsClick(Sender: TObject);
begin
  FileSaveDialogProject.FileName := FProject.FileName;
  if FileSaveDialogProject.Execute then
  begin
    try
      FProject.SaveToXML(FileSaveDialogProject.FileName);
      AddAndUpdateRecentProjects(FileSaveDialogProject.FileName);
      crd_SaveAndRun.Tag := cImgCompletedPage;

      GenerateDirectoriesAndBatchFile;
    except
      on e:exception do
        MessageDlg(Format(rSaveFileError,
                          [e.Message, FileSaveDialogProject.FileName]),
                   mtError, [mbOK], -1);
    end;
  end;
end;

procedure TFormMain.ButtonSaveClick(Sender: TObject);
begin
  try
    if TFile.Exists(FProject.FileName) then
    begin
      FProject.SaveToXML(FProject.FileName);
      crd_SaveAndRun.Tag := cImgCompletedPage;
      GenerateDirectoriesAndBatchFile;
    end
    else
      ButtonSaveAsClick(Sender);
  except
    on e:exception do
      MessageDlg(Format(rSaveFileError,
                        [e.Message, FProject.FileName]),
                 mtError, [mbOK], -1);
  end;
end;

procedure TFormMain.AddAndUpdateRecentProjects(const FileName: string);
begin
  FSettings.AddRecentProject(FileName);
  ListViewProjects.Items.Clear;
  DisplayRecentProjects;
end;

procedure TFormMain.GenerateDirectoriesAndBatchFile;
var
  ScriptGenerator : TScriptsGenerator;
begin
  try
    FLogic.ForceDirectories(FProject);
  except
    on e:exception do
      MessageDlg(e.Message, mtError, [mbOK], -1);
  end;

  ScriptGenerator := TScriptsGenerator.Create(FProject,
                                              FProject.FileName);
  try
    ScriptGenerator.Generate;
  finally
    ScriptGenerator.Free;
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

procedure TFormMain.b_SelectAllClassPrefixExcludedClick(Sender: TObject);
begin
  MemoClassPrefixExcluded.SelectAll;
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

procedure TFormMain.b_DeselectAllClassPrefixExcludedClick(Sender: TObject);
begin
  MemoClassPrefixExcluded.ClearSelection;
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

procedure TFormMain.b_DeleteSelectedClassExclusionMasksClick(Sender: TObject);
begin
  MemoClassPrefixExcluded.SelText := '';
end;

procedure TFormMain.ButtonAboutClick(Sender: TObject);
var
  FormAbout : TFormAbout;
begin
  FormAbout := TFormAbout.Create(self, FLogic.GetFileVersion(Application.ExeName));
  try
    FormAbout.ShowModal;
  finally
    FormAbout.Free;
  end;
end;

procedure TFormMain.ButtonBackToProjectClick(Sender: TObject);
begin
  cp_Main.ActiveCard := crd_EditSettings;
end;

procedure TFormMain.ButtonBrowserBackClick(Sender: TObject);
begin
  try
    EdgeBrowser.GoBack;
    UpdateBrowserNavigationButtons;
  except
    // going back from the first page cannot be done, but there seems no way
    // to find out if we are on the first page
  end;
end;

procedure TFormMain.ButtonBrowserNextClick(Sender: TObject);
begin
  try
    EdgeBrowser.GoForward;
    UpdateBrowserNavigationButtons;
  except
    // going back from the first page cannot be done, but there seems no way
    // to find out if we are on the first page
  end;
end;

procedure TFormMain.UpdateBrowserNavigationButtons;
begin
  ButtonBrowserNext.Enabled := EdgeBrowser.CanGoForward;
  ButtonBrowserBack.Enabled := EdgeBrowser.CanGoBack;
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
    0 : begin
          cp_Wizard.ActiveCard := crd_UnitTestExecutable;
          ButtonNext.Enabled   := FProject.IsExeAndMapDefined;
          crd_UnitTestExecutableEnter(Sender);
        end;
    1 : begin
          cp_Wizard.ActiveCard := crd_Source;
          ButtonNext.Enabled   := FProject.IsSourcePathAndFilesDefined;
          crd_SourceEnter(Sender);
        end;
    2 : begin
          cp_Wizard.ActiveCard := crd_Output;
          ButtonNext.Enabled   := FProject.IsOutputSettingsDefined;
          crd_OutputEnter(Sender);
        end;
    3 : begin
          cp_Wizard.ActiveCard := crd_MiscSettings;
          crd_MiscSettings.Tag := cImgCompletedPage;
          ButtonNext.Enabled   := true;
          PrepareScriptOutputPathDisplay;
          crd_MiscSettingsEnter(Sender);
        end;
    4 : DisplaySaveAndRunScreen;
    else
      MessageDlg(Format(rUnknownMenu, [Index]), mtError, [mbOK], -1);
  end;

  SetActiveWizardCardImageIndex(cImgActivePage);
end;

procedure TFormMain.DisplaySaveAndRunScreen;
begin
  cp_Wizard.ActiveCard := crd_SaveAndRun;
  ButtonNext.Enabled   := false;
  ButtonCancel.Enabled := false;
  ButtonSave.Enabled   := not FProject.FileName.IsEmpty;
  crd_SaveAndRunEnter(self);
end;

procedure TFormMain.ButtonHomeClick(Sender: TObject);
begin
  cp_Main.ActiveCard := crd_Start;
end;

procedure TFormMain.ButtonNewClick(Sender: TObject);
begin
  if FProject.IsAnyDataDefined then
    if MessageDlg(rClearWizard, mtConfirmation, [mbYes, mbNo], -1) = mrYes then
    begin
      ClearWizardFields;
      FProject := nil;
      CreateProjectSettings;
    end;

  cp_Main.ActiveCard        := crd_EditSettings;
  cp_Wizard.ActiveCardIndex := 0;
  ButtonPrevious.Enabled    := false;
  ButtonNext.Enabled        := true;
  ButtonPrevious.Enabled    := true;
  PreInitCodeCoverageExe;

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

    if cp_Wizard.ActiveCard = crd_MiscSettings then
      PrepareScriptOutputPathDisplay;

    SetMiscSettingsCheckIfActive;
    SetFocusToFirstProjectCardControl;
  end;
end;

procedure TFormMain.PMRemoveInexistingClick(Sender: TObject);
var
  Projects : TStrings;
begin
  Projects := FSettings.GetRecentProjects;
  try
    try
      FLogic. DeleteNonExistingRecentProjects(Projects, FSettings.DeleteRecentProject);
      DisplayRecentProjects;
    except
      on e:exception do
        MessageDlg(Format(rRemoveFailed, [e.Message]), mtError, [mbOK], -1);
    end;
  finally
    Projects.Free;
  end;
end;

procedure TFormMain.PreInitCodeCoverageExe;
var
  Path : string;
begin
  if (EditCodeCoverageExe.Text = '') then
  begin
    Path := TPath.GetDirectoryName(Application.ExeName);
    // go up 2 directories
    Path := Path.Remove(Path.LastIndexOf(TPath.DirectorySeparatorChar));
    Path := Path.Remove(Path.LastIndexOf(TPath.DirectorySeparatorChar));
    EditCodeCoverageExe.Text := TPath.Combine(Path, 'CodeCoverage.exe');
  end;
end;

procedure TFormMain.PrepareScriptOutputPathDisplay;
begin
  LabelPath.Caption := FProject.ScriptsOutputPath;
  MemoScriptPreview.Lines.Clear;
  DisplayScriptOutputPaths;
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
    AddAndUpdateRecentProjects(FileName);

    EditExeFile.Text                         := FProject.ExecutableToAnalyze;
    EditCommandLineParams.Text               := FProject.ExeCommandLineParams;
    EditMapFile.Text                         := FProject.MapFile;
    CheckBoxUseApplicationWorkingDir.Checked := FProject.UseExeDirAsWorkDir;

    OnChangeBackup              := EditSourcePath.OnChange;
    EditSourcePath.OnChange     := nil;
    try
      EditSourcePath.Text       := FProject.ProgramSourceBasePath;
    finally
      EditSourcePath.OnChange   := OnChangeBackup;
    end;
    EditCodePage.Text           := FProject.CodePage.ToString;

    EditScriptOutputFolder.Text         := FProject.ScriptsOutputPath;
    EditReportOutputFolder.Text         := FProject.ReportOutputPath;
    EditCodeCoverageExe.Text            := FProject.CodeCoverageExePath;

    CheckBoxEMMA.Checked                := ofEMMA   in FProject.OutputFormats;
    CheckBoxMeta.Checked                := ofMeta   in FProject.OutputFormats;
    CheckBoxEMMA21.Checked              := ofEMMA21 in FProject.OutputFormats;
    CheckBoxXML.Checked                 := ofXML    in FProject.OutputFormats;
    CheckBoxHTML.Checked                := ofHTML   in FProject.OutputFormats;
    CheckBoxOpenEMMAFileExtern.Checked  := FProject.DisplayEMMAFileExt;
    CheckBoxOpenXMLFileExtern.Checked   := FProject.DisplayXMLFileExt;
    CheckBoxOpenHTMLFileExtern.Checked  := FProject.DisplayHTMLFileExt;
    CheckBoxXMLLines.Checked            := FProject.AddLineNumbersToXML;
    CheckBoxXMLCombineMultiple.Checked  := FProject.CombineXMLCoverage;
    CheckBoxXMLJacocoFormat.Checked     := FProject.XMLJacocoFormat;
    CheckBoxLogToFile.Checked           := FProject.LogToTextFile;
    CheckBoxLogPerAPI.Checked           := FProject.LogToOutputDebugString;
    CheckBoxPassThroughExitCode.Checked := FProject.PassTroughExitCode;

    CheckBoxRelativePaths.Checked       := FProject.RelativeToScriptPath;
    EditAdditionalParameter.Text        := FProject.AdditionalParameter;
    EditAdditionalParamIndex.Text       := FProject.AdditionalParIndex.ToString;

    UpdateEMMACheckBoxEnableStates;
    UpdateXMLCheckBoxEnableStates;
    UpdateHTMLCheckBoxEnableStates;

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
    DisplaySaveAndRunScreen;
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

procedure TFormMain.MemoClassPrefixExcludedChange(Sender: TObject);
begin
  FProject.ExcludedClassPrefixes := MemoClassPrefixExcluded.Lines.Text;
end;

procedure TFormMain.NumberBoxLineExecutionCountChangeValue(Sender: TObject);
begin
  if Assigned(FProject) then
    FProject.NumberOfLineExecutes := (Sender as TNumberBox).ValueInt;
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

procedure TFormMain.EdgeBrowserCreateWebViewCompleted(
  Sender: TCustomEdgeBrowser; AResult: HRESULT);
begin
  if (AResult <> 0) then
    MessageDlg(Format(rHTMLDisplayErr, [UInt32(AResult)]), mtError, [mbOK], -1);
end;

procedure TFormMain.EdgeBrowserHistoryChanged(Sender: TCustomEdgeBrowser);
begin
  UpdateBrowserNavigationButtons;
end;

procedure TFormMain.EditAdditionalParameterChange(Sender: TObject);
begin
  FProject.AdditionalParameter := (Sender as TEdit).Text;
end;

procedure TFormMain.EditAdditionalParamIndexChange(Sender: TObject);
var
  Idx : Integer;
begin
  if ((Sender as TEdit).Text <> '') then
  begin
    Idx := StrToInt((Sender as TEdit).Text);

    if (Idx < 0) or (Idx > 20) then
      MessageDlg(rAddParamsIdxErr, mtError, [mbOK], -1)
    else
      FProject.AdditionalParIndex := Idx;
  end;
end;

procedure TFormMain.EditCodeCoverageExeChange(Sender: TObject);
begin
  FProject.CodeCoverageExePath := (Sender As TEdit).Text;
  DisplayExeMapInputStatus;
end;

procedure TFormMain.EditCodePageChange(Sender: TObject);
begin
  FProject.CodePage := StrToIntDef((Sender as TEdit).Text, 0);
end;

procedure TFormMain.EditCommandLineParamsChange(Sender: TObject);
begin
  FProject.ExeCommandLineParams := (Sender as TEdit).Text;
end;

procedure TFormMain.EditExeFileChange(Sender: TObject);
begin
  FProject.ExecutableToAnalyze := (Sender As TEdit).Text;
  EditMapFile.Text             := FProject.MapFile;

  if not TFile.Exists(EditMapFile.Text) then
  begin
    BalloonHintMap.Title       := rNoMapFile;
    BalloonHintMap.Description := rNoMapFileDetail;
    BalloonHintMap.ShowHint(EditMapFile);
  end;

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
begin
  FNewSourcePath := (Sender as TEdit).Text;
  TimerSourcePath.Enabled := true;
end;

procedure TFormMain.DoSourcePathChange(const NewSourcePath: string);
begin
  if (FProject.ProgramSourceFiles.Count > 0) then
  begin
    if (MessageDlg(rClearFileList, mtConfirmation,
                   [mbYes, mbNo], -1) = mrNo) then
    begin
      // restore old source path
      SetSourcePathWithoutFileList(FProject.ProgramSourceBasePath);
      exit;
    end;
  end;

  // This not only updates the base path, but the list of source files as well
  // if the new path is really different
  FProject.ProgramSourceBasePath := NewSourcePath;

  DisplaySourceFiles;
  DisplaySourceFilesStatus;
end;

procedure TFormMain.SetSourcePathWithoutFileList(const ANewPath : string);
var
  OnChange : TNotifyEvent;
begin
  OnChange := EditSourcePath.OnChange;
  try
    EditSourcePath.OnChange := nil;
    EditSourcePath.Text     := ANewPath;
  finally
    EditSourcePath.OnChange := OnChange;
  end;
end;

procedure TFormMain.TimerSourcePathTimer(Sender: TObject);
begin
  (Sender as TTimer).Enabled := false;
  DoSourcePathChange(FNewSourcePath);
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
  FLogic    := TMainFormLogic.Create;

  CreateProjectSettings;
  SetFormPos;
  DisplayRecentProjects;

  for var i := 0 to cp_Wizard.CardCount - 1 do
    cp_Wizard.Cards[i].Tag := -1;

  cp_Wizard.ActiveCardIndex := 0;
  cp_Main.ActiveCard := crd_Start;

  DisplayAddToToolsMenu;
  DisplayAddFileExtension;
end;

procedure TFormMain.CreateProjectSettings;
begin
  if Is64BitWindows then
    FProject  := TProjectSettings.Create('..\..\Coverage_x64.exe',
                                         FLogic.GetFileVersion(Application.ExeName))
  else
    FProject  := TProjectSettings.Create('..\..\Coverage.exe',
                                         FLogic.GetFileVersion(Application.ExeName));
end;

procedure TFormMain.ProcessCmdLineParams;
begin
  FLogic.ProcessCmdLineParams(
    procedure(Action: TParamAction;
              const FileName: string)
    begin
      case Action of
        paOpen : LoadProjectFile(FileName);
        paRun  : begin
                   LoadProjectFile(FileName);
                   RunScript;
                 end;
        paHelp : ButtonAbout.Click;
        else
          MessageDlg(System.TypInfo.GetEnumName(
                       TypeInfo(TParamAction), Integer(Action)),
                     mtError, [mbOK], -1);
      end;
    end,
    procedure(const FailureMessage: string)
    begin
      MessageDlg(FailureMessage, mtError, [mbOK], -1);
    end);
end;

procedure TFormMain.SetFormPos;
begin
  Position     := poDesigned;

  if (FSettings.XPos + FSettings.Width - 10) > 0 then
    Left := FSettings.XPos
  else
    Left := 0;

  if (FSettings.YPos + FSettings.Height - 10) > 0 then
    Top := FSettings.YPos
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

procedure TFormMain.DisplayAddFileExtension;
var
  FileTypeMgr : TFileTypeManager;
begin
  FileTypeMgr := TFileTypeManager.Create;

  try
    if not FileTypeMgr.HasFileTypeAssociationBeenAsked then
    begin
      if MessageDlg(rRegisterDCCP, mtConfirmation, [mbYes, mbNo], -1) = mrYes then
        try
          FLogic.RegisterFileType(Application.ExeName);
        except
          on e:Exception do
            MessageDlg(Format(rRegisterFailed, [e.Message]), mtError, [mbOK], -1);
        end;

      FileTypeMgr.HasFileTypeAssociationBeenAsked := true;
    end;
  finally
    FileTypeMgr.Free;
  end;
end;

procedure TFormMain.DisplayRecentProjects;
var
  Item : TListItem;
begin
  ListViewProjects.Items.Clear;

  ListViewProjects.Items.BeginUpdate;
  try
    for var i := 0 to FSettings.RecentProjectsCount - 1 do
    begin
      Item := ListViewProjects.Items.Add;
      Item.Caption := ExtractFilePath(FSettings.RecentProject[i]);
      Item.SubItems.Add(ExtractFileName(FSettings.RecentProject[i]));
    end;
  finally
    ListViewProjects.Items.EndUpdate;
  end;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  FSettings.Free;
  FLogic.Free;
end;

procedure TFormMain.FormShow(Sender: TObject);
begin
  ProcessCmdLineParams;
end;

procedure TFormMain.CheckBoxEMMA21Click(Sender: TObject);
begin
  OutputFormatCheckStatusChanged((Sender as TCheckBox).Checked, ofEMMA21);
  UpdateEMMACheckBoxEnableStates;
end;

procedure TFormMain.CheckBoxEMMAClick(Sender: TObject);
begin
  OutputFormatCheckStatusChanged((Sender as TCheckBox).Checked, ofEMMA);
  UpdateEMMACheckBoxEnableStates;
end;

procedure TFormMain.UpdateEMMACheckBoxEnableStates;
begin
  CheckBoxMeta.Enabled               := CheckBoxEMMA.Checked;
  CheckBoxOpenEMMAFileExtern.Enabled := CheckBoxEMMA.Checked or
                                        CheckBoxEMMA21.Checked;
end;

procedure TFormMain.UpdateXMLCheckBoxEnableStates;
begin
  CheckBoxOpenXMLFileExtern.Enabled  := CheckBoxXML.Checked;
  CheckBoxXMLLines.Enabled           := CheckBoxXML.Checked;
  CheckBoxXMLCombineMultiple.Enabled := CheckBoxXML.Checked;
  CheckBoxXMLJacocoFormat.Enabled    := CheckBoxXML.Checked;
end;

procedure TFormMain.UpdateHTMLCheckBoxEnableStates;
begin
  CheckBoxOpenHTMLFileExtern.Enabled := CheckBoxHTML.Checked;
end;

procedure TFormMain.CheckBoxHTMLClick(Sender: TObject);
begin
  OutputFormatCheckStatusChanged((Sender as TCheckBox).Checked, ofHTML);
  UpdateHTMLCheckBoxEnableStates;
end;

procedure TFormMain.CheckBoxIncludeFileExtensionClick(Sender: TObject);
begin
  FProject.IncludeFileExtension := (Sender as TCheckBox).Checked;
end;

procedure TFormMain.CheckBoxLimitNumberOfExecutionTimeClick(Sender: TObject);
begin
  FProject.UseNumberOfLineExecutes := (Sender as TCheckBox).Checked;
end;

procedure TFormMain.CheckBoxLogPerAPIClick(Sender: TObject);
begin
  FProject.LogToOutputDebugString := (Sender as TCheckBox).Checked;
end;

procedure TFormMain.CheckBoxLogToFileClick(Sender: TObject);
begin
  FProject.LogToTextFile := (Sender as TCheckBox).Checked;
end;

procedure TFormMain.CheckBoxMetaClick(Sender: TObject);
begin
  OutputFormatCheckStatusChanged((Sender as TCheckBox).Checked, ofMETA);
end;

procedure TFormMain.CheckBoxOpenEMMAFileExternClick(Sender: TObject);
begin
  FProject.DisplayEMMAFileExt := (Sender as TCheckBox).Checked;
end;

procedure TFormMain.CheckBoxOpenHTMLFileExternClick(Sender: TObject);
begin
  FProject.DisplayHTMLFileExt := (Sender as TCheckBox).Checked;
end;

procedure TFormMain.CheckBoxOpenXMLFileExternClick(Sender: TObject);
begin
  FProject.DisplayXMLFileExt := (Sender as TCheckBox).Checked;
end;

procedure TFormMain.CheckBoxPassThroughExitCodeClick(Sender: TObject);
begin
  FProject.PassTroughExitCode := (Sender as TCHeckBox).Checked;
end;

procedure TFormMain.CheckBoxRelativePathsClick(Sender: TObject);
begin
  FProject.RelativeToScriptPath := (Sender as TCheckBox).Checked;

  MemoScriptPreview.Clear;

  DisplayScriptOutputPaths;
end;

procedure TFormMain.CheckBoxUseApplicationWorkingDirClick(Sender: TObject);
begin
  FProject.UseExeDirAsWorkDir := (Sender as TCheckbox).Checked;
end;

procedure TFormMain.DisplayScriptOutputPaths;
begin
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
  UpdateXMLCheckBoxEnableStates;
end;

procedure TFormMain.CheckBoxXMLCombineMultipleClick(Sender: TObject);
begin
  FProject.CombineXMLCoverage := (Sender as TCHeckBox).Checked;
end;

procedure TFormMain.CheckBoxXMLJacocoFormatClick(Sender: TObject);
begin
  FProject.XMLJacocoFormat := (Sender as TCHeckBox).Checked;
end;

procedure TFormMain.CheckBoxXMLLinesClick(Sender: TObject);
begin
  FProject.AddLineNumbersToXML := (Sender as TCHeckBox).Checked;
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

procedure TFormMain.ClearWizardFields;
begin
  EditExeFile.Text                         := '';
  EditCommandLineParams.Text               := '';
  EditMapFile.Text                         := '';
  EditScriptOutputFolder.Text              := '';
  EditReportOutputFolder.Text              := '';
  EditAdditionalParameter.Text             := '';
  EditAdditionalParamIndex.Text            := '0';
  CheckBoxUseApplicationWorkingDir.Checked := false;
  CheckBoxEMMA.Checked                     := false;
  CheckBoxMeta.Checked                     := false;
  CheckBoxXML.Checked                      := false;
  CheckBoxHTML.Checked                     := false;
  CheckBoxEMMA21.Checked                   := false;
  CheckBoxOpenEMMAFileExtern.Checked       := false;
  CheckBoxOpenXMLFileExtern.Checked        := false;
  CheckBoxOpenHTMLFileExtern.Checked       := false;
  CheckBoxXMLLines.Checked                 := false;
  CheckBoxXMLCombineMultiple.Checked       := false;
  CheckBoxXMLJacocoFormat.Checked          := false;
  CheckBoxLogToFile.Checked                := true; // deliberately
  CheckBoxLogPerAPI.Checked                := false;
  CheckBoxPassThroughExitCode.Checked      := false;

  CheckBoxRelativePaths.Checked := false;
  CheckListBoxSource.Items.Clear;
  MemoScriptPreview.Lines.Clear;
  SetSourcePathWithoutFileList('');
  EditCodePage.Text := '';

  PreInitCodeCoverageExe;
  UpdateEMMACheckBoxEnableStates;
end;

procedure TFormMain.crd_ClassPrefixExcludesEnter(Sender: TObject);
begin
  LabelTop.Caption := rClassPrefixExcludes;
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
  begin
    ButtonNext.Enabled := true;
    crd_Output.Tag     := cImgCompletedPage;
  end
  else
  begin
    ButtonNext.Enabled := false;
    crd_Output.Tag     := -1;
  end;
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

procedure TFormMain.OnTestRunFinished(CallResult: UInt32);
var
  ErrorMessage : string;
begin
  if (CallResult = 0) then
  begin
    if ofHTML in FProject.OutputFormats then
    begin
      cp_Main.ActiveCard   := crd_Finished;

      if FLogic.DoesWebView2LoaderExist(Application.ExeName) then
      begin
        LabelEdgeSDK.Visible      := false;
        EdgeBrowser.Visible       := true;
        ButtonBrowserBack.Visible := true;
        ButtonBrowserNext.Visible := true;
        EdgeBrowser.Navigate(FProject.GetReportOutputIndexURL);
        UpdateBrowserNavigationButtons;
      end
      else
      begin
        LabelEdgeSDK.Visible      := true;
        EdgeBrowser.Visible       := false;
        ButtonBrowserBack.Visible := false;
        ButtonBrowserNext.Visible := false;
      end;

      ErrorMessage := FLogic.CallExternalViewers(Handle, FProject);

      if not ErrorMessage.IsEmpty then
        MessageDlg(ErrorMessage, mtError, [mbOK], -1);
    end
    else
      cp_Main.ActiveCard := crd_Start;
  end
  else
  begin
    ActivityIndicator.Visible := false;
    ActivityIndicator.Animate := false;
    MessageDlg(Format(rRunScriptError, [CallResult]), mtError, [mbOK], -1);
    cp_Main.ActiveCard   := crd_EditSettings;
    cp_Wizard.ActiveCard := crd_SaveAndRun;
  end;
end;

end.
