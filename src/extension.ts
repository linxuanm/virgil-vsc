import * as path from "path";
import * as vscode from 'vscode';
import {
  LanguageClient,
  type LanguageClientOptions,
  type ServerOptions,
} from "vscode-languageclient/node";

let client: LanguageClient | null = null;

// This method is called when your extension is activated
// Your extension is activated the very first time the command is executed
export async function activate(context: vscode.ExtensionContext) {
	if (client !== null) {
		vscode.window.showWarningMessage("Virgil LSP client is already running.");
		return;
	}
	const lspPath = context.asAbsolutePath(path.join('out', 'virgil-lsp'));
	const serverOpts: ServerOptions = { command: lspPath };
	console.log(`Starting LSP executable: ${lspPath}`);

	const clientOpts: LanguageClientOptions = {
		documentSelector: [{ scheme: "file", language: "virgil" }],
	};

	client = new LanguageClient("virgil-vsc", serverOpts, clientOpts);
  await client.start();

	vscode.window.showInformationMessage('Virgil started.');
}

// This method is called when your extension is deactivated
export function deactivate() {}
