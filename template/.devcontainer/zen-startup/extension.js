const vscode = require('vscode');

async function activate(context) {
  await new Promise(r => setTimeout(r, 2000));

  try {
    await vscode.commands.executeCommand('workbench.action.terminal.new');
    await new Promise(r => setTimeout(r, 500));
    await vscode.commands.executeCommand('workbench.action.closeAllEditors');
    await vscode.commands.executeCommand('workbench.action.closeSidebar');
    await vscode.commands.executeCommand('workbench.action.closeAuxiliaryBar');
    await new Promise(r => setTimeout(r, 300));
    await vscode.commands.executeCommand('workbench.action.toggleMaximizedPanel');
  } catch (err) {
    vscode.window.showWarningMessage(`PM Launcher setup failed: ${err.message}`);
  }
}

function deactivate() {}

module.exports = { activate, deactivate };
