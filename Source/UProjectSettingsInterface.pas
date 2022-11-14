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
///   Interface to some output settings of a project file
/// </summary>
unit UProjectSettingsInterface;

interface

uses
  System.SysUtils;

type
  /// <summary>
  ///   Interface to some output settings of a project file
  /// </summary>
  IProjectOutputSettings = interface(IInterface)
    /// <summary>
    ///   When true the generated EMMA file shall be displayed in an associated
    ///   external viewer
    /// </summary>
    function GetDisplayEMMAFileExt: Boolean;
    /// <summary>
    ///   When true the generated XML file shall be displayed in an associated
    ///   external viewer
    /// </summary>
    function GetDisplayXMLFileExt: Boolean;
    /// <summary>
    ///   When true the generated HTML file shall be displayed in an associated
    ///   external viewer
    /// </summary>
    function GetDisplayHTMLFileExt: Boolean;
    /// <summary>
    ///   Returns the name of the loaded or saved project file
    /// </summary>
    function GetFileName: string;
    /// <summary>
    ///   Returns the defined path where the generated reports will be saved to
    /// </summary>
    function GetReportOutputPath: TFilename;

    /// <summary>
    ///   Displays the newly generated XML-file in the associated viewer
    ///   via ShellExecute
    /// </summary>
    property DisplayEMMAFileExt : Boolean
      read   GetDisplayEMMAFileExt;
    /// <summary>
    ///   Displays the newly generated XML-file in the associated viewer
    ///   via ShellExecute
    /// </summary>
    property DisplayXMLFileExt : Boolean
      read   GetDisplayXMLFileExt;
    /// <summary>
    ///   Displays the newly generated XML-file in the associated viewer
    ///   via ShellExecute
    /// </summary>
    property  DisplayHTMLFileExt : Boolean
      read    GetDisplayHTMLFileExt;
    /// <summary>
    ///   Path and name of the loaded or saved project file. Empty if no file
    ///   has been loaded or saved yet.
    /// </summary>
    property FileName : string
      read   GetFileName;

    /// <summary>
    ///   Path where the report(s) will be output to.
    /// </summary>
    property ReportOutputPath : TFilename
      read   GetReportOutputPath;
  end;

implementation

end.
