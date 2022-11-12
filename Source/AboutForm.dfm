object FormAbout: TFormAbout
  Left = 0
  Top = 0
  Caption = 'About'
  ClientHeight = 392
  ClientWidth = 479
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  DesignSize = (
    479
    392)
  TextHeight = 15
  object VirtualImage1: TVirtualImage
    Left = 16
    Top = 16
    Width = 64
    Height = 64
    ImageCollection = dm_Icons.ImageCollection
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 14
    ImageName = 'Magic-icon'
  end
  object Label1: TLabel
    Left = 96
    Top = 16
    Width = 264
    Height = 21
    Caption = 'Delphi Code Coverage Wizard Plus'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 96
    Top = 43
    Width = 38
    Height = 15
    Caption = 'Version'
  end
  object LabelVersion: TLabel
    Left = 160
    Top = 43
    Width = 66
    Height = 15
    Caption = 'LabelVersion'
  end
  object Label3: TLabel
    Left = 96
    Top = 64
    Width = 364
    Height = 15
    Caption = #169' 2022-2022 Markus Humm and Team Delphi Code Coverage Wizard'
  end
  object Label4: TLabel
    Left = 16
    Top = 110
    Width = 234
    Height = 30
    Caption = 
      'Based on the following works:'#13'Delphi Code Coverage Wizard from T' +
      'ridentT '
  end
  object Label5: TLabel
    Left = 16
    Top = 166
    Width = 271
    Height = 15
    Caption = 'and an older version of Delphi Code Coverage from'
  end
  object LabelCmdLineParams: TLabel
    Left = 16
    Top = 212
    Width = 444
    Height = 109
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 
      'Available command line parameter:'#13'-? : shows this screen'#13'-O <Fil' +
      'eName> : opens the specified project file, either a DCCP file or' +
      ' if a dpr/dproj '#13'  is specified a corresponding DCCP file, if on' +
      'e is found in the same directory'#13'- R <FileName> : opens and dire' +
      'ctly runs the specified project file, either a DCCP '#13'   file or ' +
      'if a dpr/dproj is specified a corresponding DCCP file, if one is' +
      ' found in the '#13'   same directory'
    WordWrap = True
  end
  object PanelBottom: TPanel
    Left = 0
    Top = 335
    Width = 479
    Height = 57
    Align = alBottom
    BevelEdges = [beTop]
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 212
    ExplicitWidth = 475
    object ButtonOK: TButton
      Left = 16
      Top = 8
      Width = 158
      Height = 42
      Caption = '&OK'
      Default = True
      ImageIndex = 0
      ImageName = 'Actions-dialog-ok-apply-icon'
      ImageMargins.Left = 5
      Images = VirtualImageList32
      ModalResult = 1
      TabOrder = 0
    end
  end
  object LinkLabelOldDCCWSourceforge: TLinkLabel
    Left = 16
    Top = 141
    Width = 291
    Height = 19
    Caption = 
      '<a href="https://sourceforge.net/projects/delphicodecoverage/">h' +
      'ttps://sourceforge.net/projects/delphicodecoverage/</a>'
    TabOrder = 1
    UseVisualStyle = True
    OnLinkClick = LinkLabelDCCWPGithubLinkClick
  end
  object LinkLabelDCCGithub: TLinkLabel
    Left = 16
    Top = 187
    Width = 340
    Height = 19
    Caption = 
      '<a href="https://github.com/DelphiCodeCoverage/DelphiCodeCoverag' +
      'e">https://github.com/DelphiCodeCoverage/DelphiCodeCoverage</a>'
    TabOrder = 2
    UseVisualStyle = True
    OnLinkClick = LinkLabelDCCWPGithubLinkClick
  end
  object LinkLabelDCCWPGithub: TLinkLabel
    Left = 96
    Top = 85
    Width = 348
    Height = 19
    Caption = 
      '<a href="https://github.com/MHumm/delphi-code-coverage-wizard-pl' +
      'us">https://github.com/MHumm/delphi-code-coverage-wizard-plus</a' +
      '>'
    TabOrder = 3
    UseVisualStyle = True
    OnLinkClick = LinkLabelDCCWPGithubLinkClick
  end
  object VirtualImageList32: TVirtualImageList
    Images = <
      item
        CollectionIndex = 8
        CollectionName = 'Actions-dialog-ok-apply-icon'
        Name = 'Actions-dialog-ok-apply-icon'
      end>
    ImageCollection = dm_Icons.ImageCollection
    Width = 32
    Height = 32
    Left = 408
    Top = 8
  end
end
