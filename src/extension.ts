import * as vscode from 'vscode';
import * as resources from './resources';

const window = vscode.window;
const activeTextEditor = window.activeTextEditor;

let startLine: number;
let document: vscode.TextDocument;
let text: string;

// if (activeTextEditor) {
//   startLine = activeTextEditor.selection.active.line;
//   document = activeTextEditor.document;
//   text = document.lineAt(startLine).text;
// }
/**
 * This function is called when the extension is activated.
 * @param {vscode.ExtensionContext} context - The extension context.
 */
export function activate(context: vscode.ExtensionContext): void {
  /**
   * Find and display the name of the nearest VBA subroutine.
   */
  function findSubFunction(): void {
    // Check if there is an active text editor.
    if (activeTextEditor) {
      // Get the current line number of the cursor's position.

      // Search for the nearest VBA subroutine by moving upwards in the code.
      while (startLine >= 0) {
        // Extract and match the VBA subroutine name using the defined regular expression.
        const match = text.match(resources.regexPattern);

        // If a match is found and it has a captured group (subroutine name), display it.
        if (match && match[1]) {
          // window.showInformationMessage(`${resources.subroutine} ${match[1]}`);
          break;
        }

        // Move to the previous line.
        startLine--;
      }

      // If no subroutine is found above the current line, show an error message.
      if (startLine < 0) {
        window.showErrorMessage(resources.errorLine);
      }
    }
  }

  // Register the extension's command and associate it with the findSubFunction function.
  let disposable = vscode.commands.registerCommand(resources.getVbaSubName, findSubFunction);

  // Add the command to the context's subscriptions to ensure it's cleaned up when the extension is deactivated.
  context.subscriptions.push(disposable);
}
