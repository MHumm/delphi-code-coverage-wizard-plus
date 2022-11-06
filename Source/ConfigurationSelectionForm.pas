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

// Origin of this source file: https://github.com/MHumm/AddIDETool
unit ConfigurationSelectionForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.StdCtrls, UAddIDETool, System.ImageList, Vcl.ImgList,
  Vcl.VirtualImageList, UDataModuleIcons;

type
  /// <summary>
  ///   Form for selecting Rad Studio versions/configurations
  /// </summary>
  TConfigSelectionForm = class(TForm)
    LabelDescription: TLabel;
    ListViewConfigurations: TListView;
    ButtonOK: TButton;
    ButtonCancel: TButton;
    ButtonSelectAll: TButton;
    ButtonDeselectAll: TButton;
    VirtualImageListButtons: TVirtualImageList;
    procedure ButtonSelectAllClick(Sender: TObject);
    procedure ButtonDeselectAllClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
  private
    /// <summary>
    ///   Business logic for managing the registry entries
    /// </summary>
    FIDEToolMgr      : TAddIDETool;
    /// <summary>
    ///   Complete path and file name of the entry to add
    /// </summary>
    FEntryPath       : string;
    /// <summary>
    ///   Display name of the entry for the tools menu
    /// </summary>
    FEntryName       : string;
    /// <summary>
    ///   Command line params used when calling the entry
    /// </summary>
    FEntryParams     : string;
    /// <summary>
    ///   Working dir used when calling the entry
    /// </summary>
    FEntryWorkingDir : string;
  public
    /// <summary>
    ///   Initialize the displayed list
    /// </summary>
    /// <param name="AOwner">
    ///   Owner responsible for managing lifetime
    /// </param>
    /// <param name="EntryName">
    ///   Display name of the entry for the tools menu as to be shown in
    ///   description text
    /// </param>
    /// <param name="EntryPath">
    ///   Complete path and file name of the entry to add
    /// </param>
    /// <param name="EntryParams">
    ///   Command line params used when calling the entry
    /// </param>
    /// <param name="EntryWorkingDir">
    ///   Working dir used when calling the entry
    /// </param>
    constructor Create(AOwner          : TComponent;
                       EntryName,
                       EntryPath,
                       EntryParams,
                       EntryWorkingDir : string); reintroduce;
  end;

var
  ConfigSelectionForm: TConfigSelectionForm;

implementation

{$R *.dfm}

procedure TConfigSelectionForm.ButtonDeselectAllClick(Sender: TObject);
var
  Item : TListItem;
begin
  for Item in ListViewConfigurations.Items do
    Item.Checked := false;
end;

procedure TConfigSelectionForm.ButtonOKClick(Sender: TObject);
var
  i         : Integer;
  Item      : TListItem;
  AddList   : TIDEVersionList;
begin
  // Delete all entries
  AddList := FIDEToolMgr.GetIDEVersionsList;
  // This would add it to all IDE configurations but...
  FIDEToolMgr.DeleteTool(FEntryPath, AddList);

  // here we remove those not selected from the list
  for i := ListViewConfigurations.Items.Count - 1 downTo 0 do
  begin
    Item := ListViewConfigurations.Items[i];
    if not Item.Checked then
      AddList.Delete(Item.Index);
  end;

  FIDEToolMgr.AddTool(FEntryParams,
                      FEntryPath,
                      FEntryName,
                      FEntryWorkingDir,
                      AddList);
end;

procedure TConfigSelectionForm.ButtonSelectAllClick(Sender: TObject);
var
  Item : TListItem;
begin
  for Item in ListViewConfigurations.Items do
    Item.Checked := true;
end;

constructor TConfigSelectionForm.Create(AOwner         : TComponent;
                                        EntryName,
                                        EntryPath,
                                        EntryParams,
                                        EntryWorkingDir: string);
var
  IDEConfigList : TIDEVersionList;
  IDEConfig     : TIDEVersionRec;
  Item          : TListItem;
begin
  inherited Create(AOwner);

  LabelDescription.Caption := Format(LabelDescription.Caption, [EntryName]);

  FEntryName       := EntryName;
  FEntryPath       := EntryPath;
  FEntryParams     := EntryParams;
  FEntryWorkingDir := EntryWorkingDir;

  FIDEToolMgr   := TAddIDETool.Create;
  IDEConfigList := FIDEToolMgr.GetIDEVersionsList;
  for IDEConfig in IDEConfigList do
  begin
    Item := ListViewConfigurations.Items.Add;
    Item.Caption := IDEConfig.GetIDEVersionName;

    if (IDEConfig.ConfigRootKey <> 'BDS') then
      Item.SubItems.Add(IDEConfig.ConfigRootKey);

    Item.Checked := FIDEToolMgr.IsInMenu(EntryPath, IDECOnfig.GetConfigKey);
  end;
end;

procedure TConfigSelectionForm.FormDestroy(Sender: TObject);
begin
  FIDEToolMgr.Free;
end;

end.
