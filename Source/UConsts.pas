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
///   Various constants
/// </summary>
unit UConsts;

interface

const
  /// <summary>
  ///   This is the file name for the overview HTML page of generated HTML output
  /// </summary>
  cHTMLOutputBaseFileName = 'CodeCoverage_summary.html';
  /// <summary>
  ///   This is the file name for the XML file of generated XML output
  /// </summary>
  cXMLOutputBaseFileName  = 'CodeCoverage_summary.xml';
  /// <summary>
  ///   This is the file name for the EMMA file of generated EMMA output
  /// </summary>
  cEMMAOutputBaseFileName = 'coverage.es';

  /// <summary>
  ///   File extension for map files
  /// </summary>
  cMapFileExt             = '.map';

  /// <summary>
  ///   File extension for source code files
  /// </summary>
  cSourceExt              = '*.pas';

  /// <summary>
  ///   The name of the generated batch file consists of the project file's name
  ///   and this suffix
  /// </summary>
  cBatchFileSuffix        = '_dcov_execute.bat';

implementation

end.
