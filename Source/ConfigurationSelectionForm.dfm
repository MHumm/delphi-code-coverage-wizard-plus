object ConfigSelectionForm: TConfigSelectionForm
  Left = 0
  Top = 0
  Caption = 'Which IDEs shall contain this in Tools menu?'
  ClientHeight = 238
  ClientWidth = 516
  Color = clBtnFace
  Constraints.MinHeight = 220
  Constraints.MinWidth = 532
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnDestroy = FormDestroy
  DesignSize = (
    516
    238)
  TextHeight = 15
  object LabelDescription: TLabel
    Left = 8
    Top = 8
    Width = 488
    Height = 33
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 
      'Select the IDEs/configurations in which %0:s shall be available ' +
      'in "Tools" menu'
    WordWrap = True
    ExplicitWidth = 500
  end
  object ListViewConfigurations: TListView
    Left = 8
    Top = 55
    Width = 490
    Height = 135
    Anchors = [akLeft, akTop, akRight, akBottom]
    Checkboxes = True
    Columns = <
      item
        Caption = 'Rad Studio version'
        Width = 200
      end
      item
        Caption = 'Configuration name'
        Width = 150
      end>
    ColumnClick = False
    GridLines = True
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    ExplicitWidth = 494
  end
  object ButtonOK: TButton
    Left = 8
    Top = 201
    Width = 121
    Height = 32
    Anchors = [akLeft, akBottom]
    Caption = '&Ok'
    ImageIndex = 0
    ImageName = 'Actions-dialog-ok-apply-icon'
    ImageMargins.Left = 5
    Images = VirtualImageListButtons
    ModalResult = 1
    TabOrder = 1
    OnClick = ButtonOKClick
  end
  object ButtonCancel: TButton
    Left = 135
    Top = 201
    Width = 121
    Height = 32
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = '&Cancel'
    ImageIndex = 1
    ImageName = 'Actions-edit-delete-icon'
    ImageMargins.Left = 5
    Images = VirtualImageListButtons
    ModalResult = 2
    TabOrder = 2
  end
  object ButtonSelectAll: TButton
    Left = 262
    Top = 201
    Width = 121
    Height = 32
    Anchors = [akLeft, akBottom]
    Caption = 'Select &all'
    ImageIndex = 3
    ImageName = 'Actions-edit-select-all-icon'
    Images = VirtualImageListButtons
    TabOrder = 3
    OnClick = ButtonSelectAllClick
  end
  object ButtonDeselectAll: TButton
    Left = 389
    Top = 201
    Width = 121
    Height = 32
    Anchors = [akLeft, akBottom]
    Caption = '&Deselect all'
    ImageIndex = 2
    ImageName = 'Actions-edit-clear-list-icon'
    Images = VirtualImageListButtons
    TabOrder = 4
    OnClick = ButtonDeselectAllClick
  end
  object VirtualImageListButtons: TVirtualImageList
    Images = <
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
      end>
    ImageCollection = dm_Icons.ImageCollection
    Width = 24
    Height = 24
    Left = 256
    Top = 128
  end
end
