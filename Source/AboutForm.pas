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
///   Copyright dialog
/// </summary>
unit AboutForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UDataModuleIcons, Vcl.StdCtrls,
  Vcl.ExtCtrls, System.ImageList, Vcl.ImgList, Vcl.VirtualImageList,
  Vcl.VirtualImage;

type
  /// <summary>
  ///   Copyright dialog
  /// </summary>
  TFormAbout = class(TForm)
    PanelBottom: TPanel;
    ButtonOK: TButton;
    VirtualImageList32: TVirtualImageList;
    VirtualImage1: TVirtualImage;
    Label1: TLabel;
    Label2: TLabel;
    LabelVersion: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    LinkLabelOldDCCWSourceforge: TLinkLabel;
    LinkLabelDCCGithub: TLinkLabel;
    LinkLabelDCCWPGithub: TLinkLabel;
    Label5: TLabel;
    LabelCmdLineParams: TLabel;
    procedure LinkLabelDCCWPGithubLinkClick(Sender: TObject; const Link: string;
      LinkType: TSysLinkType);
  private
  public
    /// <summary>
    ///   Creates the form and initializes the application version label
    /// </summary>
    /// <param name="AOwner">
    ///   Owner of the form, also determining its position
    /// </param>
    /// <param name="Version">
    ///   Program version
    /// </param>
    constructor Create(AOwner: TComponent;
                       const Version : string); reintroduce;
  end;

implementation

uses
  System.UITypes,
  WinApi.ShellAPI;

{$R *.dfm}

resourcestring
  /// <summary>
  ///   Failure message shown when shellexecuting a link failed
  /// </summary>
  rLinkFailure = 'Failure opening the link. Code: %0:d';

constructor TFormAbout.Create(AOwner: TComponent; const Version: string);
begin
  inherited Create(AOwner);

  LabelVersion.Caption := Version;
end;

procedure TFormAbout.LinkLabelDCCWPGithubLinkClick(Sender: TObject; const Link: string;
  LinkType: TSysLinkType);
var
  FailureCode : NativeInt;
begin
  FailureCode := ShellExecute(Handle, 'open', PWideChar(Link), nil, nil, SW_MAXIMIZE);
  if FailureCode < 33 then
    MessageDlg(Format(rLinkFailure, [FailureCode]), mtError, [mbOK], -1);
end;

end.
