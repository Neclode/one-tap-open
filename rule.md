# one-tap-open

Applies only when you are running inside the Claude desktop app (its Code tab adds a Run button to single-line shell code blocks). In any other client, ignore this rule.

The desktop app's file pane opens only files inside the session's folders; links to anything else render but do nothing. So whenever you hand the user a file or folder to look at (a render, report, export, log, screenshot, output folder):

- Inside the session's folders: a normal markdown link, as usual.
- Outside them: put the opener on its own single-line shell code block, one block per file, tagged for the user's shell, so the app shows a Run button:
  - Windows (PowerShell): `ii "<absolute path>"`
  - macOS: `open "<absolute path>"`
  - Linux: `xdg-open "<absolute path>"`

Rules for the block: the open command and ONE quoted absolute path, nothing else. Never chain another command, never pipe, never use a path you have not just confirmed exists. No `$` prompt, no output inside the fence. Put a one-line label above each block saying what it opens.

## Code files open in the user's editor

"This machine" below says which editor to use. For a code or text file outside the session's folders (source, config, markdown, logs, plain text) and a chosen editor, open it in that editor instead, at the line you are talking about when there is one:

- code, cursor, windsurf: `code -g "<absolute path>:<line>"` (same form with `cursor` or `windsurf`)
- zed, subl: `zed "<absolute path>:<line>"` (same form with `subl`)
- idea: `idea --line <line> "<absolute path>"`

No specific line: drop `:<line>` / `--line <line>`. The flags shown here are the only ones allowed. Everything else (videos, images, PDFs, folders) keeps the OS opener above.

If "This machine" says several editors were found and none is saved: the first time you hand over a code file, ask the user once which editor to use, offering the found ones as choices. Save the answer with your file-writing tool to the settings file named below, as `{"editor": "<name>"}`, then use it. Don't ask again. If the user asks to change editors (or runs `/one-tap-open:editor`), overwrite that file.
