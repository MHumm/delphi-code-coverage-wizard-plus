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
///   Ressource strings used in the main form
/// </summary>
unit MainFormTexts;

interface

resourcestring
  /// <summary>
  ///   Confirmation message shown when changing source file path
  /// </summary>
  rClearFileList = 'List of files selected for code coverage analysis ' + sLineBreak +
                   'is not empty. Changing the Delphi source file' + sLineBreak +
                   'directory will replace the lists contents.' + sLineBreak +
                   'Continue?';
  /// <summary>
  ///   Description text for the exe and map selection
  /// </summary>
  rUnitTestExe   = 'Select the DUnit/DUnitX executable to run for generating ' +
                   'the coverage report and the map file of this exe-file';
  /// <summary>
  ///   Description text for the source path and files selection
  /// </summary>
  rSourcePath    = 'Select the path where the source files to be analyzed are ' +
                   'stored. All .pas files under that directory will be listed ' +
                   'and the checked ones will be included in the analysis.';

  /// <summary>
  ///   Description text for the output path and options
  /// </summary>
  rOutputOptions = 'Specify the path where the report(s) should be saved to ' +
                   'and select the desired output formats. At least one format ' +
                   'must be selected.';

  /// <summary>
  ///   Description text for the misc. options and batch file previes
  /// </summary>
  rMiscOptions   = 'Provides the option to store all paths in relative form ' +
                   'and to preview the generated batch file.';
  /// <summary>
  ///   Description text for the save and run screen
  /// </summary>
  rSaveAndRun    = 'Allows to save the project and to directly run it.';

  /// <summary>
  ///   Failures displayed when selecting a source file failed
  /// </summary>
  rSelectionError= 'Failure selecting a source file:' + sLineBreak +'%0:s';

  /// <summary>
  ///   Failure if somebody added another card to the wizard but forgot to
  ///   add it to the button menu click logic.
  /// </summary>
  rUnknownMenu   = 'The menu item clicked has not been implemented ' + sLineBreak +
                   'in this menu''s logic yet. Index: %0:d';
  /// <summary>
  ///   Failure message shown when saving the project data to the XML file failed
  /// </summary>
  rSaveFileError = 'Failure saving project file.' + sLineBreak +
                   'Failure: %0:s' + sLineBreak +
                   'File name: %1:s';

  /// <summary>
  ///   Failure message shown when loading the project data from the XML file failed
  /// </summary>
  rLoadFileError = 'Failure loading project file.' + sLineBreak +
                   'Failure: %0:s' + sLineBreak +
                   'File name: %1:s';


implementation

end.
