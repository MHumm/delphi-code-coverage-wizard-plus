object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'Delphi Code Coverage Wizard'
  ClientHeight = 505
  ClientWidth = 624
  Color = clBtnFace
  Constraints.MinHeight = 426
  Constraints.MinWidth = 636
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesigned
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 15
  object cp_Main: TCardPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 505
    Align = alClient
    ActiveCard = crd_EditSettings
    BevelEdges = []
    BevelOuter = bvNone
    Caption = 'cp_Main'
    TabOrder = 0
    ExplicitHeight = 426
    object crd_Start: TCard
      Left = 0
      Top = 0
      Width = 624
      Height = 505
      BevelEdges = []
      Caption = 'crd_Start'
      CardIndex = 0
      TabOrder = 0
      ExplicitHeight = 426
      DesignSize = (
        624
        505)
      object LabelRecentProjectsCaption: TLabel
        Left = 128
        Top = 16
        Width = 84
        Height = 15
        Caption = 'Recent projects:'
      end
      object ButtonNew: TButton
        Left = 13
        Top = 16
        Width = 95
        Height = 73
        Hint = 'Create a new project'
        Caption = '&New'
        ImageAlignment = iaTop
        ImageIndex = 1
        ImageName = 'Actions-document-new-icon'
        ImageMargins.Top = 5
        Images = VirtualImageListButtons32
        TabOrder = 0
        OnClick = ButtonNewClick
      end
      object ButtonOpen: TButton
        Left = 13
        Top = 112
        Width = 95
        Height = 73
        Hint = 'Open an existing project for editing'
        Caption = '&Open'
        ImageAlignment = iaTop
        ImageIndex = 2
        ImageName = 'Actions-document-open-folder-icon'
        ImageMargins.Top = 5
        Images = VirtualImageListButtons32
        TabOrder = 1
        OnClick = ButtonOpenClick
      end
      object ButtonRun: TButton
        Left = 13
        Top = 208
        Width = 95
        Height = 73
        Hint = 'Open an existing project and run it'
        Caption = '&Run'
        ImageAlignment = iaTop
        ImageIndex = 0
        ImageName = 'Actions-arrow-right-icon'
        ImageMargins.Top = 5
        Images = VirtualImageListButtons32
        TabOrder = 2
        OnClick = ButtonRunClick
      end
      object ButtonAbout: TButton
        Left = 13
        Top = 304
        Width = 95
        Height = 73
        Hint = 'DIsplay copyright dialog'
        Caption = '&About'
        ImageAlignment = iaTop
        ImageIndex = 4
        ImageName = 'Actions-help-about-icon'
        ImageMargins.Top = 5
        Images = VirtualImageListButtons32
        TabOrder = 3
        OnClick = ButtonAboutClick
      end
      object ListViewProjects: TListView
        Left = 128
        Top = 37
        Width = 480
        Height = 407
        Anchors = [akLeft, akTop, akRight, akBottom]
        Columns = <
          item
            Caption = 'Folder'
            Width = 250
          end
          item
            Caption = 'Project'
            Width = 200
          end>
        GridLines = True
        MultiSelect = True
        ReadOnly = True
        RowSelect = True
        PopupMenu = PopupMenuRecentProjects
        TabOrder = 4
        ViewStyle = vsReport
        OnDblClick = ListViewProjectsDblClick
        ExplicitWidth = 476
        ExplicitHeight = 289
      end
      object ButtonOpenRecent: TButton
        Left = 128
        Top = 452
        Width = 158
        Height = 42
        Hint = 'Open the selected project for editing'
        Anchors = [akLeft, akBottom]
        Caption = 'O&pen selected'
        ImageIndex = 2
        ImageName = 'Actions-document-open-folder-icon'
        ImageMargins.Left = 5
        Images = VirtualImageListButtons32
        TabOrder = 5
        OnClick = ButtonOpenRecentClick
        ExplicitTop = 373
      end
      object ButtonRunRecent: TButton
        Left = 289
        Top = 452
        Width = 158
        Height = 42
        Hint = 'Open and directly run the selected project'
        Anchors = [akLeft, akBottom]
        Caption = 'R&un selected'
        ImageIndex = 0
        ImageName = 'Actions-arrow-right-icon'
        ImageMargins.Left = 5
        Images = VirtualImageListButtons32
        TabOrder = 6
        OnClick = ButtonRunRecentClick
        ExplicitTop = 373
      end
      object ButtonDeleteSelected: TButton
        Left = 450
        Top = 452
        Width = 158
        Height = 42
        Hint = 'Delete the selected project from list only'
        Anchors = [akLeft, akBottom]
        Caption = 'R&emove selected'
        ImageIndex = 5
        ImageName = 'Actions-trash-empty-icon'
        ImageMargins.Left = 5
        Images = VirtualImageListButtons32
        TabOrder = 7
        OnClick = ButtonDeleteSelectedClick
        ExplicitTop = 373
      end
    end
    object crd_EditSettings: TCard
      Left = 0
      Top = 0
      Width = 624
      Height = 505
      BevelEdges = []
      Caption = 'crd_EditSettings'
      CardIndex = 1
      TabOrder = 1
      ExplicitHeight = 426
      DesignSize = (
        624
        505)
      object cp_Wizard: TCardPanel
        Left = 200
        Top = 60
        Width = 424
        Height = 394
        Anchors = [akLeft, akTop, akRight, akBottom]
        ActiveCard = crd_UnitTestExecutable
        BevelEdges = [beBottom]
        Caption = 'cp_Wizard'
        TabOrder = 0
        ExplicitHeight = 315
        object crd_UnitTestExecutable: TCard
          Left = 1
          Top = 1
          Width = 422
          Height = 392
          BevelEdges = []
          Caption = 'crd_UnitTestExecutable'
          CardIndex = 0
          TabOrder = 0
          OnEnter = crd_UnitTestExecutableEnter
          ExplicitHeight = 313
          object ScrollBoxUnitTestExecutable: TScrollBox
            Left = 0
            Top = 0
            Width = 422
            Height = 392
            Align = alClient
            BevelInner = bvNone
            BevelOuter = bvNone
            BorderStyle = bsNone
            TabOrder = 0
            DesignSize = (
              422
              392)
            object Label2: TLabel
              Left = 8
              Top = 248
              Width = 320
              Height = 15
              Caption = 'Command line parameters passed to the program to run (-a)'
            end
            object LabelCodeCoveragePath: TLabel
              Left = 8
              Top = 176
              Width = 140
              Height = 15
              Caption = 'Path to CodeCoverage.exe'
            end
            object LabelUnitTestExe: TLabel
              Left = 8
              Top = 24
              Width = 212
              Height = 15
              Caption = 'Executable file of the unit test to analyze'
            end
            object LabelUnitTestMap: TLabel
              Left = 8
              Top = 104
              Width = 179
              Height = 15
              Caption = 'Map file of the unit test to analyze'
            end
            object ButtonOpenCodeCoverage: TButton
              Left = 351
              Top = 196
              Width = 50
              Height = 25
              Anchors = [akTop, akRight]
              ImageAlignment = iaCenter
              ImageIndex = 2
              ImageName = 'Actions-document-open-folder-icon'
              Images = VirtualImageListButtons16
              TabOrder = 0
              OnClick = ButtonOpenCodeCoverageClick
            end
            object ButtonOpenExe: TButton
              Left = 351
              Top = 44
              Width = 50
              Height = 25
              Anchors = [akTop, akRight]
              ImageAlignment = iaCenter
              ImageIndex = 2
              ImageName = 'Actions-document-open-folder-icon'
              Images = VirtualImageListButtons16
              TabOrder = 1
              OnClick = ButtonOpenExeClick
            end
            object ButtonOpenMap: TButton
              Left = 351
              Top = 124
              Width = 50
              Height = 25
              Anchors = [akTop, akRight]
              ImageAlignment = iaCenter
              ImageIndex = 2
              ImageName = 'Actions-document-open-folder-icon'
              Images = VirtualImageListButtons16
              TabOrder = 2
              OnClick = ButtonOpenMapClick
            end
            object CheckBoxUseApplicationWorkingDir: TCheckBox
              Left = 8
              Top = 320
              Width = 385
              Height = 17
              Caption = 'Use unit test application directory as working directory (-twd)'
              TabOrder = 3
              OnClick = CheckBoxUseApplicationWorkingDirClick
            end
            object EditCodeCoverageExe: TEdit
              Left = 8
              Top = 197
              Width = 334
              Height = 23
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 4
              OnChange = EditCodeCoverageExeChange
            end
            object EditCommandLineParams: TEdit
              Left = 8
              Top = 269
              Width = 393
              Height = 23
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 5
              OnChange = EditCommandLineParamsChange
            end
            object EditExeFile: TEdit
              Left = 8
              Top = 45
              Width = 334
              Height = 23
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 6
              OnChange = EditExeFileChange
            end
            object EditMapFile: TEdit
              Left = 8
              Top = 125
              Width = 334
              Height = 23
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 7
              OnChange = EditMapFileChange
            end
          end
        end
        object crd_Source: TCard
          Left = 1
          Top = 1
          Width = 422
          Height = 392
          BevelEdges = []
          Caption = 'crd_Source'
          CardIndex = 1
          TabOrder = 1
          OnEnter = crd_SourceEnter
          ExplicitHeight = 313
          DesignSize = (
            422
            392)
          object LabelSourceFilesPath: TLabel
            Left = 8
            Top = 16
            Width = 286
            Height = 15
            Caption = 'Directory with the source files of the project to analyze'
          end
          object LabelSourceFilesCaption: TLabel
            Left = 8
            Top = 67
            Width = 116
            Height = 15
            Caption = 'Source files to analyze'
          end
          object EditSourcePath: TEdit
            Left = 8
            Top = 37
            Width = 350
            Height = 23
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 0
            OnChange = EditSourcePathChange
          end
          object ButtonSourcePath: TButton
            Left = 364
            Top = 36
            Width = 50
            Height = 25
            Anchors = [akTop, akRight]
            ImageAlignment = iaCenter
            ImageIndex = 2
            ImageName = 'Actions-document-open-folder-icon'
            Images = VirtualImageListButtons16
            TabOrder = 1
            OnClick = ButtonSourcePathClick
          end
          object CheckListBoxSource: TCheckListBox
            Left = 8
            Top = 88
            Width = 404
            Height = 251
            Anchors = [akLeft, akTop, akRight, akBottom]
            ItemHeight = 17
            TabOrder = 2
            OnClickCheck = CheckListBoxSourceClickCheck
            ExplicitHeight = 172
          end
          object b_SelectAll: TButton
            Left = -1
            Top = 343
            Width = 138
            Height = 42
            Hint = 'Select all source files'
            Anchors = [akLeft, akBottom]
            Caption = 'Select &all'
            ImageIndex = 11
            ImageName = 'Actions-edit-select-all-icon'
            ImageMargins.Left = 5
            Images = VirtualImageListButtons32
            TabOrder = 3
            OnClick = b_SelectAllClick
            ExplicitTop = 264
          end
          object b_DeselectAll: TButton
            Left = 139
            Top = 343
            Width = 138
            Height = 42
            Hint = 'deselect all source files'
            Anchors = [akLeft, akBottom]
            Caption = '&Deselect all'
            ImageIndex = 10
            ImageName = 'Actions-edit-clear-list-icon'
            ImageMargins.Left = 5
            Images = VirtualImageListButtons32
            TabOrder = 4
            OnClick = b_DeselectAllClick
            ExplicitTop = 264
          end
          object b_RefreshSourceFiles: TButton
            Left = 280
            Top = 343
            Width = 138
            Height = 42
            Hint = 'Refresh file list'
            Anchors = [akLeft, akBottom]
            Caption = '&Refresh'
            ImageIndex = 12
            ImageName = 'Actions-view-refresh-icon'
            ImageMargins.Left = 5
            Images = VirtualImageListButtons32
            TabOrder = 5
            OnClick = b_RefreshSourceFilesClick
            ExplicitTop = 264
          end
        end
        object crd_Output: TCard
          Left = 1
          Top = 1
          Width = 422
          Height = 392
          BevelEdges = []
          Caption = 'crd_Output'
          CardIndex = 2
          TabOrder = 2
          OnEnter = crd_OutputEnter
          ExplicitHeight = 313
          object ScrollBoxOutputSettings: TScrollBox
            Left = 0
            Top = 0
            Width = 422
            Height = 392
            HorzScrollBar.Visible = False
            Align = alClient
            BevelInner = bvNone
            BevelOuter = bvNone
            BorderStyle = bsNone
            TabOrder = 0
            ExplicitHeight = 313
            DesignSize = (
              405
              392)
            object Bevel1: TBevel
              Left = 93
              Top = 133
              Width = 321
              Height = 1
            end
            object LabelOutputFormatsCaption: TLabel
              Left = 5
              Top = 125
              Width = 82
              Height = 15
              Caption = 'Output formats'
            end
            object LabelReportOutputPath: TLabel
              Left = 5
              Top = 69
              Width = 317
              Height = 15
              Caption = 'Save generated reports (HTML, XML, EMMA...) to this folder:'
            end
            object LabelScriptOutputPath: TLabel
              Left = 5
              Top = 5
              Width = 350
              Height = 15
              Caption = 'Batch output folder (files needed to execute DelphiCodeCoverage)'
            end
            object ButtonReportOutputFolder: TButton
              Left = 333
              Top = 89
              Width = 50
              Height = 25
              Anchors = [akTop, akRight]
              ImageAlignment = iaCenter
              ImageIndex = 2
              ImageName = 'Actions-document-open-folder-icon'
              Images = VirtualImageListButtons16
              TabOrder = 0
              OnClick = ButtonReportOutputFolderClick
              ExplicitLeft = 329
            end
            object ButtonScriptOutputFolder: TButton
              Left = 333
              Top = 25
              Width = 50
              Height = 25
              Anchors = [akTop, akRight]
              ImageAlignment = iaCenter
              ImageIndex = 2
              ImageName = 'Actions-document-open-folder-icon'
              Images = VirtualImageListButtons16
              TabOrder = 1
              OnClick = ButtonScriptOutputFolderClick
              OnExit = ButtonScriptOutputFolderExit
              ExplicitLeft = 329
            end
            object CheckBoxEMMA: TCheckBox
              Left = 8
              Top = 148
              Width = 297
              Height = 17
              Caption = 'EMMA coverage output as '#39'coverage.es'#39'  (-emma)'
              TabOrder = 2
              OnClick = CheckBoxEMMAClick
            end
            object CheckBoxHTML: TCheckBox
              Left = 8
              Top = 436
              Width = 385
              Height = 17
              Caption = 'HTML coverage output as '#39'CodeCoverage_Summary.html'#39' (-html)'
              TabOrder = 3
              OnClick = CheckBoxHTMLClick
            end
            object CheckBoxMeta: TCheckBox
              Left = 29
              Top = 180
              Width = 249
              Height = 17
              Caption = 'META data and coverage data (-meta)'
              Enabled = False
              TabOrder = 4
              OnClick = CheckBoxMetaClick
            end
            object CheckBoxXML: TCheckBox
              Left = 8
              Top = 276
              Width = 377
              Height = 17
              Caption = 'XML coverage output as '#39'CodeCoverage_Summary.xml'#39' (-xml)'
              TabOrder = 5
              OnClick = CheckBoxXMLClick
            end
            object EditReportOutputFolder: TEdit
              Left = 5
              Top = 90
              Width = 322
              Height = 23
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 6
              OnChange = EditReportOutputFolderExit
              ExplicitWidth = 318
            end
            object EditScriptOutputFolder: TEdit
              Left = 5
              Top = 26
              Width = 322
              Height = 23
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 7
              OnChange = EditScriptOutputFolderExit
              OnExit = EditScriptOutputFolderExit
              ExplicitWidth = 318
            end
            object CheckBoxEMMA21: TCheckBox
              Left = 8
              Top = 212
              Width = 393
              Height = 17
              Caption = 'EMMA 2.1 coverage output as '#39'coverage.es'#39'  (-emma21)'
              TabOrder = 8
              OnClick = CheckBoxEMMA21Click
            end
            object CheckBoxOpenEMMAFileExtern: TCheckBox
              Left = 8
              Top = 244
              Width = 385
              Height = 17
              Caption = 
                'Open generated EMMA file with assiciated application (ShellExecu' +
                'te)'
              Enabled = False
              TabOrder = 9
              OnClick = CheckBoxOpenEMMAFileExternClick
            end
            object CheckBoxOpenXMLFileExtern: TCheckBox
              Left = 24
              Top = 308
              Width = 385
              Height = 17
              Caption = 
                'Open generated XML file with assiciated application (ShellExecut' +
                'e)'
              Enabled = False
              TabOrder = 10
              OnClick = CheckBoxOpenXMLFileExternClick
            end
            object CheckBoxOpenHTMLFileExtern: TCheckBox
              Left = 24
              Top = 468
              Width = 385
              Height = 17
              Caption = 
                'Open generated HTML file with assiciated application (ShellExecu' +
                'te)'
              Enabled = False
              TabOrder = 11
              OnClick = CheckBoxOpenHTMLFileExternClick
            end
            object CheckBoxXMLLines: TCheckBox
              Left = 24
              Top = 340
              Width = 385
              Height = 17
              Caption = 'Add source code line information to generated XML file (-lcl)'
              Enabled = False
              TabOrder = 12
              OnClick = CheckBoxXMLLinesClick
            end
            object CheckBoxXMLCombineMultiple: TCheckBox
              Left = 24
              Top = 372
              Width = 393
              Height = 17
              Caption = 
                'XML: combine multiple occurances of the same file (esp. for gene' +
                'rics)'
              Enabled = False
              TabOrder = 13
              OnClick = CheckBoxXMLCombineMultipleClick
            end
            object CheckBoxXMLJacocoFormat: TCheckBox
              Left = 24
              Top = 404
              Width = 393
              Height = 17
              Caption = 'XML: output in Jacoco format (-jacoco)'
              Enabled = False
              TabOrder = 14
              OnClick = CheckBoxXMLJacocoFormatClick
            end
          end
        end
        object crd_MiscSettings: TCard
          Tag = -1
          Left = 1
          Top = 1
          Width = 422
          Height = 392
          BevelEdges = []
          Caption = 'crd_MiscSettings'
          CardIndex = 3
          TabOrder = 3
          OnEnter = crd_MiscSettingsEnter
          ExplicitHeight = 313
          object ScrollBoxMisc: TScrollBox
            Left = 0
            Top = 0
            Width = 422
            Height = 392
            Align = alClient
            TabOrder = 0
            ExplicitHeight = 313
            DesignSize = (
              418
              388)
            object LabelAdditioalParams: TLabel
              Left = 8
              Top = 48
              Width = 117
              Height = 15
              Caption = 'Additional parameters'
            end
            object LabelMiscSettingsNote: TLabel
              Left = 8
              Top = 16
              Width = 396
              Height = 15
              Caption = 
                'Note: Be sure to have '#39'CodeCoverage.exe'#39' in your path or in the ' +
                'script path.'
            end
            object LabelPath: TLabel
              Left = 32
              Top = 104
              Width = 48
              Height = 15
              Anchors = [akLeft, akTop, akRight]
              Caption = 'LabelPath'
              ExplicitWidth = 52
            end
            object LabelScriptPreviewCaption: TLabel
              Left = 32
              Top = 128
              Width = 109
              Height = 15
              Caption = 'Script paths preview:'
            end
            object Label1: TLabel
              Left = 8
              Top = 272
              Width = 103
              Height = 15
              Caption = 'Log output formats'
            end
            object CheckBoxRelativePaths: TCheckBox
              Left = 8
              Top = 80
              Width = 385
              Height = 17
              Caption = 'Make all folders relative to the scripts path'
              TabOrder = 0
              OnClick = CheckBoxRelativePathsClick
            end
            object EditAdditionalParameter: TEdit
              Left = 139
              Top = 46
              Width = 245
              Height = 23
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 1
              OnChange = EditAdditionalParameterChange
            end
            object MemoScriptPreview: TMemo
              Left = 32
              Top = 149
              Width = 352
              Height = 110
              Anchors = [akLeft, akTop, akRight]
              Enabled = False
              TabOrder = 2
            end
            object CheckBoxLogToFile: TCheckBox
              Left = 8
              Top = 298
              Width = 393
              Height = 17
              Caption = 'Save log messages to file in report output folder (-lt)'
              Checked = True
              State = cbChecked
              TabOrder = 3
              OnClick = CheckBoxLogToFileClick
            end
            object CheckBoxLogPerAPI: TCheckBox
              Left = 8
              Top = 330
              Width = 393
              Height = 17
              Caption = 'Write log messages via OutputDebugString Windows API (-lapi)'
              TabOrder = 4
              OnClick = CheckBoxLogPerAPIClick
            end
            object CheckBoxPassThroughExitCode: TCheckBox
              Left = 8
              Top = 362
              Width = 393
              Height = 17
              Caption = 'Pass trough exit code of called application (-tec)'
              TabOrder = 5
              OnClick = CheckBoxPassThroughExitCodeClick
            end
          end
        end
        object crd_SaveAndRun: TCard
          Left = 1
          Top = 1
          Width = 422
          Height = 392
          BevelEdges = []
          Caption = 'crd_SaveAndRun'
          CardIndex = 4
          TabOrder = 4
          OnEnter = crd_SaveAndRunEnter
          ExplicitHeight = 313
          object ButtonSave: TButton
            Left = 16
            Top = 16
            Width = 95
            Height = 73
            Hint = 'Open an existing project for editing'
            Caption = '&Save && generate'
            ImageAlignment = iaTop
            ImageIndex = 3
            ImageName = 'Actions-document-save-icon'
            ImageMargins.Top = 5
            Images = VirtualImageListButtons32
            TabOrder = 0
            OnClick = ButtonSaveClick
          end
          object ButtonWizardRun: TButton
            Left = 16
            Top = 105
            Width = 95
            Height = 73
            Hint = 'Open an existing project and run it'
            Caption = '&Run'
            ImageAlignment = iaTop
            ImageIndex = 0
            ImageName = 'Actions-arrow-right-icon'
            ImageMargins.Top = 5
            Images = VirtualImageListButtons32
            TabOrder = 1
            OnClick = ButtonWizardRunClick
          end
          object ButtonHome: TButton
            Left = 16
            Top = 194
            Width = 95
            Height = 73
            Hint = 'Go back to main/start screen'
            Caption = '&Home'
            ImageAlignment = iaTop
            ImageIndex = 13
            ImageName = 'Actions-go-home-icon'
            ImageMargins.Top = 5
            Images = VirtualImageListButtons32
            TabOrder = 2
            OnClick = ButtonHomeClick
          end
        end
      end
      object p_WizardNavigation: TPanel
        Left = 0
        Top = 0
        Width = 200
        Height = 505
        Align = alLeft
        BevelEdges = [beRight]
        TabOrder = 1
        ExplicitHeight = 425
        object ButtonGroup1: TButtonGroup
          Left = 1
          Top = 1
          Width = 198
          Height = 503
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          ButtonOptions = [gboFullSize, gboShowCaptions]
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          Images = VirtualImageListButtons16
          Items = <
            item
              Caption = 'Unit test executable'
              ImageIndex = 7
              ImageName = 'Actions-go-next-view-icon'
            end
            item
              Caption = 'Source'
            end
            item
              Caption = 'Output folders/formats'
            end
            item
              Caption = 'Misc. settings'
            end
            item
              Caption = 'Save and run'
            end>
          TabOrder = 0
          TabStop = False
          OnButtonClicked = ButtonGroup1ButtonClicked
          ExplicitHeight = 423
        end
      end
      object PanelHeader: TPanel
        Left = 200
        Top = 0
        Width = 424
        Height = 60
        Anchors = [akLeft, akTop, akRight]
        BevelEdges = [beBottom]
        Caption = 'PanelHeader'
        Color = clBtnHighlight
        ParentBackground = False
        ShowCaption = False
        TabOrder = 2
        StyleElements = [seFont, seBorder]
        ExplicitWidth = 420
        object LabelTop: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 416
          Height = 52
          Align = alClient
          Caption = 'LabelTop'
          WordWrap = True
          ExplicitWidth = 47
          ExplicitHeight = 15
        end
      end
      object PanelBottomNavigation: TPanel
        Left = 200
        Top = 454
        Width = 423
        Height = 50
        Anchors = [akLeft, akRight, akBottom]
        BevelEdges = [beTop]
        Caption = 'PanelBottomNavigation'
        ShowCaption = False
        TabOrder = 3
        ExplicitTop = 374
        ExplicitWidth = 419
        object ButtonPrevious: TButton
          Left = 0
          Top = 5
          Width = 138
          Height = 42
          Hint = 'go to previous page'
          Caption = '&Previous'
          ImageIndex = 6
          ImageName = 'Actions-go-previous-view-icon'
          ImageMargins.Left = 5
          Images = VirtualImageListButtons32
          TabOrder = 0
          OnClick = ButtonPreviousClick
        end
        object ButtonNext: TButton
          Left = 140
          Top = 5
          Width = 138
          Height = 42
          Hint = 'go to next page'
          Caption = '&Next'
          ImageIndex = 7
          ImageName = 'Actions-go-next-view-icon'
          ImageMargins.Left = 5
          Images = VirtualImageListButtons32
          TabOrder = 1
          OnClick = ButtonNextClick
        end
        object ButtonCancel: TButton
          Left = 280
          Top = 5
          Width = 138
          Height = 42
          Hint = 'go back to main screen'
          Caption = '&Cancel'
          ImageIndex = 9
          ImageName = 'Actions-edit-delete-icon'
          ImageMargins.Left = 5
          Images = VirtualImageListButtons32
          TabOrder = 2
          OnClick = ButtonCancelClick
        end
      end
    end
    object crd_Run: TCard
      Left = 0
      Top = 0
      Width = 624
      Height = 505
      Caption = 'crd_Run'
      CardIndex = 2
      TabOrder = 2
      ExplicitHeight = 426
      DesignSize = (
        624
        505)
      object LabelRunDescription: TLabel
        Left = 24
        Top = 8
        Width = 573
        Height = 33
        Alignment = taCenter
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Caption = 
          'Starting the coverage run. If you use a GUI test runner run the ' +
          'tests from its GUI and close it afterwards.  If you use a consol' +
          'e test runner you might have to hit enter when tests are finishe' +
          'd.'
        WordWrap = True
        ExplicitWidth = 569
      end
      object ActivityIndicator: TActivityIndicator
        Left = 256
        Top = 120
        IndicatorSize = aisXLarge
      end
    end
    object crd_Finished: TCard
      Left = 0
      Top = 0
      Width = 624
      Height = 505
      Caption = 'crd_Finished'
      CardIndex = 3
      TabOrder = 3
      ExplicitHeight = 426
      DesignSize = (
        624
        505)
      object ButtonHomeAfterRun: TButton
        Left = 0
        Top = 0
        Width = 158
        Height = 42
        Hint = 'Go back to start screen of the application'
        Caption = '&Home'
        ImageIndex = 13
        ImageName = 'Actions-go-home-icon'
        ImageMargins.Left = 5
        Images = VirtualImageListButtons32
        TabOrder = 0
        OnClick = ButtonHomeClick
      end
      object ButtonBrowserBack: TButton
        Left = 160
        Top = 0
        Width = 138
        Height = 42
        Hint = 'go to previous page'
        Caption = '&Back'
        ImageIndex = 6
        ImageName = 'Actions-go-previous-view-icon'
        ImageMargins.Left = 5
        Images = VirtualImageListButtons32
        TabOrder = 1
        OnClick = ButtonBrowserBackClick
      end
      object ButtonBrowserNext: TButton
        Left = 300
        Top = 0
        Width = 138
        Height = 42
        Hint = 'go to next page'
        Caption = '&Next'
        ImageIndex = 7
        ImageName = 'Actions-go-next-view-icon'
        ImageMargins.Left = 5
        Images = VirtualImageListButtons32
        TabOrder = 2
        OnClick = ButtonBrowserNextClick
      end
      object EdgeBrowser: TEdgeBrowser
        Left = 0
        Top = 48
        Width = 617
        Height = 457
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 3
        UserDataFolder = '%LOCALAPPDATA%\bds.exe.WebView2'
        OnCreateWebViewCompleted = EdgeBrowserCreateWebViewCompleted
        OnHistoryChanged = EdgeBrowserHistoryChanged
        ExplicitHeight = 378
      end
    end
  end
  object VirtualImageListButtons32: TVirtualImageList
    AutoFill = True
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'Actions-arrow-right-icon'
        Name = 'Actions-arrow-right-icon'
      end
      item
        CollectionIndex = 1
        CollectionName = 'Actions-document-new-icon'
        Name = 'Actions-document-new-icon'
      end
      item
        CollectionIndex = 2
        CollectionName = 'Actions-document-open-folder-icon'
        Name = 'Actions-document-open-folder-icon'
      end
      item
        CollectionIndex = 3
        CollectionName = 'Actions-document-save-icon'
        Name = 'Actions-document-save-icon'
      end
      item
        CollectionIndex = 4
        CollectionName = 'Actions-help-about-icon'
        Name = 'Actions-help-about-icon'
      end
      item
        CollectionIndex = 5
        CollectionName = 'Actions-trash-empty-icon'
        Name = 'Actions-trash-empty-icon'
      end
      item
        CollectionIndex = 6
        CollectionName = 'Actions-go-previous-view-icon'
        Name = 'Actions-go-previous-view-icon'
      end
      item
        CollectionIndex = 7
        CollectionName = 'Actions-go-next-view-icon'
        Name = 'Actions-go-next-view-icon'
      end
      item
        CollectionIndex = 8
        CollectionName = 'Actions-dialog-ok-apply-icon'
        Name = 'Actions-dialog-ok-apply-icon'
      end
      item
        CollectionIndex = 9
        CollectionName = 'Actions-edit-delete-icon'
        Name = 'Actions-edit-delete-icon'
      end
      item
        CollectionIndex = 10
        CollectionName = 'Actions-edit-clear-list-icon'
        Name = 'Actions-edit-clear-list-icon'
      end
      item
        CollectionIndex = 11
        CollectionName = 'Actions-edit-select-all-icon'
        Name = 'Actions-edit-select-all-icon'
      end
      item
        CollectionIndex = 12
        CollectionName = 'Actions-view-refresh-icon'
        Name = 'Actions-view-refresh-icon'
      end
      item
        CollectionIndex = 13
        CollectionName = 'Actions-go-home-icon'
        Name = 'Actions-go-home-icon'
      end
      item
        CollectionIndex = 14
        CollectionName = 'Magic-icon'
        Name = 'Magic-icon'
      end>
    ImageCollection = dm_Icons.ImageCollection
    Width = 32
    Height = 32
    Left = 521
    Top = 105
  end
  object VirtualImageListButtons16: TVirtualImageList
    AutoFill = True
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'Actions-arrow-right-icon'
        Name = 'Actions-arrow-right-icon'
      end
      item
        CollectionIndex = 1
        CollectionName = 'Actions-document-new-icon'
        Name = 'Actions-document-new-icon'
      end
      item
        CollectionIndex = 2
        CollectionName = 'Actions-document-open-folder-icon'
        Name = 'Actions-document-open-folder-icon'
      end
      item
        CollectionIndex = 3
        CollectionName = 'Actions-document-save-icon'
        Name = 'Actions-document-save-icon'
      end
      item
        CollectionIndex = 4
        CollectionName = 'Actions-help-about-icon'
        Name = 'Actions-help-about-icon'
      end
      item
        CollectionIndex = 5
        CollectionName = 'Actions-trash-empty-icon'
        Name = 'Actions-trash-empty-icon'
      end
      item
        CollectionIndex = 6
        CollectionName = 'Actions-go-previous-view-icon'
        Name = 'Actions-go-previous-view-icon'
      end
      item
        CollectionIndex = 7
        CollectionName = 'Actions-go-next-view-icon'
        Name = 'Actions-go-next-view-icon'
      end
      item
        CollectionIndex = 8
        CollectionName = 'Actions-dialog-ok-apply-icon'
        Name = 'Actions-dialog-ok-apply-icon'
      end
      item
        CollectionIndex = 9
        CollectionName = 'Actions-edit-delete-icon'
        Name = 'Actions-edit-delete-icon'
      end
      item
        CollectionIndex = 10
        CollectionName = 'Actions-edit-clear-list-icon'
        Name = 'Actions-edit-clear-list-icon'
      end
      item
        CollectionIndex = 11
        CollectionName = 'Actions-edit-select-all-icon'
        Name = 'Actions-edit-select-all-icon'
      end
      item
        CollectionIndex = 12
        CollectionName = 'Actions-view-refresh-icon'
        Name = 'Actions-view-refresh-icon'
      end
      item
        CollectionIndex = 13
        CollectionName = 'Actions-go-home-icon'
        Name = 'Actions-go-home-icon'
      end
      item
        CollectionIndex = 14
        CollectionName = 'Magic-icon'
        Name = 'Magic-icon'
      end>
    ImageCollection = dm_Icons.ImageCollection
    Left = 362
    Top = 102
  end
  object FileOpenDialogProject: TFileOpenDialog
    ClientGuid = '{7CE6B840-18A0-43F6-A6AB-F59FF4579DF5}'
    DefaultExtension = 'dccp'
    FavoriteLinks = <>
    FileTypes = <
      item
        DisplayName = 'Code Coverage Project'
        FileMask = '*.dccp'
      end
      item
        DisplayName = 'Any file'
        FileMask = '*.*'
      end>
    Options = [fdoForceFileSystem, fdoPathMustExist, fdoFileMustExist, fdoDefaultNoMiniMode]
    Title = 'Open project file'
    Left = 514
    Top = 166
  end
  object FileOpenDialogExe: TFileOpenDialog
    ClientGuid = '{53C1B7FC-8A54-49CA-8946-99B559C62E74}'
    DefaultExtension = 'exe'
    FavoriteLinks = <>
    FileTypes = <
      item
        DisplayName = 'exe-file'
        FileMask = '*.exe'
      end
      item
        DisplayName = 'Any file'
        FileMask = '*.*'
      end>
    Options = [fdoForceFileSystem, fdoPathMustExist, fdoFileMustExist, fdoDefaultNoMiniMode]
    Title = 'Open exe file'
    Left = 514
    Top = 238
  end
  object FileOpenDialogMap: TFileOpenDialog
    ClientGuid = '{11FCF516-00EC-49D1-8D69-AD876C585AED}'
    DefaultExtension = 'map'
    FavoriteLinks = <>
    FileTypes = <
      item
        DisplayName = 'map-file'
        FileMask = '*.map'
      end
      item
        DisplayName = 'Any file'
        FileMask = '*.*'
      end>
    Options = [fdoForceFileSystem, fdoPathMustExist, fdoFileMustExist, fdoDefaultNoMiniMode]
    Title = 'Open map file'
    Left = 514
    Top = 302
  end
  object FileSaveDialogProject: TFileSaveDialog
    ClientGuid = '{D4C82868-4372-4AF7-B23C-AA2147088B02}'
    DefaultExtension = 'dccp'
    FavoriteLinks = <>
    FileTypes = <
      item
        DisplayName = 'Code Coverage Project'
        FileMask = '*.dccp'
      end
      item
        DisplayName = 'Any file'
        FileMask = '*.*'
      end>
    Options = [fdoOverWritePrompt, fdoStrictFileTypes, fdoPathMustExist, fdoNoReadOnlyReturn]
    Title = 'Save project file'
    Left = 362
    Top = 166
  end
  object FolderOpenDialog: TFileOpenDialog
    ClientGuid = '{EA689EAF-934E-41F9-8CF6-3BE0C8648EB0}'
    FavoriteLinks = <>
    FileTypes = <>
    Options = [fdoPickFolders, fdoForceFileSystem, fdoPathMustExist, fdoDefaultNoMiniMode]
    Title = 'Select script output folder'
    Left = 362
    Top = 238
  end
  object FileOpenDialogCoverage: TFileOpenDialog
    ClientGuid = '{787FAD3A-66A0-4C1A-BD46-FBCA0FA446E9}'
    DefaultExtension = 'exe'
    FavoriteLinks = <>
    FileTypes = <
      item
        DisplayName = 'exe-file'
        FileMask = '*.exe'
      end
      item
        DisplayName = 'Any file'
        FileMask = '*.*'
      end>
    Options = [fdoForceFileSystem, fdoPathMustExist, fdoFileMustExist, fdoDefaultNoMiniMode]
    Title = 'Open code coverage exe file'
    Left = 362
    Top = 302
  end
  object FolderOpenDialogReport: TFileOpenDialog
    ClientGuid = '{403887D8-A7D6-4769-A2DA-3B8BC335A0F0}'
    FavoriteLinks = <>
    FileTypes = <>
    Options = [fdoPickFolders, fdoForceFileSystem, fdoPathMustExist, fdoDefaultNoMiniMode]
    Title = 'Select report output folder'
    Left = 234
    Top = 238
  end
  object FolderOpenDialogSource: TFileOpenDialog
    ClientGuid = '{89FA4B6D-7CA3-45CA-8D29-39F68E8E1E04}'
    FavoriteLinks = <>
    FileTypes = <>
    Options = [fdoPickFolders, fdoForceFileSystem, fdoPathMustExist, fdoDefaultNoMiniMode]
    Title = 'Select source code folder'
    Left = 82
    Top = 238
  end
  object PopupMenuRecentProjects: TPopupMenu
    Images = VirtualImageListButtons16
    Left = 184
    Top = 104
    object PMOpenSelected: TMenuItem
      Caption = 'Open selected'
      ImageIndex = 2
      ImageName = 'Actions-document-open-folder-icon'
      OnClick = ButtonOpenRecentClick
    end
    object PMRunselected: TMenuItem
      Caption = 'Run selected'
      ImageIndex = 0
      ImageName = 'Actions-arrow-right-icon'
      OnClick = ButtonRunRecentClick
    end
    object PMRemoveselected: TMenuItem
      Caption = 'Remove selected'
      ImageIndex = 5
      ImageName = 'Actions-trash-empty-icon'
      OnClick = ButtonDeleteSelectedClick
    end
  end
end
