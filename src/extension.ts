import * as vscode from 'vscode';

export function activate(context: vscode.ExtensionContext) {
  let disposable = vscode.commands.registerCommand('extension.getVbaSubName', () => {
    const editor = vscode.window.activeTextEditor;
    if (editor) {
      const document = editor.document;
      const selection = editor.selection;
      const position = selection.active;

      let startLine = position.line;
      while (startLine >= 0) {
        const lineText = document.lineAt(startLine).text;
        const match = lineText.match(/Sub (\w+)/);
        if (match && match[1]) {
          // Found the subroutine name
          vscode.window.showInformationMessage(`Subroutine: ${match[1]}`);
          break;
        }
        startLine--;
      }

      if (startLine < 0) {
        vscode.window.showErrorMessage('No subroutine found above the current line.');
      }
    }
  });

  context.subscriptions.push(disposable);
}
