object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'Delphi Code Coverage Wizard'
  ClientHeight = 388
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
  OnResize = FormResize
  OnShow = FormShow
  TextHeight = 15
  object cp_Main: TCardPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 388
    Align = alClient
    ActiveCard = crd_Run
    BevelEdges = []
    BevelOuter = bvNone
    Caption = 'cp_Main'
    TabOrder = 0
    ExplicitWidth = 620
    ExplicitHeight = 387
    object crd_Start: TCard
      Left = 0
      Top = 0
      Width = 624
      Height = 388
      BevelEdges = []
      Caption = 'crd_Start'
      CardIndex = 0
      TabOrder = 0
      DesignSize = (
        624
        388)
      object Label1: TLabel
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
        Height = 290
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
        TabOrder = 4
        ViewStyle = vsReport
        OnDblClick = ListViewProjectsDblClick
        ExplicitWidth = 476
        ExplicitHeight = 289
      end
      object ButtonOpenRecent: TButton
        Left = 128
        Top = 335
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
      end
      object ButtonRunRecent: TButton
        Left = 289
        Top = 335
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
      end
      object ButtonDeleteSelected: TButton
        Left = 450
        Top = 335
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
      end
    end
    object crd_EditSettings: TCard
      Left = 0
      Top = 0
      Width = 624
      Height = 388
      BevelEdges = []
      Caption = 'crd_EditSettings'
      CardIndex = 1
      TabOrder = 1
      DesignSize = (
        624
        388)
      object cp_Wizard: TCardPanel
        Left = 200
        Top = 60
        Width = 424
        Height = 277
        Anchors = [akLeft, akTop, akRight, akBottom]
        ActiveCard = crd_SaveAndRun
        BevelEdges = [beBottom]
        Caption = 'cp_Wizard'
        TabOrder = 0
        object crd_UnitTestExecutable: TCard
          Left = 1
          Top = 1
          Width = 422
          Height = 275
          BevelEdges = []
          Caption = 'crd_UnitTestExecutable'
          CardIndex = 0
          TabOrder = 0
          OnEnter = crd_UnitTestExecutableEnter
          DesignSize = (
            422
            275)
          object Label2: TLabel
            Left = 8
            Top = 24
            Width = 212
            Height = 15
            Caption = 'Executable file of the unit test to analyze'
          end
          object Label3: TLabel
            Left = 8
            Top = 104
            Width = 179
            Height = 15
            Caption = 'Map file of the unit test to analyze'
          end
          object Label11: TLabel
            Left = 8
            Top = 176
            Width = 140
            Height = 15
            Caption = 'Path to CodeCoverage.exe'
          end
          object EditExeFile: TEdit
            Left = 8
            Top = 45
            Width = 355
            Height = 23
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 0
            OnChange = EditExeFileChange
          end
          object EditMapFile: TEdit
            Left = 8
            Top = 125
            Width = 355
            Height = 23
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 1
            OnChange = EditMapFileChange
          end
          object ButtonOpenExe: TButton
            Left = 369
            Top = 44
            Width = 50
            Height = 25
            Anchors = [akTop, akRight]
            ImageAlignment = iaCenter
            ImageIndex = 2
            ImageName = 'Actions-document-open-folder-icon'
            Images = VirtualImageListButtons16
            TabOrder = 2
            OnClick = ButtonOpenExeClick
          end
          object ButtonOpenMap: TButton
            Left = 369
            Top = 124
            Width = 50
            Height = 25
            Anchors = [akTop, akRight]
            ImageAlignment = iaCenter
            ImageIndex = 2
            ImageName = 'Actions-document-open-folder-icon'
            Images = VirtualImageListButtons16
            TabOrder = 3
            OnClick = ButtonOpenMapClick
          end
          object EditCodeCoverageExe: TEdit
            Left = 8
            Top = 197
            Width = 355
            Height = 23
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 4
            OnChange = EditCodeCoverageExeChange
          end
          object ButtonOpenCodeCoverage: TButton
            Left = 369
            Top = 196
            Width = 50
            Height = 25
            Anchors = [akTop, akRight]
            ImageAlignment = iaCenter
            ImageIndex = 2
            ImageName = 'Actions-document-open-folder-icon'
            Images = VirtualImageListButtons16
            TabOrder = 5
            OnClick = ButtonOpenCodeCoverageClick
          end
        end
        object crd_Source: TCard
          Left = 1
          Top = 1
          Width = 422
          Height = 275
          BevelEdges = []
          Caption = 'crd_Source'
          CardIndex = 1
          TabOrder = 1
          OnEnter = crd_SourceEnter
          DesignSize = (
            422
            275)
          object Label4: TLabel
            Left = 8
            Top = 16
            Width = 286
            Height = 15
            Caption = 'Directory with the source files of the project to analyze'
          end
          object Label10: TLabel
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
            Height = 134
            Anchors = [akLeft, akTop, akRight, akBottom]
            ItemHeight = 17
            TabOrder = 2
            OnClickCheck = CheckListBoxSourceClickCheck
          end
          object b_SelectAll: TButton
            Left = -1
            Top = 226
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
            ExplicitTop = 238
          end
          object b_DeselectAll: TButton
            Left = 139
            Top = 226
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
            ExplicitTop = 238
          end
          object b_RefreshSourceFiles: TButton
            Left = 280
            Top = 226
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
            ExplicitTop = 238
          end
        end
        object crd_Output: TCard
          Left = 1
          Top = 1
          Width = 422
          Height = 275
          BevelEdges = []
          Caption = 'crd_Output'
          CardIndex = 2
          TabOrder = 2
          OnEnter = crd_OutputEnter
          DesignSize = (
            422
            275)
          object Label5: TLabel
            Left = 8
            Top = 24
            Width = 350
            Height = 15
            Caption = 
              'Script output folder (files needed to execute DelphiCodeCoverage' +
              ')'
          end
          object Label6: TLabel
            Left = 8
            Top = 88
            Width = 162
            Height = 15
            Caption = 'Generated report output folder'
          end
          object Label7: TLabel
            Left = 8
            Top = 144
            Width = 82
            Height = 15
            Caption = 'Output formats'
          end
          object Bevel1: TBevel
            Left = 96
            Top = 152
            Width = 321
            Height = 1
          end
          object EditScriptOutputFolder: TEdit
            Left = 8
            Top = 45
            Width = 355
            Height = 23
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 0
            OnChange = EditScriptOutputFolderExit
            OnExit = EditScriptOutputFolderExit
          end
          object ButtonScriptOutputFolder: TButton
            Left = 369
            Top = 44
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
          end
          object EditReportOutputFolder: TEdit
            Left = 8
            Top = 109
            Width = 355
            Height = 23
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 2
            OnChange = EditReportOutputFolderExit
          end
          object ButtonReportOutputFolder: TButton
            Left = 369
            Top = 108
            Width = 50
            Height = 25
            Anchors = [akTop, akRight]
            ImageAlignment = iaCenter
            ImageIndex = 2
            ImageName = 'Actions-document-open-folder-icon'
            Images = VirtualImageListButtons16
            TabOrder = 3
            OnClick = ButtonReportOutputFolderClick
          end
          object CheckBoxEMMA: TCheckBox
            Left = 8
            Top = 168
            Width = 297
            Height = 17
            Caption = 'EMMA coverage output as '#39'coverage.es'#39'  (-emma)'
            TabOrder = 4
            OnClick = CheckBoxEMMAClick
          end
          object CheckBoxMeta: TCheckBox
            Left = 32
            Top = 200
            Width = 249
            Height = 17
            Caption = 'META data and coverage data (-meta)'
            Enabled = False
            TabOrder = 5
            OnClick = CheckBoxMetaClick
          end
          object CheckBoxXML: TCheckBox
            Left = 8
            Top = 232
            Width = 377
            Height = 17
            Caption = 'XML coverage output as '#39'CodeCoverage_Summary.xml'#39' (-xml)'
            TabOrder = 6
            OnClick = CheckBoxXMLClick
          end
          object CheckBoxHTML: TCheckBox
            Left = 8
            Top = 264
            Width = 385
            Height = 17
            Caption = 'HTML coverage output as '#39'CodeCoverage_Summary.html'#39' (-html)'
            TabOrder = 7
            OnClick = CheckBoxHTMLClick
          end
        end
        object crd_MiscSettings: TCard
          Tag = -1
          Left = 1
          Top = 1
          Width = 422
          Height = 275
          BevelEdges = []
          Caption = 'crd_MiscSettings'
          CardIndex = 3
          TabOrder = 3
          OnEnter = crd_MiscSettingsEnter
          DesignSize = (
            422
            275)
          object Label8: TLabel
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
            Top = 80
            Width = 52
            Height = 15
            Anchors = [akLeft, akTop, akRight]
            Caption = 'LabelPath'
          end
          object Label9: TLabel
            Left = 32
            Top = 104
            Width = 77
            Height = 15
            Caption = 'Script preview:'
          end
          object CheckBoxRelativePaths: TCheckBox
            Left = 8
            Top = 56
            Width = 385
            Height = 17
            Caption = 'Make all folders relative to the scripts path'
            TabOrder = 0
            OnClick = CheckBoxRelativePathsClick
          end
          object MemoScriptPreview: TMemo
            Left = 32
            Top = 125
            Width = 377
            Height = 136
            Anchors = [akLeft, akTop, akRight, akBottom]
            Enabled = False
            TabOrder = 1
            ExplicitHeight = 148
          end
        end
        object crd_SaveAndRun: TCard
          Left = 1
          Top = 1
          Width = 422
          Height = 275
          BevelEdges = []
          Caption = 'crd_SaveAndRun'
          CardIndex = 4
          TabOrder = 4
          OnEnter = crd_SaveAndRunEnter
          ExplicitHeight = 287
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
        Height = 388
        Align = alLeft
        BevelEdges = [beRight]
        TabOrder = 1
        ExplicitHeight = 400
        object ButtonGroup1: TButtonGroup
          Left = 1
          Top = 1
          Width = 198
          Height = 386
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
          ExplicitHeight = 398
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
        object LabelTop: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 47
          Height = 15
          Align = alClient
          Caption = 'LabelTop'
          WordWrap = True
        end
      end
      object PanelBottomNavigation: TPanel
        Left = 200
        Top = 337
        Width = 423
        Height = 50
        Anchors = [akLeft, akRight, akBottom]
        BevelEdges = [beTop]
        Caption = 'PanelBottomNavigation'
        ShowCaption = False
        TabOrder = 3
        ExplicitTop = 349
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
      Height = 388
      Caption = 'crd_Run'
      CardIndex = 2
      TabOrder = 2
      ExplicitWidth = 620
      ExplicitHeight = 387
      DesignSize = (
        624
        388)
      object Label12: TLabel
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
      Height = 388
      Caption = 'crd_Finished'
      CardIndex = 3
      TabOrder = 3
      DesignSize = (
        624
        388)
      object ButtonHomeAfterRun: TButton
        Left = 0
        Top = 0
        Width = 158
        Height = 42
        Hint = 'Go back to start screen'
        Caption = '&Home'
        ImageIndex = 13
        ImageName = 'Actions-go-home-icon'
        ImageMargins.Left = 5
        Images = VirtualImageListButtons32
        TabOrder = 0
        OnClick = ButtonHomeClick
      end
      object WebBrowser: TWebBrowser
        Left = 0
        Top = 48
        Width = 619
        Height = 333
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 1
        SelectedEngine = EdgeIfAvailable
        ExplicitHeight = 345
        ControlData = {
          4C000000903F0000502200000000000000000000000000000000000000000000
          000000004C000000000000000000000001000000E0D057007335CF11AE690800
          2B2E126208000000000000004C0000000114020000000000C000000000000046
          8000000000000000000000000000000000000000000000000000000000000000
          00000000000000000100000000000000000000000000000000000000}
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
        TabOrder = 2
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
        TabOrder = 3
        OnClick = ButtonBrowserNextClick
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
end
