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
    procedure FormCreate(Sender: TObject);
    procedure LinkLabelDCCWPGithubLinkClick(Sender: TObject; const Link: string;
      LinkType: TSysLinkType);
  private
    /// <summary>
    ///   Retrieves the file version from the version ressources
    /// </summary>
    /// <param name="FileName">
    ///   Name of the exe/dll to retrieve the version from
    /// </param>
    /// <returns>
    ///   Version information in the form of V<Major>.<Minor>.<Release> build <Build>
    /// </returns>
    function GetFileVersion(const FileName: TFileName): string;
  public
  end;

var
  FormAbout: TFormAbout;

implementation

uses
  Winapi.ShellAPI;

{$R *.dfm}

procedure TFormAbout.FormCreate(Sender: TObject);
begin
  try
    LabelVersion.Caption := GetFileVersion(Application.ExeName);
  except
    on e:Exception do
      LabelVersion.Caption := 'Failure: ' + e.Message;
  end;
end;

function TFormAbout.GetFileVersion(const FileName: TFileName): string;
var
  VerInfoSize: Cardinal;
  VerValueSize: Cardinal;
  Dummy: Cardinal;
  PVerInfo: Pointer;
  PVerValue: PVSFixedFileInfo;
begin
  Result := '';
  VerInfoSize := GetFileVersionInfoSize(PChar(FileName), Dummy);
  GetMem(PVerInfo, VerInfoSize);
  try
    if GetFileVersionInfo(PChar(FileName), 0, VerInfoSize, PVerInfo) then
      if VerQueryValue(PVerInfo, '\', Pointer(PVerValue), VerValueSize) then
        with PVerValue^ do
          Result := Format('V%d.%d.%d build %d', [
            HiWord(dwFileVersionMS), //Major
            LoWord(dwFileVersionMS), //Minor
            HiWord(dwFileVersionLS), //Release
            LoWord(dwFileVersionLS)]); //Build
  finally
    FreeMem(PVerInfo, VerInfoSize);
  end;
end;

procedure TFormAbout.LinkLabelDCCWPGithubLinkClick(Sender: TObject; const Link: string;
  LinkType: TSysLinkType);
begin
  ShellExecute(Handle, 'open', PWideChar(Link), nil, nil, SW_MAXIMIZE);
end;

end.
